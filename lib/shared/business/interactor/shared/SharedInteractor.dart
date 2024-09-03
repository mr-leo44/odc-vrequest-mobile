import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/GetLocationUseCase.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/LocationRealTimeUseCase.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/SendLocationUseCase.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/closeCourseRealTimeUseCase.dart';
import 'package:odc_mobile_project/shared/business/interactor/shared/UseCase/startCourseRealTimeUseCase.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "SharedInteractor.g.dart";

class SharedInteractor {
  StartCourseRealTimeUseCase startCourseRealTimeUseCase;
  CloseCourseRealTimeUseCase closeCourseRealTimeUseCase;
  SendLocationUseCase sendLocationUseCase;
  GetLocationUseCase getLocationUseCase;
  LocationRealTimeUseCase locationRealTimeUseCase;

  SharedInteractor._(
    this.startCourseRealTimeUseCase,
    this.closeCourseRealTimeUseCase,
    this.sendLocationUseCase,
    this.getLocationUseCase,
    this.locationRealTimeUseCase,
  );

  static build(SharedNetworkService network) {
    return SharedInteractor._(
      StartCourseRealTimeUseCase(network),
      CloseCourseRealTimeUseCase(network),
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
