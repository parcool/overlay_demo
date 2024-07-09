import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_demo/routes.dart';

import 'chat_single_logic.dart';

class ChatSinglePage extends StatelessWidget {
  ChatSinglePage({super.key});

  final logic = Get.put(ChatSingleLogic());
  final state = Get.find<ChatSingleLogic>().state;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('单聊'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              minSize: 0,
              padding: EdgeInsets.zero,
              child: const Text('模拟来电'),
              onPressed: () {
                Get.toNamed(Routes.chatLive);
              },
            ),
          ],
        ),
      ),
      child: SafeArea(
        bottom: true,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index % 2 == 0) {
                    return Container(
                      decoration: const BoxDecoration(color: Colors.amber),
                      margin: const EdgeInsets.only(right: 100),
                      height: 70,
                      alignment: Alignment.centerLeft,
                      child: const Text('模拟聊天内容：对方'),
                    );
                  }
                  return Container(
                    decoration: const BoxDecoration(color: Colors.green),
                    margin: const EdgeInsets.only(left: 100),
                    height: 50,
                    alignment: Alignment.centerRight,
                    child: const Text('模拟聊天内容：自己'),
                  );
                },
                itemCount: 20,
                reverse: true,
              ),
            ),
            CupertinoTextField(
              placeholder: '在此输入内容',
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              controller: logic.state.controller,
              style: const TextStyle(color: Colors.blueGrey),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
