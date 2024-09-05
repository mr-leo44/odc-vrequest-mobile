import 'package:flutter/material.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatList/ChatListPage.dart';

import 'package:odc_mobile_project/m_demande/ui/page/demande/DemandePage.dart';
import 'package:odc_mobile_project/m_demande/ui/page/details_demande_page/DetailsDemandePage.dart';
import 'package:odc_mobile_project/m_demande/ui/page/list_demande/DemandeListPage.dart';
import 'package:odc_mobile_project/m_demande/ui/page/map_page/MapPage.dart';

import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
// import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/choixManager/ChoixManagerPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/compte/CompteProfilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/introPage/IntroPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/onboarding/OnboardingPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/profil/ProfilPage.dart';
import 'package:odc_mobile_project/m_user/ui/pages/login/LoginPage.dart';
import 'package:odc_mobile_project/utils/plugins/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import '../m_demande/ui/page/demande_encours/demandeEnCoursPage.dart';
import '../m_demande/ui/page/demande_traite/DemandeTraitePage.dart';
import '../m_demande/ui/page/statistique/StatPage.dart';
import '../m_user/ui/pages/accueil/AccueilPage.dart';

part "routers.g.dart";

enum Urls {
  home,
  detailArticle,
  auth,
  login,
  profil,
  compte,
  choix_manager,
  test,
  chatList,
  accueil,

  stat,
  demande_encours,
  listeDemandes,

  carte,
  demande,

  detailsDemande,
  demandeTraite,

  onboarding,
  splash,
}

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  final userInteractor = ref.watch(userInteractorProvider);
  return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: "/splash",
      redirect: (context, state) async {
        var usecase = userInteractor.getUserLocalUseCase;
        var res = await usecase.run();

        var getStatusOnboardUseCase =
            await userInteractor.getStatusOnboardUseCase.run();

        // redirection vers home page si l'utilisateur est deja connecté
        if ((res?.id != 0) && state.matchedLocation.startsWith("/auth")) {
          return "/home/accueil";
        }

        // // redirection vers auth page si l'utilisateur n'est pas connecté
        // if (res?.id == 0) {
        //   return "/auth";
        // }

        if ((state.uri.toString() == '/onboarding') &&
            (getStatusOnboardUseCase != null)) {
          return '/auth';
        }

        return null;
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/splash',
          name: Urls.splash.name,
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          name: Urls.onboarding.name,
          builder: (context, state) => OnboardingPage(),
        ),
        GoRoute(
          path: "/home",
          name: Urls.home.name,
          builder: (ctx, state) => IntroPage(),
          routes: <RouteBase>[
            GoRoute(
              path: "accueil",
              name: Urls.accueil.name,
              builder: (ctx, state) => AccueilPage(),
            ),
            GoRoute(
                path: 'choix_manager',
                name: Urls.choix_manager.name,
                builder: (ctx, state) => ChoixManagerPage()),
            GoRoute(
              path: 'profil',
              name: Urls.profil.name,
              builder: (ctx, state) => Profilpage(),
            ),
            GoRoute(
                path: 'compte',
                name: Urls.compte.name,
                builder: (ctx, state) => CompteProfilPage()),
            GoRoute(
                path: 'demande',
                name: Urls.demande.name,
                builder: (ctx, state) => DemandePage()),
            GoRoute(
                path: 'liste-demandes',
                name: Urls.listeDemandes.name,
                builder: (ctx, state) => DemandeListPage()),
            GoRoute(
                path: 'demandeTraite',
                name: Urls.demandeTraite.name,
                builder: (ctx, state) => DemandeTraitePage()),
            GoRoute(
                path: 'carte',
                name: Urls.carte.name,
                builder: (ctx, state) => MapPage()),
            GoRoute(
              path: "details-demande/:id",
              name: Urls.detailsDemande.name,
              pageBuilder: (ctx, state) {
                final articleId = state.pathParameters["id"];
                final id = int.tryParse(articleId!);
                return MaterialPage(
                    key: state.pageKey,
                    child: DetailsDemandePage(
                      id: id!,
                    ));
              },
            ),
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
            GoRoute(
              path: "stat",
              name: Urls.stat.name,
              builder: (ctx, state) => StatPage(),
            ),
            GoRoute(
              path: "demande_encours",
              name: Urls.demande_encours.name,
              builder: (ctx, state) => DemandeEnCoursPage(),
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
