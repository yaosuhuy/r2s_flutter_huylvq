import 'package:flutter/material.dart';
import 'package:meal_planner_app/data/datasources/sqlite_helper.dart';

void showCategoriesDialog(BuildContext context) async {
  final categories = await SqliteHelper().getCategories();
  final TextEditingController _controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Manage Meal Categories'),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return ListTile(
                          title: Text(category['categoryName']),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await SqliteHelper().deleteCategory(category['id']);
                              setState(() {
                                categories.removeAt(
                                    index); // Xóa danh mục khỏi danh sách
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  // Thêm danh mục mới
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'New Category',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  if (_controller.text.isNotEmpty) {
                    final newCategoryId =
                        await SqliteHelper().insertCategory(_controller.text);
                    setState(() {
                      categories.add({
                        'id': newCategoryId,
                        'categoryName': _controller.text,
                      });
                    });
                    _controller.clear();
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}
