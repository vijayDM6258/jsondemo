import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsondemo/model/photomodel.dart';
import 'package:jsondemo/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryPhotoScreen extends StatefulWidget {
  const CategoryPhotoScreen({super.key});

  @override
  State<CategoryPhotoScreen> createState() => _CategoryPhotoScreenState();
}

class _CategoryPhotoScreenState extends State<CategoryPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Consumer<CategoryProvider>(
            builder: (context, categoryProvider, child) {
              return Wrap(
                children: List.generate(
                  categoryProvider.category.length,
                  (index) {
                    String cname = categoryProvider.category[index];
                    bool isSelected = (cname == categoryProvider.selectedCategory);
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ActionChip(
                        label: Text(cname),
                        backgroundColor: isSelected ? Colors.blue : null,
                        onPressed: () {
                          categoryProvider.selectCategory(cname);
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<CategoryProvider>(builder: (context, categoryProvider, child) {
              return GridView.builder(
                itemCount: categoryProvider.photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (context, index) {
                  Photomodel photo = categoryProvider.photos[index];
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(photo.largeImageURL ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text("${photo.user}"),
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }
}
