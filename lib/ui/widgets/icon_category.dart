import 'package:flutter/material.dart';

class IconMapper {
  static final Map<String, IconData> _iconMap = {
    'im im-icon-Clinic': Icons.local_hospital,
    'im im-icon-Hospital': Icons.local_hospital,
    'im im-icon-Heart': Icons.favorite,
    'im im-icon-Doctor': Icons.person,
    'im im-icon-Stethoscope': Icons.medical_services,
  };

  static IconData getIcon(String iconName) {
    return _iconMap[iconName] ?? Icons.help; // Default to help icon if not found
  }
}

class IconCategory extends StatelessWidget {
  final String iconName;

  IconCategory({required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Icon(
      IconMapper.getIcon(iconName),
      size: 24.0,
      color: Colors.white,
    );
  }
}
