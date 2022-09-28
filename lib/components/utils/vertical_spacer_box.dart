import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/app_enums.dart';
import 'package:thunderapp/shared/constants/app_number_constants.dart';

class VerticalSpacerBox extends StatelessWidget {
  const VerticalSpacerBox({Key? key, required this.size}) : super(key: key);
  final SpacerSize size;
  @override
  Widget build(BuildContext context) {
    switch (size) {
      case SpacerSize.tiny:
        return const SizedBox(
          height: kTinySize,
        );
      case SpacerSize.small:
        return const SizedBox(
          height: kSmallSize,
        );
      case SpacerSize.medium:
        return const SizedBox(
          height: kMediumSize,
        );
      case SpacerSize.large:
        return const SizedBox(
          height: kLargeSize,
        );
      case SpacerSize.huge:
        return const SizedBox(
          height: kHugeSize,
        );
      default:
        return const SizedBox(
          height: kSmallSize,
        );
    }
  }
}
