import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/m_user/ui/pages/accueil/AccueilPage.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/SharedInteractor.dart';
import 'package:odc_mobile_project/shared/ui/framework/SharedNetworkServiceV1.dart';
import 'package:odc_mobile_project/shared/ui/pages/notification/NotificationController.dart';
import 'package:odc_mobile_project/shared/ui/pages/notification/NotificationPage.dart';

import 'package:path_provider/path_provider.dart';

import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/ui/framework/ChatLocalServiceV1.dart';
import 'package:odc_mobile_project/m_chat/ui/framework/ChatNetworkServiceV1.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'm_demande/business/interactor/demandeInteractor.dart';
import 'm_demande/ui/framework/DemandeNetworkServiceImpl_deleted.dart';
import 'm_user/business/interactor/UserInteractor.dart';
import 'm_user/ui/framework/UserLocalServiceImpl.dart';
import 'm_user/ui/framework/UserNetworkServiceImpl.dart';
import 'navigation/routers.dart';
import 'package:path/path.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:palette_generator/palette_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final appDir = await getApplicationDocumentsDirectory();
  // await appDir.create(recursive: true);
  final dbPath = join(appDir.path, "sembast.db");
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var baseUrl = dotenv.env['BASE_URL'] ?? "";
  var socketUrl = dotenv.env['SOCKET_URL'] ?? "";

  Socket socket = io(socketUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true
  });

  socket.connect();

  // module chat service implementations
  var sharedNetworkImpl = SharedNetworkServiceV1(socket);
  var sharedInteractor =
      SharedInteractor.build(sharedNetworkImpl);

  // module user service implementations
  var userNetworkImpl = UserNetworkServiceImpl(baseUrl);
  var userLocalImpl = UserLocalServiceImpl(db);
  var userInteractor = UserInteractor.build(userNetworkImpl, userLocalImpl);

  // module demande service implementations
  var demandeNetworkImpl = DemandeNetworkServiceImpl(baseUrl);
  var demandeIntercator =
      DemandeInteractor.build(demandeNetworkImpl, userLocalImpl);

  // module chat service implementations
  var chatNetworkImpl = ChatNetworkServiceV1(baseUrl, socket);
  var chatLocalImpl = ChatLocalServiceV1(baseUrl);
  var chatInteractor =
      ChatInteractor.build(userNetworkImpl, chatNetworkImpl, chatLocalImpl);

  // initialisation Notifications
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  await NotificationController.initializeIsolateReceivePort();

  runApp(ProviderScope(overrides: [
    userInteractorProvider.overrideWithValue(userInteractor),
    chatInteractorProvider.overrideWithValue(chatInteractor),
    demandeInteractorProvider.overrideWithValue(demandeIntercator),
    sharedInteractorProvider.overrideWithValue(sharedInteractor)
  ], child: MyApp()));
}

///  *********************************************
///     MAIN WIDGET
///  *********************************************
///
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Color mainColor = const Color(0xFF9D50DD);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  // static const String routeHome = '/', routeNotification = '/notification-page';

  @override
  void initState() {
    NotificationController.startListeningNotificationEvents();
    super.initState();
  }

  // List<Route<dynamic>> onGenerateInitialRoutes(String initialRouteName) {
  //   List<Route<dynamic>> pageStack = [];
  //   pageStack.add(MaterialPageRoute(
  //       builder: (_) =>
  //           AccueilPage()));
  //   if (initialRouteName == routeNotification &&
  //       NotificationController.initialAction != null) {
  //     pageStack.add(MaterialPageRoute(
  //         builder: (_) => NotificationPage(
  //             receivedAction: NotificationController.initialAction!)));
  //   }
  //   return pageStack;
  // }

  // Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case routeHome:
  //       return MaterialPageRoute(
  //           builder: (_) =>
  //               AccueilPage());

  //     case routeNotification:
  //       ReceivedAction receivedAction = settings.arguments as ReceivedAction;
  //       return MaterialPageRoute(
  //           builder: (_) => NotificationPage(receivedAction: receivedAction));
  //   }
  //   return null;
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: MyApp.navigatorKey,
      // onGenerateInitialRoutes: onGenerateInitialRoutes,
      // onGenerateRoute: onGenerateRoute,
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: 'Flutter ODC Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      //home: const CataloguePage(),
    );
  }
}
