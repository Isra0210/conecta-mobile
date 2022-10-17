import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../pages/home/home_presenter.dart';
import '../new_research_presenter/research_enum.dart';
import '../research/research_view_model.dart';

class GetXHomePresenter extends GetxController implements IHomePresenter {
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
  Future<void> uploadAnswer({
    required Map<String, dynamic> answer,
    required ResearchViewModel search,
    required String questionId,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    //TODO finish it
    FirebaseFirestore.instance.collection('searches').doc(search.id).set({
      'answers': [
        {
          'questionId': questionId,
          'userId': uid,
        }
      ],
    }, SetOptions(merge: true));
  }

  @override
  Stream<List<ResearchViewModel>?> research(String filterByStatus) {
    final ref = FirebaseFirestore.instance
        .collection('searches')
        .where('users', arrayContains: FirebaseAuth.instance.currentUser!.uid)
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
