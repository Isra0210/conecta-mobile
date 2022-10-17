import '../../presenters/research/research_view_model.dart';

abstract class IHomePresenter {
  ResearchViewModel? get researchViewModel;
  set researchViewModel(ResearchViewModel? value);

  int get groupValue;
  set groupValue(int value);

  Stream<List<ResearchViewModel>?> research(String filterByStatus);
}
