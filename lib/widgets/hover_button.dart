import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Color borderColor;
  final Function() onTap;

  const HoverButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.borderColor,
      required this.onTap})
      : super(key: key);

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      child: InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          setState(() {
            isHovering = value;
          });
        },
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          height: 34,
          margin: EdgeInsets.symmetric(vertical: 11, horizontal: 4),
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: widget.buttonColor,
            border: isHovering
                ? Border.all(
                    color: widget.borderColor,
                    width: 0,
                  )
                : null,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3c4043),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
