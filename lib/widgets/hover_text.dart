import 'package:flutter/material.dart';

class HoverText extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final TextStyle? textStyle;

  const HoverText({
    Key? key,
    required this.text,
    this.onTap,
    this.textStyle,
  }) : super(key: key);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _showUnderLine = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: widget.onTap,
      onHover: (hovering) {
        setState(() {
          _showUnderLine = hovering;
        });
      },
      child: Text(
        widget.text,
        style: widget.textStyle != null
            ? widget.textStyle?.copyWith(
                decoration: _showUnderLine
                    ? TextDecoration.underline
                    : TextDecoration.none)
            : TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
                fontSize: 13,
                decoration: _showUnderLine
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
      ),
    );
  }
}
