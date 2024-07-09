import 'package:get/get.dart';
import 'package:overlay_demo/chat/chat_live/chat_live_view.dart';
import 'package:overlay_demo/chat/chat_single/chat_single_view.dart';
import 'package:overlay_demo/home.dart';

class Routes {
  static const String home = "/";
  static const String chatSingle = "/chat/single";
  static const String chatLive = "/chat/live";

  static final List<GetPage> getPages = [
    GetPage(name: home, page: () => const Home()),
    GetPage(name: chatSingle, page: () => ChatSinglePage()),
    GetPage(name: chatLive, page: () => ChatLivePage()),
  ];
}
