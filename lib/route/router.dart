import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter/screens/10_transition_screen1.dart';
import 'package:gorouter/screens/10_transition_screen2.dart';
import 'package:gorouter/screens/11_error_screen.dart';
import 'package:gorouter/screens/1_basic_screen.dart';
import 'package:gorouter/screens/2_named_screen.dart';
import 'package:gorouter/screens/3_push_screen.dart';
import 'package:gorouter/screens/4_pop_base_screen.dart';
import 'package:gorouter/screens/5_pop_return_screen.dart';
import 'package:gorouter/screens/6_path_param_screen.dart';
import 'package:gorouter/screens/7_query_parameter.dart';
import 'package:gorouter/screens/8_nested_child_screen.dart';
import 'package:gorouter/screens/8_nested_screen.dart';
import 'package:gorouter/screens/9_login_screen.dart';
import 'package:gorouter/screens/9_private.dart';
import 'package:gorouter/screens/root_screen.dart';

// 로그인 여부 확인
bool authState = false;

final router = GoRouter(
  redirect: (context, state) {
    // return String(path) -> 해당 라우트로 이동한다.
    // return null -> 원래 이동하려던 라우트로 이동한다.
    if (state.location == '/login/private' && !authState) {
      return '/login';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) {
            return BasicScreen();
          },
        ),
        GoRoute(
            path: 'named',
            builder: (context, state) {
              return NamedScreen();
            },
            name: 'named screen'),
        GoRoute(
          path: 'push',
          builder: (context, state) {
            return PushScreen();
          },
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) {
            return PopBaseScreen();
          },
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) {
                return PopReturnScreen();
              },
            )
          ],
        ),
        // /: 이 뒤로 오는 값을 변수로 칭하겠다.
        GoRoute(
            path: 'path_param/:id',
            builder: (context, state) {
              return PathParamScreen();
            },
            routes: [
              GoRoute(
                  path: ':name',
                  builder: (context, state) {
                    return PathParamScreen();
                  })
            ]),
        GoRoute(
          path: 'query_param',
          builder: (context, state) {
            return QueryParameterScreen();
          },
        ),
        // routes내의 GoRoute의 builder에서 반환하는 값(widget)들을 child에서 받는다.
        ShellRoute(
          builder: (context, state, child) {
            return NestedScreen(child: child);
          },
          // /nested/a
          routes: [
            GoRoute(
              path: 'nested/a',
              builder: (_, state) => NestedChildScreen(routeName: '/nested/a'),
            ),
            // /nested/b
            GoRoute(
              path: 'nested/b',
              builder: (_, state) => NestedChildScreen(routeName: '/nested/b'),
            ),
            // /nested/c
            GoRoute(
              path: 'nested/c',
              builder: (_, state) => NestedChildScreen(routeName: '/nested/c'),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
            )
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (_, state) => LoginScreen(),
          routes: [
            // Route level redirect -> 현재 이 route에 이동하려고 할 때만 적용
            GoRoute(
                path: 'private',
                builder: (_, state) => PrivateScreen(),
                redirect: (context, state) {
                  if (!authState) {
                    return '/login2';
                  }
                  return null;
                })
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (_, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              pageBuilder: (_, state) => CustomTransitionPage(
                child: TransitionScreenTwo(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(error: state.error.toString()),
  debugLogDiagnostics: true,
);
