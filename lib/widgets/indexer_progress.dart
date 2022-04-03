import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../src/library/indexer.dart';

class IndexerProgressWidget extends StatelessWidget {
  const IndexerProgressWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: TheIndexer.progress,
      builder: (context, state) {
        final IndexerProgressReport? report = (state.data is IndexerProgressReport? ? state.data : null) as IndexerProgressReport?;
        return Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: report == null || report.state == IndexerState.FINISHED ? 
                state.hasError || report?.state == IndexerState.STOPPED ? const Icon(MdiIcons.alertCircle, color: Colors.red)
                : const Icon(MdiIcons.check, color: Colors.green) : const Icon(MdiIcons.magnify, color: Colors.blue)
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      report == null || report.state == IndexerState.FINISHED ? 
                      state.hasError ? Text("An error occurred", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.red))
                      : Text("Library is up to date", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.green))
                      : report.state == IndexerState.STARTING ? Text("Finding your music", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                      : report.state == IndexerState.FETCHING ? Text("Googling your music", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                                                                /* May I note that, especially here,
                                                                    the term "googling" is inaccurate?
                                                                    That's because I'm not using Google
                                                                    at all for these searches. */
                      : report.state == IndexerState.SCANNING ? Text("Scanning your music", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                      : report.state == IndexerState.ANALYZING ? Text("Grouping your music", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                      : report.state == IndexerState.FINISHING ? Text("Almost done", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                      : report.state == IndexerState.CLEANING ? Text("Cleaning up", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue))
                      : Text("Almost done", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.blue)),
                      if (state.hasError) Text(state.error!.toString(), style: Theme.of(context).textTheme.bodyText2)
                      else if (report?.currentFilename != null) Text(report!.currentFilename!, style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                ),
              )
            ],
          ),
          if (report?.state != IndexerState.FINISHED) Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (report?.max != null && report!.max > 0) Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  report.value.toString() + " / " + report.max.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
          if (report != null && report.state != IndexerState.FINISHED) LinearProgressIndicator(
            value: report.max > 0 ? report.value / report.max : null,
          )
        ]);
      },
    );
  }
}