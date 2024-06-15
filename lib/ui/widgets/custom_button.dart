import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text; // Text to display on the button
  final double height; // Height of the button

  const CustomButton({
    Key? key,
    this.height = 50.0, // Set default height to 50
    required this.onPress,
    required this.text, // Accept buttonText as a required parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height, // Use the height parameter here
      child: ElevatedButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the children in the Row
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ), // Use the buttonText prop here
            const SizedBox(width: 8),
            const Icon(Icons.arrow_circle_right_outlined),
          ],
        ),
      ),
    );
  }
}
