import 'package:odc_mobile_project/m_user/business/model/OnboardingPageModel.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';

class TerminateOnboardUseCase{
  UserLocalService local;

  TerminateOnboardUseCase(this.local);

  Future run()async{
    return await local.terminateOnboard();
  }
}