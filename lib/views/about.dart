import 'dart:ui';

import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyLarge ?? const TextStyle(),
      child: Center(
        child: Container(
          color: Colors.amber[400],
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(child: Image.asset("assets/bubblebg.png",
                fit: BoxFit.fill,
                //width: (context.findRenderObject() as RenderBox?)?.size.width ?? MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                //errorBuilder: (context, error, trace) => Container(color: Colors.red),
              )),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 72, sigmaY: 72),
                  blendMode: BlendMode.src,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 240,
                          width: 240,
                          child: Center(child: Image.asset("assets/brand/ic_foreground.png", fit: BoxFit.contain))
                        ),
                        const SizedBox(height: 24),
                        Card(
                          color: Theme.of(context).colorScheme.surfaceTint.withAlpha(64),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FutureBuilder<String>(
                              initialData: "loading",
                              future: DefaultAssetBundle.of(context).loadString("assets/version.txt"),
                              builder: (context, snapshot) => Text("Version ${snapshot.data?.replaceAll("\n", "") ?? "loading"}",
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.onSurface),)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FilledButton(
                            onPressed: () => context.go("/licenses"),
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text("Licenses"),
                            ),
                          ),
                        ),
                        Card(
                          color: Theme.of(context).colorScheme.surface,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Made with Flutter and love at https://github.com/bleonard252/bodacious"),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}