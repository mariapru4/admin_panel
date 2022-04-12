import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';

class SubCategory extends StatefulWidget {
  final String categoryName;
  SubCategory(this.categoryName);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  FirebaseServices _services = FirebaseServices();

  var _subCatNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * .9,
        width: 500,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
            future: _services.category.doc(widget.categoryName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('No Subcategories Added'),
                  );
                } else {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.categoryName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Divider(
                              thickness: 3,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(data['subCat'][index]['name']));
                            },
                            itemCount: data['subCat'] == null
                                ? 0
                                : data['subCat'].length,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 4,
                            ),
                            Container(
                              color: Colors.grey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      'Add new sub category',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: SizedBox(
                                        height: 30,
                                        child: TextField(
                                          controller: _subCatNameTextController,
                                          decoration: InputDecoration(
                                              hintText: 'Sub Category Name',
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              focusedBorder:
                                                  OutlineInputBorder(),
                                              contentPadding:
                                                  EdgeInsets.only(left: 10)),
                                        ),
                                      )),
                                      FlatButton(
                                          color: Colors.black54,
                                          onPressed: () {
                                            if (_subCatNameTextController
                                                .text.isEmpty) {
                                              return _services.showMyDialog(
                                                  context: context,
                                                  title: 'Add New SubCategory',
                                                  message:
                                                      'Need to give SubCategory Name');
                                            }
                                            DocumentReference doc = _services
                                                .category
                                                .doc(widget.categoryName);
                                            doc.update({
                                              'subCat': FieldValue.arrayUnion([
                                                {
                                                  'name':
                                                      _subCatNameTextController
                                                          .text
                                                }
                                              ]),
                                            });
                                            setState(() {});
                                            _subCatNameTextController.clear();
                                          },
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
