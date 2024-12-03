import 'package:flutter/material.dart';
import 'package:jsondemo/api_helper.dart';
import 'package:jsondemo/model/photomodel.dart';

class CategoryProvider extends ChangeNotifier {
  List<String> category = [
    "backgrounds",
    "fashion",
    "nature",
    "science",
    "education",
    "feelings",
    "health",
    "people",
    "religion",
    "places",
    "animals",
    "industry",
    "computer",
    "food",
    "sports",
    "transportation",
    "travel",
    "buildings",
    "business",
    "music"
  ];
  String selectedCategory = "backgrounds";
  List<Photomodel> photos = [];

  Future getPhotos() async {
    List<dynamic> resList = await ApiHelper.obj.getCategoryPhotos(selectedCategory);
    photos = resList.map((e) => Photomodel.fromJson(e)).toList();
    notifyListeners();
  }

  void selectCategory(String cname) {
    selectedCategory = cname;
    getPhotos();
    notifyListeners();
  }
}
