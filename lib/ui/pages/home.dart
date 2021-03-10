import 'package:flutter/material.dart';
import 'package:iremember/ui/pages/add.dart';

import '../../locator.dart';
import '../../models/todo.dart';
import '../../services/database_service.dart';
import '../../services/database_service.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDataProvider _dataProvider =
      locator<FirebaseDataProvider>();

  @override
  void initState() {
    super.initState();

    _dataProvider.getAllTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          leading: Icon(Icons.home),
          backgroundColor: Colors.blueAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AddPage(),
              ),
            );
          },
        ),
        body: FutureBuilder<List<Todo>>(
            future: _dataProvider.getAllTodoList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Todo todo = snapshot.data[index];
                      return ListTile(
                          title: Text(todo.title),
                          subtitle: Text(todo.description),
                          leading:
                              Image.network(todo.imageUrl));
                    });
              }

              return Container();
            }));
  }
}
