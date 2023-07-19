import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter/layout/default_layout.dart';

class QueryParameterScreen extends StatelessWidget {
  const QueryParameterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text(
            'Queryparamter : ${GoRouterState.of(context).queryParameters}',
          ),
          // /query_parameter
          ElevatedButton(
            onPressed: () {
              context.push(
                Uri(
                        path: '/query_param',
                        queryParameters: {'name': 'codefactory', 'age': '32'})
                    .toString(),
              );
            },
            child: Text('Query Parameters'),
          ),
        ],
      ),
    );
  }
}
