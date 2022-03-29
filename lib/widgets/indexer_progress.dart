import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../src/library/indexer.dart';

class IndexerProgressWidget extends StatelessWidget {
  const IndexerProgressWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TheIndexer.progressReceiver,
      builder: (context, state) {
        final IndexerProgressReport? report = (state.data is IndexerProgressReport? ? state.data : null) as IndexerProgressReport?;
        return Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: report == null || report.state == IndexerState.FINISHED ? 
                state.hasError || report?.state == IndexerState.STOPPED ? const Icon(MdiIcons.alertCircle, color: Colors.red)
                : const Icon(MdiIcons.check, color: Colors.green) : const Icon(MdiIcons.magnify, color: Colors.blue)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  report == null || report.state == IndexerState.FINISHED ? 
                  state.hasError ? Text("An error occurred", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.red))
                  : Text("Library is up to date", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.green))
                  : report.state == IndexerState.STARTING ? Text("Finding your music", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                  : report.state == IndexerState.SCANNING ? Text("Scanning your music", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                  : report.state == IndexerState.FINISHING ? Text("Almost done", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                  : report.state == IndexerState.CLEANING ? Text("Cleaning up", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                  : Text("Almost done", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue)),
                  if (state.hasError) Text(state.error!.toString(), style: Theme.of(context).textTheme.bodyText2)
                  else if (report?.currentFilename != null) Text(report!.currentFilename!, style: Theme.of(context).textTheme.bodyText2)
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (report?.max != null) Text(report!.value.toString() + " / " + report.max.toString())
            ],
          ),
          LinearProgressIndicator(
            value: report?.max != null && report!.max > 0 ? report.value / report.max : 0,
          )
        ]);
      },
    );
  }
}