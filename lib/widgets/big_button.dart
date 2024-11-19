import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(68),
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              text,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
      ),
    );
  }
}
