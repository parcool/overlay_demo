import 'package:video_player/video_player.dart';

class ChatLiveState {

  ChatStatus chatStatus = ChatStatus.idle;
  VideoPlayerController? controller;
  VideoPlayerController? controllerForSmallWindow;

  ChatLiveState() {
    ///Initialize variables
  }
}

/// 这里只是简单的模拟了3个状态，还有更多的状态需要完善，比如：
/// 接通中、挂断中等等
enum ChatStatus {
  idle,
  incoming,
  living
}