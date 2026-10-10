import 'package:flutter/material.dart';
import 'package:to_day/theme/app_text_stly.dart';

class CustomAppBottom extends StatefulWidget {
  final String title;
  //final Widget classe;
  final void Function()? onTap;

  const CustomAppBottom({
    super.key,
    required this.title,
    //required this.classe,
    this.onTap,
  });

  @override
  State<CustomAppBottom> createState() => _CustomAppBottomState();
}

class _CustomAppBottomState extends State<CustomAppBottom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Colors.indigoAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              widget.title,
              style: AppTextStyle.hintline.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
