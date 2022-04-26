import 'dart:ui';

import "package:flutter/material.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Center(child: Image.asset("assets/brand/ic_foreground.png", fit: BoxFit.contain))
            )
          )
        ]
      ),
    );
  }
}