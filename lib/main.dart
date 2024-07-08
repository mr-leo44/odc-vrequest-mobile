import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';


import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_chat/ui/framework/ChatLocalServiceV1.dart';
import 'package:odc_mobile_project/m_chat/ui/framework/ChatNetworkServiceV1.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'package:socket_io_client/socket_io_client.dart';

import 'm_user/business/interactor/UserInteractor.dart';
import 'm_user/ui/framework/UserLocalServiceImpl.dart';
import 'm_user/ui/framework/UserNetworkServiceImpl.dart';
import 'navigation/routers.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final appDir = await getApplicationDocumentsDirectory();
  // await appDir.create(recursive: true);
  final dbPath = join(appDir.path, "sembast.db");
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  var baseUrl = dotenv.env['BASE_URL'] ?? "";
  var socketUrl = dotenv.env['SOCKET_URL'] ?? "";

// module user service implementations
  var userNetworkImpl = UserNetworkServiceImpl(baseUrl);
  var userLocalImpl = UserLocalServiceImpl(db);
  var userInteractor=UserInteractor.build(userNetworkImpl, userLocalImpl);

  Socket socket = io(socketUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true
  });

  socket.connect();

  var chatNetworkImpl = ChatNetworkServiceV1(baseUrl,socket);
  var chatLocalImpl = ChatLocalServiceV1(baseUrl);
  var chatInteractor = ChatInteractor.build(userNetworkImpl,chatNetworkImpl,chatLocalImpl);

  runApp(ProviderScope(
      overrides: [
        userInteractorProvider.overrideWithValue(userInteractor),
        chatInteractorProvider.overrideWithValue(chatInteractor),
      ],
      child: MyApp()
  ));
}


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
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
