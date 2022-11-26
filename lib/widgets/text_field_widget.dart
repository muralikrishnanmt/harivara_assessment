import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final void Function(String)? onChanged;
  const TextFieldWidget({
    super.key,
    required this.label,
    required this.textEditingController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
          ),
        ),
        SizedBox(
          width: 50,
          child: TextField(
            keyboardType: TextInputType.number,
            controller: textEditingController,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
