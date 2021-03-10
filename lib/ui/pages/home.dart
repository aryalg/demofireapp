import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iremember/enums/viewstate.dart';
import 'package:iremember/ui/pages/add.dart';
import 'package:iremember/ui/pages/base_screen.dart';
import 'package:iremember/viewmodels/home_view_model.dart';

import '../../models/todo.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    EasyLoading.instance
      ..backgroundColor = Colors.black.withOpacity(0.4)
      ..maskColor = Colors.black.withOpacity(0.4)
      ..loadingStyle = EasyLoadingStyle.light
      ..contentPadding = EdgeInsets.all(20.0)
      ..indicatorSize = 60.0;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen<HomeModel>(
      onModelReady: (model) => model.fetchList(),
      builder: (context, model, child) {
        if (model.state == ViewState.Busy) {
          return Container();
        }
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
              onPressed: () async {
                bool isUpdated = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddPage(),
                  ),
                );

                if (isUpdated == null) {
                  isUpdated = false;
                }

                if (isUpdated) {
                  model.fetchList();
                }
              },
            ),
            body: model.todoList == null
                ? Center(
                    child: Text('Failed to Fetch Data'),
                  )
                : ListView.builder(
                    itemCount: model.todoList.length,
                    itemBuilder: (context, index) {
                      Todo todo = model.todoList[index];
                      return ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: Image.network(
                            todo.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // trailing: Icon(
                        //   Icons.delete,
                        // ),
                      );
                    }));
      },
    );
  }
}
