import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final int id;
  final double width;
  final double? height;
  final String title;
  final String label;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap; // Callback function for tap

  const PlaceCard({
    Key? key,
    required this.title,
    required this.id,
    required this.width,
    required this.label,
    this.height,
    required this.subtitle,
    required this.imageUrl,
    this.onTap, // Initialize the callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Set the onTap callback
      child: Hero(
        tag: 'place-$id',
        child: Material( 
          child: Container(
          width: width,
          height: height,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(imageUrl),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
            fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color(0xFFEEEEEE), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  label,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.white), overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      )
      ),
    );
  }
}
