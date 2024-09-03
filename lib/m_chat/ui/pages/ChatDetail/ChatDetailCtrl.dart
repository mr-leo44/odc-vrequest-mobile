import 'package:odc_mobile_project/m_chat/business/interactor/chatInteractor.dart';
import 'package:odc_mobile_project/m_course/business/Course.dart';
import 'package:odc_mobile_project/m_user/business/interactor/UserInteractor.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailState.dart';
import 'package:signals/signals_flutter.dart';

part "ChatDetailCtrl.g.dart";

@riverpod
class ChatDetailCtrl extends _$ChatDetailCtrl {
  @override
  ChatDetailState build() {
    getUser();
    return ChatDetailState();
  }

  Future getUser() async {
    var usecase = ref.watch(userInteractorProvider).getUserLocalUseCase;
    var res = await usecase.run();
    state = state.copyWith(auth: res);
  }

  void stateConnection() {
    var interactor = ref.watch(chatInteractorProvider);
    effect(() {
      var isconnected = interactor.isConnectedUseCase.run();
      var isdeconnected = interactor.isDeconnectedUseCase.run();
      print(isconnected);
      state = state.copyWith(
          isconnected: isconnected, isdeconnected: isdeconnected);
    });
  }

  Future getRouteUrl(double finalLon, double finalLat) async {
    var sharedState = ref.watch(sharedCtrlProvider);
    var interactor = ref.watch(chatInteractorProvider);
    var points = await interactor.getRouteUrlUseCase.run(
        "${sharedState.location["longitude"]},${sharedState.location["latitude"]}",
        "${finalLon},${finalLat}");
    state = state.copyWith(drawRoute: points);
  }

  Future<bool> startCourse(Course course) async {
    var interactor = ref.watch(chatInteractorProvider);
    var started = await interactor.startCourseUseCase.run(course);
    print("Started :" + started.toString());
    state = state.copyWith(courseStarted: true);
    return started;
  }

  Future<bool> closeCourse(Course course) async {
    var interactor = ref.watch(chatInteractorProvider);
    var closed = await interactor.closeCourseUseCase.run(course);
    print("Started :" + closed.toString());
    state = state.copyWith(courseClosed: true);
    return closed;
  }
}
