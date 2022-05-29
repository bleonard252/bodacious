import 'dart:math';
import 'dart:ui';

extension OnColor on Color {
  Color get onColor {
    //return const Color(0);
    final hsp = sqrt(
      0.299 * (red * red) +
      0.587 * (green * green) +
      0.114 * (blue * blue)
    );
    return (hsp > 127.5) ? const Color(0xff000000) : const Color(0xffffffff);
  }

}