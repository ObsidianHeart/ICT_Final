import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final bool isLoading;
  const MyButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF2F0046),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          minimumSize: const Size(200.0, 50.0),
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Urbanest',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
