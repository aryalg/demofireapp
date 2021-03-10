import 'package:iremember/enums/viewstate.dart';
import 'package:iremember/models/todo.dart';
import 'package:iremember/services/database_service.dart';
import 'package:iremember/viewmodels/base_model.dart';

import '../locator.dart';

class HomeModel extends BaseModel {
  List<Todo> _todoList;

  List<Todo> get todoList => _todoList;

  FirebaseDataProvider _dataProvider =
      locator<FirebaseDataProvider>();

  void fetchList() async {
    setState(ViewState.Busy);

    try {
      // ProductList productList = await _api.getProducts(token);
      final List<Todo> fetchedList =
          await _dataProvider.getAllTodoList();

      _todoList = fetchedList;
      setState(ViewState.Idle);
    } catch (err) {
      print(err);
      setState(ViewState.Idle);
    }
  }
}
