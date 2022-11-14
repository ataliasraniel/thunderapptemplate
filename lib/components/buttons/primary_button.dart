import 'package:flutter/material.dart';
import 'package:thunderapp/shared/constants/style_constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.customColor,
      this.hasIcon,
      this.icon,
      this.customTextColor})
      : super(key: key);
  final String text;
  final Function onPressed;
  final Color? customColor;
  final Color? customTextColor;
  final bool? hasIcon;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      child: hasIcon != null && hasIcon == true
          ? ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: customColor ?? kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48))),
              onPressed: () => onPressed(),
              icon: Icon(
                icon ?? Icons.done,
                color: kOnBackgroundColor,
              ),
              label: Text(
                text,
                style: kCaption2.copyWith(
                    color: customTextColor ?? kOnBackgroundColor),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: customColor ?? kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(48))),
              onPressed: () => onPressed(),
              child: Text(
                text,
                style: kCaption2.copyWith(
                    color: customTextColor ?? kOnBackgroundColor),
              ),
            ),
    );
  }
}
