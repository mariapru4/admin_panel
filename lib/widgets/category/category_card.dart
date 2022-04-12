import 'package:admin_panel/widgets/category/subcategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final DocumentSnapshot document;

  CategoryCard(this.document);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return SubCategory(document['name']);
            });
      },
      child: SizedBox(
        height: 150,
        width: 150,
        child: Card(

          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Image.network(document['image']),
                ),
                Flexible(
                    child: Text(
                  document['name'],
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
