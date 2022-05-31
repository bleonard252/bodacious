import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MPVMissingCrash extends StatefulWidget {
  const MPVMissingCrash({ Key? key }) : super(key: key);

  @override
  State<MPVMissingCrash> createState() => _MPVMissingCrashState();
}

class _MPVMissingCrashState extends State<MPVMissingCrash> {
  bool errorPineappleClicked = false;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: ThemeData.dark(),
        child: Material(
          color: Colors.black,
          child: Center(
            child: Container(
              //color: Colors.black,
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!errorPineappleClicked) ...[
                    GestureDetector(
                      onTap: () => setState(() => errorPineappleClicked = true),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 1),
                        child: Image(image: AssetImage("assets/error_pineapple.png"), width: 140, height: 140),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(MdiIcons.closeCircle, color: Colors.red),
                    ),
                    Text("MPV is not installed.\nSee https://kutt.it/jaMPVi for instructions.\n\n"
                    "MPV is currently required to use Bodacious on this device.", textAlign: TextAlign.center, style: ThemeData.dark().textTheme.bodyText1?.copyWith(color: Colors.red))
                  ] else ...[
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Image(image: AssetImage("assets/error_pineapple_excited.png"), width: 140, height: 140),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(MdiIcons.checkCircle, color: Colors.green),
                    ),
                    Text("Ooooh attention! Yummy yummy yes yes yes!", textAlign: TextAlign.center, style: ThemeData.dark().textTheme.bodyText1?.copyWith(color: Colors.green))
                  ]
                ]
              ),
            )
          ),
        ),
      ),
    );
  }
}