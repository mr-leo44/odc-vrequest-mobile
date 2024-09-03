import 'package:odc_mobile_project/m_course/business/Course.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';

class StartCourseRealTimeUseCase{
  SharedNetworkService network;

  StartCourseRealTimeUseCase(this.network);

  Course run(){
      return network.startCourse.value;
  }
}