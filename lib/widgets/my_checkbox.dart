import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final String label;
  final bool value;
  final String alphabetOrNumber;
  final Function(bool status, String alpOrNumb)? onTotalSelectionChanged;
  const MyCheckBox(
      {super.key,
      required this.label,
      required this.value,
      required this.onTotalSelectionChanged,
      required this.alphabetOrNumber});

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool? myValue;

  @override
  void initState() {
    myValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.label),
        Checkbox(
          value: myValue,
          onChanged: (value) {
            setState(() {
              myValue = value;
            });
            if (myValue == true) {
              widget.onTotalSelectionChanged!(true, widget.alphabetOrNumber);
            } else {
              widget.onTotalSelectionChanged!(false, widget.alphabetOrNumber);
            }
          },
        ),
      ],
    );
  }
}
