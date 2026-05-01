import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final Border? border;
  final BorderRadius? radius;
  const CustomButton({
    super.key,
    this.onPressed,
    this.buttonText,
    this.buttonColor,
    this.textStyle,
    this.width,
    this.height,
    this.border,
    this.radius,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed?.call();
      },
      child: Container(
        width: double.infinity,
        height: widget.height ?? 50,
        decoration: BoxDecoration(
          color: widget.buttonColor ?? Color(0xFF213598),
          border: widget.border,
          borderRadius: widget.radius ?? BorderRadius.circular(34),
        ),
        child: Center(
          child: Text(
            widget.buttonText ?? "",
            style:
                widget.textStyle ??
                TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
