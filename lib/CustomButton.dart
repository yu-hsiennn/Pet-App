import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final List<Color> tappedDownColors;
  final List<Color> regularColors;
  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.tappedDownColors = const [
      Color.fromRGBO(159, 89, 99, 1),
      Color.fromRGBO(168, 124, 94, 1),
    ],
    this.regularColors = const [
      Color.fromRGBO(96, 175, 245, 1),
      Color.fromRGBO(170, 227, 254, 1),
    ],
    this.height = 60,
    this.width,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isTappedDown = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isTappedDown = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isTappedDown = false;
          });
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() {
            _isTappedDown = false;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isTappedDown
                    ? widget.tappedDownColors
                    : widget.regularColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(25.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                )
              ]),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: widget.height,
          width: widget.width,
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: "Netflix",
                fontWeight: FontWeight.w600,
                fontSize: 18,
                letterSpacing: 0.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
