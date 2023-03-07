import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_options.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMethods _jitsiMethods = JitsiMethods();

  late TextEditingController _roomName;
  late TextEditingController _userName;
  bool isAudio = true;
  bool isVideo = true;

  onAudio(bool val) {
    setState(() {
      isAudio = val;
    });
  }

  onVideo(bool val) {
    setState(() {
      isAudio = val;
    });
  }

  joinMeeting() {
    _jitsiMethods.createNewMeeting(
      roomName: _roomName.text,
      isAudioMuted: isAudio,
      isVideoMuted: isVideo,
      username: _userName.text,
    );
  }

  @override
  void initState() {
    _roomName = TextEditingController();
    _userName = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    _roomName.dispose();
    _userName.dispose();
    JitsiMeet.removeAllListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          centerTitle: true,
          title: const Text(
            "Join a meeting ",
            style: TextStyle(fontSize: 18),
          )),
      body: Column(children: [
        SizedBox(
          height: 60,
          child: TextField(
            controller: _roomName,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Room Id",
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
        SizedBox(
          height: 60,
          child: TextField(
            controller: _userName,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Your Name",
              fillColor: secondaryBackgroundColor,
              filled: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: joinMeeting,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Join Meeting",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
        const SizedBox(height: 20),
        MeetingOptions(
            label: "Mute Video", isMute: isAudio, onchanged: onAudio),
        const SizedBox(height: 5),
        MeetingOptions(label: "Mute Video", isMute: isVideo, onchanged: onVideo)
      ]),
    );
  }
}
