import 'dart:io';
import 'dart:math';

import 'package:bodacious/main.dart';
import 'package:flutter/material.dart';
import 'package:pinelogger/pinelogger.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

enum LogViewFilter {
  justAudio,
  mpv,
  nowPlayingProvider,
  indexer,
}

class _LogViewState extends State<LogView> {
  /// Filters applied to the log view.
  List<LogViewFilter> filters = [...LogViewFilter.values];
  Severity minSeverity = const Severity.all();

  @override
  Widget build(BuildContext context) {
    final logs = appLogger;
    final filteredLogs = logs.messages.where((log) {
      isSevereEnough() => log.severity >= minSeverity;
      final crumb = log.logger.name.split(".");

      if (crumb[0] == "nowPlayingProvider") {
        if (filters.contains(LogViewFilter.nowPlayingProvider)) {
          return isSevereEnough();
        } else {
          return false;
        }
      }
      if (crumb[0] == "Indexer") {
        if (filters.contains(LogViewFilter.indexer)) {
          return isSevereEnough();
        } else {
          return false;
        }
      }
      if (crumb[0] == "just_audio_mpv") {
        if (filters.contains(LogViewFilter.mpv)) {
          return isSevereEnough();
        } else {
          return false;
        }
      }
      return true;
    }).toList();

    return Theme(
      data: ThemeData.dark(useMaterial3: false).copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0.0,
        ), colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.dark,
          backgroundColor: Colors.black,
          accentColor: Colors.redAccent,
        ).copyWith(background: Colors.black),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Logs"),
          actions: [
            IconButton(
              tooltip: "Minimum severity",
              onPressed: () {
                final List<Severity> allKnown = [
                  const Severity.all(),
                  ...Severity.values,
                  ...logs.messages.map((e) => e.severity)
                ].unique((element) => element.index)..sort((a, b) => a.index.compareTo(b.index));

                showModalBottomSheet(context: context, builder: (context) {
                  return ListView.builder(
                    itemCount: allKnown.length,
                    itemBuilder: (context, index) {
                      final severity = allKnown[index];
                      return RadioListTile<int>(
                        title: Text(severity.name),
                        //secondary: Text(severity.index.toString()),
                        value: severity.index,
                        groupValue: minSeverity.index,
                        onChanged: (value) {
                          setState(() {
                            minSeverity = allKnown.firstWhere((element) => element.index == value, orElse: () => const Severity.all());
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                });
              },
              icon: const Icon(Icons.sort)
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text("Now Playing"),
                      onSelected: (value) => setState(() {
                        if (value) {
                          filters.add(LogViewFilter.nowPlayingProvider);
                        } else {
                          filters.remove(LogViewFilter.nowPlayingProvider);
                        }
                      }),
                      selected: filters.contains(LogViewFilter.nowPlayingProvider),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text("The Indexer"),
                      onSelected: (value) => setState(() {
                        if (value) {
                          filters.add(LogViewFilter.indexer);
                        } else {
                          filters.remove(LogViewFilter.indexer);
                        }
                      }),
                      selected: filters.contains(LogViewFilter.indexer),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text("Audio Player"),
                      onSelected: (value) => setState(() {
                        if (value) {
                          filters.add(LogViewFilter.justAudio);
                        } else {
                          filters.remove(LogViewFilter.justAudio);
                        }
                      }),
                      selected: filters.contains(LogViewFilter.justAudio),
                    ),
                  ),
                  if (Platform.isLinux) Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilterChip(
                      label: const Text("MPV"),
                      onSelected: (value) => setState(() {
                        if (value) {
                          filters.add(LogViewFilter.mpv);
                        } else {
                          filters.remove(LogViewFilter.mpv);
                        }
                      }),
                      selected: filters.contains(LogViewFilter.mpv),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: logs.stream,
                builder: (context, snapshot) => ListView.builder(
                  reverse: true,
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs.reversed.elementAt(index);
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(log.logger.name, style: Theme.of(context).textTheme.bodySmall),
                          if (log.message is String || log.message is Error) Text(log.message, style: TextStyle(color: log.severity.color, fontFamily: 'monospace'), maxLines: 2, overflow: TextOverflow.fade)
                          else Text("Something happened", style: TextStyle(color: log.severity.color)),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text(log.level.toString()),
                          if (log.error is String) Text(log.error as String)
                          else if (log.error != null) Text(log.error.toString(), style: const TextStyle(fontFamily: 'monospace'), maxLines: 3, overflow: TextOverflow.fade),
                          Text("${log.severity.shortName} @ ${log.timestamp.toIso8601String()}", style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(log.message.toString().substring(0, min<int>(32, log.message.length)), style: TextStyle(color: log.severity.color)),
                            content: SingleChildScrollView(
                              //mainAxisSize: MainAxisSize.min,
                              primary: false,
                              child: Text((log.stackTrace ?? log.object ?? log.error ?? "Nothing to show").toString(), style: const TextStyle(fontFamily: "monospace")),
                            ),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}

extension on Severity {
  String get shortName => this == Severity.info
    ? "I"
    : this == Severity.warning
    ? "W"
    : this == Severity.error
    ? "E"
    : this == Severity.debug
    ? "D"
    : this == Severity.verbose
    ? "V"
    : name.characters.first.toUpperCase();
  Color get color => this == Severity.info
    ? Colors.blue
    : this == Severity.warning
    ? Colors.yellow
    : this == Severity.error
    ? Colors.red
    : this == Severity.debug
    ? Colors.blueGrey
    : this == Severity.verbose
    ? Colors.purple
    : Colors.grey;
}

extension Unique<E, Id> on List<E> {
  List<E> unique([Id Function(E element)? id, bool inplace = true]) {
    final ids = <dynamic>{};
    var list = inplace ? this : List<E>.from(this);
    list.retainWhere((x) => ids.add(id != null ? id(x) : x as Id));
    return list;
  }
}
