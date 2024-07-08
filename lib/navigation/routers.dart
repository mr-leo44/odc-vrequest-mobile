import 'package:flutter/material.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/Chat/ChatPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailPage.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListPage.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/choixManager/ChoixManagerPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/compte/CompteProfilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/introPage/IntroPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/login/LoginPage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part "routers.g.dart";


enum Urls { home, detailArticle, auth, login, profil,compte,choix_manager,test,chatList,accueil }



@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final userInteractor = ref.watch(userInteractorProvider);
  return GoRouter(
      debugLogDiagnostics: true,

      initialLocation: "/home",
      redirect: (context, state) async {
        var usecase = userInteractor.getUserLocalUseCase;
        var res = await usecase.run();
        // redirection vers home page si l'utilisateur est deja connecté
        if(res?.id != 0 && state.matchedLocation.startsWith("/auth")){

          return "/accueil";
        }
        // redirection vers auth page si l'utilisateur n'est pas connecté

        if(res?.id==0 && state.matchedLocation.startsWith("/home")){
          return "/home" ;

        }





        return null;

      },
      routes: <RouteBase>[
        GoRoute(
          path: "/home",
          name: Urls.home.name,
          builder: (ctx, state) => IntroPage(),
          routes: <RouteBase>[
            GoRoute(

                path: 'profil',
                name: Urls.profil.name,
                builder: (ctx, state) => Profilpage(),
                routes: <RouteBase>[
                  GoRoute(
                      path: 'compte',
                      name: Urls.compte.name,
                      builder: (ctx, state) => CompteProfilPage()),

                ]),

            GoRoute(
                path: 'choix_manager',
                name: Urls.choix_manager.name,
                builder: (ctx, state) => ChoixManagerPage()),


            GoRoute(
              path: "details/:id",
              name: Urls.detailArticle.name,
              pageBuilder: (ctx, state) {
                final articleId = state.pathParameters["id"];
                return MaterialPage(key: state.pageKey, child: LoginPage());
              },
            ),
            GoRoute(
              path: "chat",
              name: Urls.chatList.name,
              builder: (ctx, state) => ChatListPage(),
            ),
          ],
        ),
        GoRoute(
          path: "/accueil",
          name: Urls.accueil.name,
          builder: (ctx, state) => AccueilPage(),
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
