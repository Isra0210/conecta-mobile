import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ResearchViewModel extends Equatable {
  const ResearchViewModel({
    required this.createdAt,
    required this.createdBy,
    required this.isActive,
    required this.status,
    required this.questions,
    required this.answers,
    required this.users,
  });

  final Timestamp createdAt;
  final String createdBy;
  final bool isActive;
  final String status;
  final List questions;
  final List answers;
  final List users;

  @override
  List<Object> get props =>
      [createdAt, createdBy, isActive, status, questions, answers, users];

  factory ResearchViewModel.fromJson(Map<String, dynamic> json) {
    return ResearchViewModel(
      createdAt: json['createdAt'],
      createdBy: json['createdBy'],
      isActive: json['isActive'],
      status: json['status'],
      questions: json['questions'],
      answers: json['answers'],
      users: json['users'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'createdBy': createdBy,
      'isActive': isActive,
      'status': status,
      'questions': questions,
      'answers': answers,
      'users': users,
    };
  }

  @override
  String toString() {
    return "createdAt: $createdAt isActive: $isActive questions: $questions answers: $answers";
  }
}
