import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CoverPlaceholder extends StatelessWidget {
  final int? size;
  final int? iconSize;
  const CoverPlaceholder({ Key? key, required this.size, this.iconSize }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size?.toDouble(),
      width: size?.toDouble(),
      child: Center(
        child: Icon(MdiIcons.musicBoxOutline, color: Colors.grey[700], size: iconSize?.toDouble() ?? size!/2)
      ),
      color: Colors.grey,
    );
  }
}