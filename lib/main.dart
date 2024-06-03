import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import 'm_user/business/interactor/UserInteractor.dart';
import 'm_user/ui/framework/UserLocalServiceImpl.dart';
import 'm_user/ui/framework/UserNetworkServiceImpl.dart';
import 'navigation/routers.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await GetStorage.init();

  var stockage = GetStorage();

  var baseUrl = dotenv.env['BASE_URL'] ?? "";

// module user service implementations
  var userNetworkImpl = UserNetworkServiceImpl(baseUrl);
  var userLocalImpl = UserLocalServiceImpl(stockage);
  var userInteractor=UserInteractor.build(userNetworkImpl, userLocalImpl);


  runApp(ProviderScope(
      overrides: [
        userInteractorProvider.overrideWithValue(userInteractor),
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
