import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:jsondemo/api_helper.dart';
import 'package:jsondemo/model/UserDataModel.dart';
import 'package:jsondemo/model/user_model.dart';

class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: FutureBuilder<List<dynamic>>(
                future: ApiHelper.obj.getUserLit(),
                builder: (context, val) {
                  if (val.hasData) {
                    List users = val.data ?? [];
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> user = users[index];
                        UserDataModel userModel = UserDataModel.fromJson(user);
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userModel.name ?? ""),
                                Text("email : ${userModel.email}"),
                                Text("address :${userModel.address?.city}"),
                                Text("Website : ${userModel.website}"),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.5,
              child: FutureBuilder<List<dynamic>>(
                  future: ApiHelper.obj.getPhotos(),
                  builder: (context, val) {
                    if (val.hasData) {
                      List photos = val.data ?? [];
                      return GridView.builder(
                        itemCount: photos.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
                        itemBuilder: (context, index) {
                          Map<String, dynamic> photo = photos[index];
                          return Image.network(
                            photo['previewURL'],
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
      ),
    );
  }
}
