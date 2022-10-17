import '../../mixins/loading_mixin.dart';

abstract class ILoginPresenter implements LoadingMixin {
  bool get isToRegister;
  set isToRegister(bool value);

  bool get passwordVisible;
  set passwordVisible(bool value);

  void signOut();

  Future<void> updateInitialInfoUser(String uid, String name, String email);

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required Function(String) showSnackBar,
  });

  Future<void> signIn({
    required String email,
    required String password,
    required Function(String) showSnackBar,
  });
}
