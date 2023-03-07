import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/jitsi_methods.dart';

import '../widgets/home_button.dart';

class MeetingPage extends StatelessWidget {
  final JitsiMethods _jitsiMethods = JitsiMethods();
  MeetingPage({super.key});

  createMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 1000000).toString();
    _jitsiMethods.createNewMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(context) {
    Navigator.pushNamed(context, 'video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeButton(
              onPressed: createMeeting,
              icon: Icons.videocam,
              label: "New Meeting",
            ),
            HomeButton(
                onPressed: joinMeeting(context),
                icon: Icons.add_box_rounded,
                label: "Join Meeting"),
            HomeButton(
                onPressed: () {},
                icon: Icons.calendar_today,
                label: "Schedule"),
            HomeButton(
                onPressed: () {},
                icon: Icons.arrow_upward_rounded,
                label: "Share"),
          ],
        ),
        const Expanded(
            child: Center(
          child: Text(
            "Create/Join Meetings with just a click!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ))
      ],
    );
  }
}
