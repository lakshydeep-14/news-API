import 'package:newsapp/Models/newsmodel.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/utils/strings.dart';

class NewsFetching {
  final int successCode = 200;
  Future<NewsModel> fetchAllNews() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == successCode) {
        return newsModelFromJson(response.body);
      } else {
        throw Exception('failed to load news');
      }
    } on Exception catch (e) {
      return NewsModel();
    }
  }
}
