import 'package:odc_mobile_project/m_user/business/model/OnboardingPageModel.dart';
import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';

class GetListOnboardUseCase{
  UserLocalService local;

  GetListOnboardUseCase(this.local);

  List<OnboardingPageModel> run(){
    return local.getListOnboard();
  }
}