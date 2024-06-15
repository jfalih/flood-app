import 'package:flutter/material.dart';
import 'package:flood/data/models/receipt_model.dart';

class StatusLabel extends StatelessWidget {
  final String status;

  StatusLabel({required this.status});

  // Method to return the appropriate widget based on status
  Widget getStatusWidget(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    switch (status.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.orange;
        textColor = Colors.white;
        break;
      case 'expired':
        backgroundColor = Colors.red;
        textColor = Colors.white;
        break;
      case 'active':
        backgroundColor = Colors.green;
        textColor = Colors.white;
        break;
      default:
        backgroundColor = Colors.grey; // Default color
        textColor = Colors.black;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: backgroundColor,
      ),
      padding: EdgeInsets.all(10),
      child: Text(
        status.toUpperCase(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getStatusWidget(context);
  }
}
