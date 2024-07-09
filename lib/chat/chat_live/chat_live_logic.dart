import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_demo/chat/chat_live/chat_live_view.dart';
import 'package:overlay_demo/overlay_manager.dart';
import 'package:overlay_demo/routes.dart';
import 'package:video_player/video_player.dart';

import 'chat_live_state.dart';

class ChatLiveLogic extends GetxController {
  final ChatLiveState state = ChatLiveState();

  @override
  void onInit() {
    state.chatStatus = ChatStatus.incoming;
    super.onInit();
  }

  void accept() {
    state.chatStatus = ChatStatus.living;
    state.controller = VideoPlayerController.networkUrl(Uri.parse('https://www.w3school.com.cn/example/html5/mov_bbb.mp4'))
      ..setLooping(true)
      ..initialize().then((_) {
        state.controller?.play();
        update();
      });

    state.controllerForSmallWindow = VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..setLooping(true)
      ..initialize().then((_) {
        state.controllerForSmallWindow?.play();
        showSmallWindow();
      });
    update();
  }

  void pour(BuildContext context) async {
    smallWindowInApp = null;
    globalOverlayEntry.markNeedsBuild();
    Get.delete<ChatLiveLogic>(tag: ChatLivePage.chatLivePageTag, force: true);
    if (!context.mounted) return;
    Navigator.of(context).pop();
  }

  void showSmallWindow() {
    smallWindowInApp = SmallWindowScreen(logic: this);
    globalOverlayEntry.markNeedsBuild();
  }

  void closeUI(BuildContext context) {
    // 注意：这里只是关闭了页面，logic的视频（实际应用中是人像数据）仍然在处理中，
    // 自己添加一个是否可见的机制来暂停与恢复更好。
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    state.controller?.dispose();
    state.controllerForSmallWindow?.dispose();
    super.dispose();
  }
}

class SmallWindowScreen extends StatelessWidget {
  final ChatLiveLogic logic;

  const SmallWindowScreen({super.key, required this.logic});

  @override
  Widget build(BuildContext context) {
    final controller = logic.state.controllerForSmallWindow;
    if (controller == null || controller.value.isInitialized == false) {
      return const SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        if (Get.currentRoute != Routes.chatLive) {
          print('跳转到聊天页面');
          Get.toNamed(Routes.chatLive);
        }
      },
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          margin: const EdgeInsets.only(top: 50,right: 30),
          color: Colors.grey,
          width: 200,
          height: 150,
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
