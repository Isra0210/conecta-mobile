import 'package:conectamaispg/mixins/loading_mixin.dart';

import '../../presenters/research/research_view_model.dart';

abstract class IHomePresenter implements LoadingMixin {
  ResearchViewModel? get researchViewModel;
  set researchViewModel(ResearchViewModel? value);

  List<Map<String, dynamic>> get answer;
  set answer(List<Map<String, dynamic>> value);

  int get groupValue;
  set groupValue(int value);

  Stream<List<ResearchViewModel>?> research(String filterByStatus);

  Future<void> uploadAnswer({required ResearchViewModel search});
}
