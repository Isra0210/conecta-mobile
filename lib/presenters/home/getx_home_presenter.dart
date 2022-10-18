import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conectamaispg/mixins/loading_mixin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../pages/home/home_presenter.dart';
import '../new_research_presenter/research_enum.dart';
import '../research/research_view_model.dart';

class GetXHomePresenter extends GetxController with LoadingMixin implements IHomePresenter {
  final Rx<ResearchViewModel?> _researchViewModel = Rx(null);
  @override
  ResearchViewModel? get researchViewModel => _researchViewModel.value;
  @override
  set researchViewModel(ResearchViewModel? value) =>
      _researchViewModel.value = value;

  final RxList<Map<String, dynamic>> _answer = RxList(<Map<String, dynamic>>[]);
  @override
  List<Map<String, dynamic>> get answer => _answer;
  @override
  set answer(List<Map<String, dynamic>> value) => _answer.value = value;

  final RxInt _groupValue = (-1).obs;
  @override
  int get groupValue => _groupValue.value;
  @override
  set groupValue(int value) => _groupValue.value = value;

  @override
  Future<void> uploadAnswer({required ResearchViewModel search}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    
    loading = true;

    final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('searches')
        .doc(search.id)
        .get();

    final List usersWhoResponded = doc.data()!["usersWhoResponded"];

    await FirebaseFirestore.instance.collection('searches').doc(search.id).set({
      'answers': answer,
      'usersWhoResponded': [
        ...usersWhoResponded.map((e) => e),
        uid,
      ],
    }, SetOptions(merge: true));

    FirebaseFirestore.instance
        .collection('users')
        .doc(search.createdBy)
        .collection('searches')
        .doc(search.id)
        .set(
      {
        'answers': answer,
        'usersWhoResponded': [
          ...usersWhoResponded.map((e) => e),
          uid,
        ],
      },
      SetOptions(merge: true),
    );
    
    loading = false;
    Get.back();
  }

  @override
  Stream<List<ResearchViewModel>?> research(String filterByStatus) {
    final ref = FirebaseFirestore.instance
        .collection('searches')
        .where('usersToAnswer',
            arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: ResearchStatusEnum.approved.name)
        .withConverter<ResearchViewModel>(
          fromFirestore: (snapshot, _) =>
              ResearchViewModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toMap(),
        )
        .snapshots();
    final result = ref.map<List<ResearchViewModel>>((qShot) {
      return qShot.docs.map((doc) => doc.data()).toList();
    });
    return result;
  }
}
