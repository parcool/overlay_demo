import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_demo/chat/chat_live/chat_live_state.dart';
import 'package:video_player/video_player.dart';

import 'chat_live_logic.dart';

class ChatLivePage extends StatelessWidget {
  ChatLivePage({super.key});

  static const chatLivePageTag = 'chatLivePageTag123';

  final logic = Get.put(ChatLiveLogic(), tag: chatLivePageTag, permanent: true);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLiveLogic>(
        tag: chatLivePageTag,
        builder: (logic) {
          return CupertinoPageScaffold(
            backgroundColor: Colors.blueGrey,
            child: Builder(builder: (context) {
              switch (logic.state.chatStatus) {
                case ChatStatus.incoming:
                  return IncomingCallScreen(logic: logic);
                case ChatStatus.living:
                  return ChatLivingScreen(logic: logic);
                default:
                  return const SizedBox.shrink();
              }
            }),
          );
        });
  }
}

class IncomingCallScreen extends StatelessWidget {
  final ChatLiveLogic logic;

  const IncomingCallScreen({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 100, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 150,
            height: 150,
            child: CircleAvatar(
                child: FlutterLogo(
              size: 110,
            )),
          ),
          const SizedBox(height: 50),
          const Text(
            '拜登\n邀请你视频通话…',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          DefaultTextStyle(
            style: const TextStyle(color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PhoneButton(
                  onPressed: () {
                    logic.accept();
                  },
                  icon: CupertinoIcons.phone,
                  text: '接听',
                  backgroundColor: Colors.green,
                ),
                const SizedBox(width: 100),
                PhoneButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: CupertinoIcons.phone_down,
                  text: '挂断',
                  backgroundColor: Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50)
        ],
      ),
    );
  }
}

class ChatLivingScreen extends StatelessWidget {
  final ChatLiveLogic logic;

  const ChatLivingScreen({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    final controller = logic.state.controller;
    if (controller != null && controller.value.isInitialized == true) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            Positioned(
              top: 50,
              child: IconButton(
                onPressed: () {
                  logic.closeUI(context);
                },
                icon: const Icon(
                  CupertinoIcons.app_badge,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: const TextStyle(color: Colors.white),
                    child: PhoneButton(
                      onPressed: () {
                        logic.pour(context);
                      },
                      icon: CupertinoIcons.phone_down,
                      text: '挂断',
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
    return const Center(
      child: Text(
        '接听中……',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class PhoneButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const PhoneButton({super.key, required this.icon, required this.text, required this.onPressed, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: backgroundColor),
          padding: const EdgeInsets.all(6),
          child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: Colors.white,
                size: 34,
              )),
        ),
        const SizedBox(height: 8),
        Text(text)
      ],
    );
  }
}
