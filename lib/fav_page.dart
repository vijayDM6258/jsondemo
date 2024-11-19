import 'package:flutter/material.dart';
import 'package:jsondemo/main.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  List<String> favList = [];

  @override
  void initState() {
    favList = prefs.getStringList("fav") ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: favList.length,
        itemBuilder: (context, index) {
          String favItem = favList[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ListTile(
              //   title: Text("${favItem}"),
              //   subtitle: Text("des"),
              //   trailing: Icon(Icons.star),
              // ),
              Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Name : "),
                        Text("abccc"),
                      ],
                    ),
                    Row(children: [
                      Text("language"),
                      Text("en"),
                    ]),
                    Row(children: [
                      Text("id"),
                      Text("dd54"),
                    ]),
                    Row(children: [
                      Text("bio"),
                      Text("dd"),
                    ]),
                    Row(children: [
                      Text("version"),
                      Text("--"),
                    ]),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
