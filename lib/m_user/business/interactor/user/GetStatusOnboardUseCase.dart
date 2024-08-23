import 'package:odc_mobile_project/m_user/business/service/userLocalService.dart';

class GetStatusOnboardUseCase{
  UserLocalService local;

  GetStatusOnboardUseCase(this.local);

  Future<bool?>run()async{
    return await local.getStatusOnboard();
  }
}