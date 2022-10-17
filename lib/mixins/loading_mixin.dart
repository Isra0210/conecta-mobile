import 'package:get/get.dart';

mixin LoadingMixin on GetxController {
  final RxBool _loading = false.obs;
  set loading(bool loading) => _loading.value = loading;
  bool get loading => _loading.value;
}
