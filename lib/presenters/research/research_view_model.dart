import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ResearchViewModel extends Equatable {
  const ResearchViewModel({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
    required this.status,
    required this.questions,
    required this.answers,
    required this.usersToAnswer,
    required this.usersWhoResponded,
  });

  final String id;
  final Timestamp createdAt;
  final String createdBy;
  final bool isActive;
  final String status;
  final List questions;
  final List answers;
  final List usersToAnswer;
  final List usersWhoResponded;

  @override
  List<Object> get props => [
        createdAt,
        createdBy,
        isActive,
        status,
        questions,
        answers,
        usersToAnswer,
        usersWhoResponded,
      ];

  factory ResearchViewModel.fromJson(Map<String, dynamic> json) {
    return ResearchViewModel(
      id: json['id'],
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      isActive: json['isActive'],
      status: json['status'],
      questions: json['questions'],
      answers: json['answers'],
      usersToAnswer: json['usersToAnswer'],
      usersWhoResponded: json['usersWhoResponded'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'isActive': isActive,
      'status': status,
      'questions': questions,
      'answers': answers,
      'usersToAnswer': usersToAnswer,
      'usersWhoResponded': usersWhoResponded,
    };
  }

  @override
  String toString() {
    return "id: $id createdAt: $createdAt isActive: $isActive questions: $questions answers: $answers usersWhoResponded: $usersWhoResponded";
  }
}
