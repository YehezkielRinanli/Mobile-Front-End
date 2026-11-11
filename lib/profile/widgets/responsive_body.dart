import 'package:flutter/material.dart';

/// Batas lebar layar (dp) untuk berpindah dari layout sempit (ponsel
/// portrait) ke layout lebar (tablet / ponsel landscape).  [M07]
const double kWideBreakpoint = 700;

/// Membatasi lebar konten agar tidak melebar berlebihan di layar besar.
/// Parent (Align) memberi constraint longgar, ConstrainedBox menetapkan
/// batas maksimum untuk child.  [M07 - Constraint]
class ResponsiveBody extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveBody({
    super.key,
    required this.child,
    this.maxWidth = 720,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
