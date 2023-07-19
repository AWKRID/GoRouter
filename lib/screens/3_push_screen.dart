import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        body: ListView(
      children: [
        // push는 새로운 route를 그대로 위에 올린다.
        ElevatedButton(
          onPressed: () {
            context.push('/basic');
          },
          child: Text('Push basic'),
        ),
        // Go는 선언된 상위 route를 먼저 올리고 해당 route를 올리게 된다.
        ElevatedButton(
          onPressed: () {
            context.go('/basic');
          },
          child: Text('Go basic'),
        ),
      ],
    ));
  }
}
