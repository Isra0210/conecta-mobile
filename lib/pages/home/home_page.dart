import 'package:conectamaispg/pages/home/home_presenter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/new_research_presenter/research_enum.dart';
import '../../presenters/research/research_view_model.dart';
import '../components/drawer_component.dart';
import '../components/user_form_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const route = '/home';

  @override
  Widget build(BuildContext context) {
    final IHomePresenter presenter = Get.find<IHomePresenter>();
    final String filterByStatus = ResearchStatusEnum.approved.name;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF1e224c),
        centerTitle: true,
        title: const Text('Home'),
      ),
      drawer: const DrawerComponent(),
      body: StreamBuilder<List<ResearchViewModel>?>(
        stream: presenter.research(filterByStatus),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  Color(0XFF1e224c),
                ),
              ),
            );
          }

          if (snapshot.hasData) {
            List<ResearchViewModel> searches = snapshot.data!
                .where(
                  (research) => !research.usersWhoResponded
                      .contains(FirebaseAuth.instance.currentUser!.uid),
                )
                .toList();
            if (searches.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum formulário disponível!',
                  style: TextStyle(fontSize: 18),
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: UserFormComponent(
                          searches: searches,
                          status: filterByStatus,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }

          return Text('${snapshot.data}');
        },
      ),
    );
  }
}
