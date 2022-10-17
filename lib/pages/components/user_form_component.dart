import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/research/research_view_model.dart';
import '../research/user_research_page.dart';

class UserFormComponent extends StatelessWidget {
  const UserFormComponent({
    required this.searches,
    required this.status,
    Key? key,
  }) : super(key: key);

  final List<ResearchViewModel> searches;
  final String status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.82,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...searches
                .map(
                  (search) => GestureDetector(
                    onTap: () => Get.toNamed(
                      ResearchDetailsPage.route,
                      arguments: search,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(-1, -1),
                          ),
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 1,
                            offset: Offset(1, 1),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // margin: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Criado em: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${search.createdAt.toDate().day}/${search.createdAt.toDate().month}/${search.createdAt.toDate().year}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: 12.0,
                                ),
                                child: Text(
                                  "Perguntas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              ...search.questions.map(
                                (question) => Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.radio_button_checked,
                                            size: 8,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 14.0),
                                            child: Text(
                                              question['title'],
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...(question['options'] as List).map(
                                      (op) => Padding(
                                        padding: const EdgeInsets.only(
                                          left: 26.0,
                                          bottom: 8,
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.radio_button_off,
                                              size: 8,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 14.0),
                                              child: Text(
                                                op.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
