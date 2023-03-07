// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:zoom_clone/utils/colors.dart';

class MeetingOptions extends StatelessWidget {
  final String label;
  final bool isMute;
  final Function(bool) onchanged;

  const MeetingOptions({
    Key? key,
    required this.label,
    required this.isMute,
    required this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Switch.adaptive(value: isMute, onChanged: onchanged)
        ],
      ),
    );
  }
}
