import 'package:flutter/material.dart';
import 'package:jsondemo/api_helper.dart';
import 'package:jsondemo/model/RestUserModel.dart';

class PostApiScreen extends StatefulWidget {
  const PostApiScreen({super.key});

  @override
  State<PostApiScreen> createState() => _PostApiScreenState();
}

class _PostApiScreenState extends State<PostApiScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isDeleteLoad = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Add User"),
                      content: Form(
                        key: globalKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: name,
                              decoration: InputDecoration(
                                hintText: "Enter Name",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Name";
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Enter Email",
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Email Address";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                /// Api add
                                ApiHelper.obj.addUser(name.text, email.text);
                              }
                            },
                            child: Text("Add"))
                      ],
                    );
                  },
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
          future: ApiHelper.obj.getRestUsers(),
          builder: (context, snap) {
            if (snap.hasData) {
              List users = snap.data ?? [];
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> user = users[index];
                  RestUserModel restUserModel = RestUserModel.fromJson(user);
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text("${restUserModel.id}"),
                    ),
                    trailing: StatefulBuilder(builder: (context, fun) {
                      if (isDeleteLoad) {
                        return CircularProgressIndicator();
                      }
                      return IconButton(
                          onPressed: () async {
                            isDeleteLoad = true;
                            fun(() {});
                            bool isDelete = await ApiHelper.obj.deleteUser(restUserModel.id ?? 0);
                            if (isDelete) {
                              users.removeAt(index);
                              setState(() {});
                            }
                            isDeleteLoad = false;
                            fun(() {});
                          },
                          icon: Icon(Icons.delete));
                    }),
                    title: Text(restUserModel.name ?? "-"),
                    subtitle: Text(restUserModel.email ?? "-"),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
