import 'package:odc_mobile_project/m_chat/business/service/messageNetworkService.dart';
import 'package:odc_mobile_project/m_course/business/Course.dart';

class CloseCourseUseCase{
  MessageNetworkService network;

  CloseCourseUseCase(this.network);

  Future<bool> run(Course course)async{
    return await network.closeCourse(course);
  }

}