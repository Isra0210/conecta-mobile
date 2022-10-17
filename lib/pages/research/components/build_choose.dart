import 'package:conectamaispg/pages/home/home_presenter.dart';
import 'package:conectamaispg/presenters/new_research_presenter/research_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildChoose extends StatefulWidget {
  const BuildChoose({required this.type, this.options, Key? key})
      : super(key: key);

  final String type;
  final List? options;

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
