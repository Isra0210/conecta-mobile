import 'package:get/get.dart';

import '../../pages/home/home_presenter.dart';
import '../../pages/login/login_presenter.dart';
import '../../presenters/home/getx_home_presenter.dart';
import '../../presenters/login/getx_login_presenter.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ILoginPresenter>(GetXLoginPresenter());
    Get.put<IHomePresenter>(GetXHomePresenter());
  }
}
