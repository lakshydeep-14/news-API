import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/bloc/newsbloc_bloc.dart';
import 'package:newsapp/data/newsapi.dart';
import 'package:newsapp/screens/NewsList.dart';

class HomePage extends StatelessWidget {
  final NewsFetching a;
  const HomePage({Key? key, required this.a}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final a = BlocProvider.of<NewsblocBloc>(context);
    // a.add(NewsFetchingEvent());
    return BlocProvider<NewsblocBloc>(
      create: (_) => NewsblocBloc(a)..add(NewsFetchingEvent()),
      child: Scaffold(body: BlocBuilder<NewsblocBloc, NewsblocState>(
        builder: (context1, state) {
          if (state is NewsblocInitial) {
            return const Center(child: Text("Loading"));
          } else if (state is NewsblocFetched) {
            return NewsList(newsList: state.newsModel!);
          } else if (state is NewsblocEmptyState) {
            return const Center(child: Text("No Data..."));
          } else {
            return const Center(child: Text("Loading else"));
          }
        },
      )),
    );
  }
}
