

import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed; // VoidCallback = type = dokumentasi
// Button tidak mengambil input langsung dari user -> tidak perlu controller
// hanya onPressed ketika di tekan;

  const CustomTextButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }): super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed, 
      child: Text(widget.label)
    );
  }
}