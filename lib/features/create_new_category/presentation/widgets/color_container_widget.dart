import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ColorContainerWidget extends StatelessWidget {
  const ColorContainerWidget(
      {super.key, required this.color, this.selectedColor});

  final int? selectedColor;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: selectedColor != null
          ? Stack(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset("assets/icons/check_mark.svg"),
                ),
              ],
            )
          : Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}
