import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../mixins/loading_mixin.dart';
import '../../pages/home/home_page.dart';
import '../../pages/login/login_presenter.dart';

class GetXLoginPresenter extends GetxController
    with LoadingMixin
    implements ILoginPresenter {
  final RxBool _isToRegister = false.obs;
  @override
  bool get isToRegister => _isToRegister.value;
  @override
  set isToRegister(bool value) => _isToRegister.value = value;

  final RxBool _passwordVisible = true.obs;
  @override
  bool get passwordVisible => _passwordVisible.value;
  @override
  set passwordVisible(bool value) => _passwordVisible.value = value;

  @override
  Future<void> signIn(
      {required String email,
      required String password,
      required Function(String) showSnackBar}) async {
    try {
      loading = true;
      //ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        Get.offAllNamed(HomePage.route);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar("E-mail/senha incorreta!");
      } else if (e.code == 'wrong-password') {
        showSnackBar("E-mail/senha incorreta!");
      }
    } finally {
      loading = false;
    }
  }

  @override
  Future<void> updateInitialInfoUser(
    String uid,
    String name,
    String email,
  ) async {
    final collection = FirebaseFirestore.instance.collection('users').doc(uid);

    await collection.set(
      {
        'uid': uid,
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'isAdmin': false,
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required Function(String) showSnackBar,
  }) async {
    try {
      loading = true;
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await updateInitialInfoUser(userCredential.user!.uid, name, email);
      await userCredential.user!.updateDisplayName(name);
      Get.offAllNamed(HomePage.route);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackBar("Já existe uma conta com esse e-mail");
      } else {
        showSnackBar(e.message.toString());
      }
    } catch (e) {
      showSnackBar(e.toString());
    } finally {
      loading = false;
    }
  }

  @override
  void signOut() => FirebaseAuth.instance.signOut();
}