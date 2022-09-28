import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPicRenderer extends StatelessWidget {
  const SvgPicRenderer({Key? key, required this.filePath, required this.width})
      : super(key: key);
  final String filePath;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      filePath,
      width: width,
    );
  }
}
