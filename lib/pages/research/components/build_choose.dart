import 'package:conectamaispg/pages/home/home_presenter.dart';
import 'package:conectamaispg/presenters/new_research_presenter/research_enum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildChoose extends StatefulWidget {
  const BuildChoose({
    required this.presenter,
    required this.type,
    required this.title,
    required this.questionId,
    this.options,
    Key? key,
  }) : super(key: key);

  final IHomePresenter presenter;
  final String type;
  final List? options;
  final String title;
  final String questionId;

  @override
  State<BuildChoose> createState() => _BuildChooseState();
}

class _BuildChooseState extends State<BuildChoose> {
  final IHomePresenter presenter = Get.find<IHomePresenter>();

  @override
  Widget build(BuildContext context) {
    if (widget.type == ResearchEnum.multipleChoose.name) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.options!.map(
              (option) => Obx(() {
                return Row(
                  children: [
                    Radio(
                      fillColor: MaterialStateProperty.all(
                        const Color(0XFF1e224c),
                      ),
                      value: widget.options!.indexOf(option),
                      groupValue: presenter.groupValue,
                      onChanged: (int? value) {
                        presenter.groupValue = value!;
                        final Map<String, dynamic> answer = {
                          "title": widget.title,
                          "questionId": widget.questionId,
                          "answer":
                              widget.options![widget.options!.indexOf(option)],
                          "userWhoResponded": FirebaseAuth.instance.currentUser!.uid,
                        };

                        presenter.answer.removeWhere(
                          (element) =>
                              element["questionId"] == answer["questionId"],
                        );

                        presenter.answer.add(answer);
                      },
                    ),
                    Text(
                      option,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      );
    } else if (widget.type == ResearchEnum.text.name) {
      return const Text("Algo deu errado");
    } else {
      return const Text("Algo deu errado");
    }
  }
}
