import 'package:equatable/equatable.dart';

class ResearchCompViewModel extends Equatable {
  const ResearchCompViewModel({
    required this.title,
    required this.type,
    required this.options,
  });

  final String type;
  final String title;
  final List<String> options;

  @override
  List<Object> get props => [title, type, options];

  factory ResearchCompViewModel.fromJson(Map<String, dynamic> json) {
    return ResearchCompViewModel(
      title: json['title'],
      type: json['type'],
      options: json['options'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'options': options,
    };
  }

  @override
  String toString() {
    return "title: $title type: $type options: $options";
  }
}
