import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconatedButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double diameter;
  final double? size;
  final Function? onTap;
  const IconatedButton(this.icon, this.color, this.diameter,
      {this.size = 20, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {if(onTap != null) {onTap!();}},
      child: (ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(diameter)),
        child: Container(
            height: diameter,
            width: diameter,
            color: color,
            alignment: Alignment.center,
            child: Icon(
              icon,
              color: Colors.white,
              size: size,
            )),
      )),
    );
  }
}
