import 'package:flutter/material.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListPage.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/m_user/ui/pages/TestPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/login/LoginPage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part "routers.g.dart";

enum Urls {
  home,
  detailArticle,
  auth,
  login,
  test,
  chatList,
}

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final userInteractor = ref.watch(userInteractorProvider);
  return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/auth/login",
      /* redirect: (context, state) async {
        return null;
      },*/
      routes: <RouteBase>[
        GoRoute(
          path: "/home",
          name: Urls.home.name,
          builder: (ctx, state) => LoginPage(),
          routes: <RouteBase>[
            GoRoute(
                path: 'test',
                name: Urls.test.name,
                builder: (ctx, state) => ChatListPage()),
            GoRoute(
              path: "details/:id",
              name: Urls.detailArticle.name,
              pageBuilder: (ctx, state) {
                final articleId = state.pathParameters["id"];
                return MaterialPage(key: state.pageKey, child: LoginPage());
              },
            ),
            GoRoute(
              path: "/chat",
              name: Urls.chatList.name,
              builder: (ctx, state) => ChatListPage(),
            ),
          ],
        ),
        GoRoute(
            path: "/auth",
            name: Urls.auth.name,
            builder: (ctx, state) => LoginPage(),
            routes: <RouteBase>[
              GoRoute(
                path: "login",
                name: Urls.login.name,
                builder: (ctx, state) => LoginPage(),
              )
            ]),
      ],
      errorBuilder: (ctx, state) => LoginPage());
}
