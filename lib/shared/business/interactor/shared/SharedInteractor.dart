import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/GetLocationUseCase.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/LocationRealTimeUseCase.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/SendLocationUseCase.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "SharedInteractor.g.dart";

class SharedInteractor {
  SendLocationUseCase sendLocationUseCase;
  GetLocationUseCase getLocationUseCase;
  LocationRealTimeUseCase locationRealTimeUseCase;

  SharedInteractor._(
    this.sendLocationUseCase,
    this.getLocationUseCase,
    this.locationRealTimeUseCase,
  );

  static build(SharedNetworkService network) {
    return SharedInteractor._(
      SendLocationUseCase(network),
      GetLocationUseCase(network),
      LocationRealTimeUseCase(network),
    );
  }
}

@Riverpod(keepAlive: true)
SharedInteractor sharedInteractor(Ref ref) {
  throw Exception("Non implementé");
}
