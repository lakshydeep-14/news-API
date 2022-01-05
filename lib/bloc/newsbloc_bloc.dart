import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:newsapp/Models/newsmodel.dart';
import 'package:newsapp/data/newsapi.dart';

part 'newsbloc_event.dart';
part 'newsbloc_state.dart';

class NewsblocBloc extends Bloc<NewsblocEvent, NewsblocState> {
  final NewsFetching newsFetching;
  NewsblocBloc(this.newsFetching) : super(NewsblocInitial()) {
    on<NewsFetchingEvent>((event, emit) async {
      await newsFetching.fetchAllNews().then((value) {
        emit(NewsblocFetched(value.articles));
      });
    });
  }
}
