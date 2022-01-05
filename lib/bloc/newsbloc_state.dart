part of 'newsbloc_bloc.dart';

@immutable
abstract class NewsblocState {}

class NewsblocInitial extends NewsblocState {
  final List<Article> newsModel = [];
}

class NewsblocFetched extends NewsblocState {
  final List<Article>? newsModel;
  NewsblocFetched(this.newsModel);
}

class NewsblocErrorState extends NewsblocState {
  final List<Article> newsModel = [];
}

class NewsblocEmptyState extends NewsblocState {
  final List<Article> newsModel = [];
}
