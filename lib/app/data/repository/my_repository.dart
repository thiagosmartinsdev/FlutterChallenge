import 'package:meta/meta.dart';
import 'package:trello_challenge/app/data/provider/api.dart';

class MyRepository {
  final MyApiClient apiClient;

  MyRepository({@required this.apiClient}) : assert(apiClient != null);

  add(obj) {
    return apiClient.add(obj);
  }
}
