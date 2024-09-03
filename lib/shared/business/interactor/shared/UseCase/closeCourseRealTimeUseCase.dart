import 'package:odc_mobile_project/m_course/business/Course.dart';
import 'package:odc_mobile_project/shared/business/service/SharedNetworkService.dart';

class CloseCourseRealTimeUseCase{
  SharedNetworkService network;

  CloseCourseRealTimeUseCase(this.network);

  Course run(){
      return network.closeCourse.value;
  }
}