import 'package:flutter/material.dart';
import 'package:to_day/theme/app_text_stly.dart';

class CustomFiledFile extends StatefulWidget {
  final String? hintText;
  final String? name;
  final int? Size;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool? redonly;
  final void Function()? onTap;
  const CustomFiledFile({
    super.key,
    this.hintText,
    this.Size,
    this.controller,
    this.name,
    this.validator,
    this.redonly,
    this.onTap,
      });

  @override
  State<CustomFiledFile> createState() => _CustomFiledFileState();
}

class _CustomFiledFileState extends State<CustomFiledFile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name ?? '', style: AppTextStyle.hintline),
          SizedBox(height: 12),

          TextFormField(
            readOnly:widget.redonly??false ,
            onTap: widget.onTap,
            maxLines: widget.Size,
            cursorColor: Colors.grey.shade200,
            controller: widget.controller,
            validator: widget.validator,
            onTapOutside: (A) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              hintText: widget.hintText ?? 'Enter your name  ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.red),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
