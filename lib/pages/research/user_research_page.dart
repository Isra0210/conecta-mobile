import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presenters/research/research_view_model.dart';
import 'components/build_choose.dart';

class ResearchDetailsPage extends StatelessWidget {
  const ResearchDetailsPage({Key? key}) : super(key: key);

  static const route = '/research-details';

  @override
  Widget build(BuildContext context) {
    ResearchViewModel search = Get.arguments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Formulário'),
        centerTitle: true,
        backgroundColor: const Color(0XFF1e224c),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...search.questions.map(
            (e) => Container(
              margin: const EdgeInsets.only(top: 12.0),
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e["title"],
                    style: const TextStyle(fontSize: 16),
                  ),
                  BuildChoose(type: e["type"], options: e["options"]),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 0.2,
                  blurRadius: 0.1,
                  offset: const Offset(-1, -1),
                ),
                BoxShadow(
                  color: Colors.grey.shade600,
                  spreadRadius: 0.2,
                  blurRadius: 1,
                  offset: const Offset(1, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "Enviar",
                style: TextStyle(
                  color:  Color(0XFF1e224c),
                  fontSize: 18
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
