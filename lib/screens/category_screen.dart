import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/category/category_list_widget.dart';
import 'package:admin_panel/widgets/category/category_upload.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class CategoryScreen extends StatelessWidget {
  static const id = 'category-screen';
  SideBarWidget _sideBar = SideBarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.grey[105],
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      sideBar: _sideBar.SideBarMenus(context, CategoryScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add New Categories and Sub Categories'),
              Divider(
                thickness: 5,
              ),
              CategoryUpload(),
              Divider(
                thickness: 5,
              ),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
