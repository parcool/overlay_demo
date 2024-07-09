import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_demo/routes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('首页'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              onPressed: () {
                Get.toNamed(Routes.chatSingle);
              },
              child: const Text('启动聊天页面'),
            ),
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              child: const Text('模拟/恢复视频聊天'),
              onPressed: () {
                Get.toNamed(Routes.chatLive);
              },
            ),
          ],
        ),
      ),
    );
  }
}
