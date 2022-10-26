import 'dart:isolate';
import 'dart:math';

import 'package:pinelogger/pinelogger.dart';
import 'package:rxdart/rxdart.dart';

/// `IsolatedPinelogger`s are piped to a real [Pinelogger] in the main isolate via a [SendPort]/[ReceivePort] pair,
/// called the [IsolatedPinelogReceiver].
class IsolatedPinelogger implements Pinelogger {
  final SendPort sendPort;
  /// If set, [IsolatedPinelogReceiver] will add this to the logger's name using the same pattern as [Pinelogger.child].
  /// This is good for child loggers, but should be left null on the root logger, which has its ID set by the Receiver.
  final String? suffix;
  @override
  final Severity severity;

  IsolatedPinelogger(this.sendPort, {this.suffix, this.severity = Severity.info});

  @override
  Pinelogger child(String name, {Severity? severity}) {
    return IsolatedPinelogger(sendPort, suffix: suffix == null ? name : suffix!+"."+name, severity: severity ?? this.severity);
  }

  @override
  Pinelogger independentChild(String name, {Severity? severity}) {
    warning("[Pinelogger] Avoid using independent children in isolates. They are always prefixed with the receiver logger's name.");
    return IsolatedPinelogger(sendPort, suffix: name, severity: severity ?? this.severity);
  }

  _LoggerDetails get _details => _LoggerDetails(severity: severity, path: suffix);


  @override
  void verbose(message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    sendPort.send(_TransferMessage(message, Severity.verbose, _details, extraData: extraData, error: error, stackTrace: stackTrace));
  }

  @override
  void debug(message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    sendPort.send(_TransferMessage(message, Severity.debug, _details, extraData: extraData, error: error, stackTrace: stackTrace)); 
  }

  @override
  void info(message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    sendPort.send(_TransferMessage(message, Severity.info, _details, extraData: extraData, error: error, stackTrace: stackTrace)); 
  }

  @override
  void warning(message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    sendPort.send(_TransferMessage(message, Severity.warning, _details, extraData: extraData, error: error, stackTrace: stackTrace)); 
  }

  @override
  void error(message, {PinelogExtraData? extraData, Object? error, StackTrace? stackTrace}) {
    sendPort.send(_TransferMessage(message, Severity.error, _details, extraData: extraData, error: error, stackTrace: stackTrace)); 
  }

  @override
  void log(message, {Severity severity = Severity.info, PinelogExtraData? extraData, Object? error, StackTrace? stackTrace, bool logToTopParent = true}) {
    assert(logToTopParent, "logToTopParent should not be changed in an isolated logger. Its value is ultimately decided by the receiving logger.");
    sendPort.send(_TransferMessage(message, severity, _details, extraData: extraData, error: error, stackTrace: stackTrace)); 
  }

  @override
  List<PinelogMessage> get messages => throw UnimplementedError();

  @override
  String get name => "IsolatedPinelogger${suffix != null ? ".$suffix" : ""}";

  @override
  Pinelogger? get parent => throw UnimplementedError();

  @override
  PinelogPrinter get printer => throw UnimplementedError("The printer for an isolated Pinelogger is always the printer of its receiving Pinelogger");

  @override
  Stream<PinelogMessage> get stream => throw UnimplementedError();
  @override
  Pinelogger get topParent => throw UnimplementedError();

}

class _TransferMessage {
  dynamic message;
  Severity severity;
  _LoggerDetails logger;
  PinelogExtraData? extraData;
  Object? error;
  StackTrace? stackTrace;
  _TransferMessage(this.message, this.severity, this.logger, {
    this.extraData,
    this.error,
    this.stackTrace
  });
}
class _LoggerDetails {
  String? path;
  Severity severity;
  _LoggerDetails({
    this.path,
    required this.severity
  });
}

/// The receiving end of [IsolatedPinelogger]. It takes a [ReceivePort] and reads [_TransferMessage]s,
/// and transforms them into child Pineloggers and 
class IsolatedPinelogReceiver extends Pinelogger {
  final ReceivePort receivePort;

  // CONSTRUCTORS
  /// Creates a [IsolatedPinelogReceiver] as a child of another [Pinelogger].
  factory IsolatedPinelogReceiver.asChildOf(
    Pinelogger parent, {
      required ReceivePort receivePort,
      required String name,
      Severity? severity,
      PinelogPrinter? printer
    }) => IsolatedPinelogReceiver.asIndependentChildOf(
      parent,
      receivePort: receivePort,
      name: parent.name+"."+name,
      printer: printer ?? parent.printer,
      severity: severity ?? parent.severity
    );
  /// Creates a [IsolatedPinelogReceiver] as a child of another [Pinelogger], but resets the name chain.
  factory IsolatedPinelogReceiver.asIndependentChildOf(
    Pinelogger parent, {
      required ReceivePort receivePort,
      required String name,
      Severity? severity,
      PinelogPrinter? printer
    }) => IsolatedPinelogReceiver(
      name, receivePort,
      parent: parent,
      printer: printer ?? parent.printer,
      severity: severity ?? parent.severity
    );
  IsolatedPinelogReceiver(super.name, this.receivePort, {
    super.severity = Severity.info,
    super.printer = consolePrinter,
    super.parent
  }) {
    receivePort.listen((event) {
      if (event is _TransferMessage) {
        processTransfer(event);
      } else {
        warning("[Pinelogger] Received data not a log message!");
      }
    },
    onError: (error, stackTrace) {
      this.error("[Pinelogger] Unknown error occurred in an IsolatedPinelogReceiver", error: error, stackTrace: stackTrace);
    });
  }
  
  // CHILDBEARING
  @override
  IsolatedPinelogReceiver independentChild(String name, {Severity? severity}) {
    return IsolatedPinelogReceiver.asIndependentChildOf(this, receivePort: receivePort, name: name, severity: severity);
  }
  @override
  IsolatedPinelogReceiver child(String name, {Severity? severity}) {
    return independentChild(this.name+"."+name, severity: severity);
  }

  // ignore: prefer_final_fields
  /// Cached loggers used by [processTransfer]
  Map<String, Pinelogger> _loggers = {};

  void processTransfer(_TransferMessage message) {
    late final Pinelogger logger;
    if (_loggers.containsKey(message.logger.path??"")) {
      logger = _loggers[message.logger.path??""]!;
    } else if (message.logger.path?.isEmpty != false) {
      logger = this;
    } else {
      logger = child(message.logger.path!, severity: message.logger.severity);
      _loggers[message.logger.path!] = logger;
    }
    logger.log(message.message,
      severity: message.severity,
      error: message.error,
      extraData: message.extraData,
      stackTrace: message.stackTrace
    );
  }
}