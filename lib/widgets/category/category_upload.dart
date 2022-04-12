import 'dart:html';

import 'package:admin_panel/screens/banner_screen.dart';
import 'package:admin_panel/services/firebase_services.dart';
import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/banner/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class CategoryUpload extends StatefulWidget {
  @override
  State<CategoryUpload> createState() => _CategoryUploadState();
}

class _CategoryUploadState extends State<CategoryUpload> {
  SideBarWidget _sideBar = SideBarWidget();

  FirebaseServices _services = FirebaseServices();

  var _fileNameTextController = TextEditingController();
  var _categoryNameTextController = TextEditingController();

  bool _visible = false;

  bool _imageSelected = true;

  String? _url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            Visibility(
              visible: _visible,
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 40,
                      child: TextField(
                        controller: _categoryNameTextController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'No Category Name not given',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: true,
                      child: SizedBox(
                          width: 300,
                          height: 40,
                          child: TextField(
                            controller: _fileNameTextController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Uploaded Image',
                              border: OutlineInputBorder(),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      onPressed: () {
                        uploadStorage();
                        print('ok');
                      },
                      child: Text(
                        'Upload Image',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    AbsorbPointer(
                      absorbing: _imageSelected,
                      child: FlatButton(
                        onPressed: () {
                          if (_categoryNameTextController.text.isEmpty) {
                            return _services.showMyDialog(
                                context: context,
                                title: 'Add new Category',
                                message: 'New category name not given');
                          }
                          _services
                              .uploadCategoryImageToDb(
                                  _url, _categoryNameTextController.text)
                              .then((downloadUrl) {
                            if (downloadUrl != null) {
                              return _services.showMyDialog(
                                  context: context,
                                  title: 'New Category',
                                  message: 'Saved New Category Successfully');
                            }
                          });
                          _categoryNameTextController.clear();
                          _fileNameTextController.clear();
                        },
                        child: Text('Save New Category',
                            style: TextStyle(color: Colors.white)),
                        color: _imageSelected ? Colors.black12 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Visibility(
              visible: _visible ? false : true,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: Text('Add new Category',
                    style: TextStyle(color: Colors.white)),
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage({required Function(File file) onSelected}) {
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() {
    final dateTime = DateTime.now();
    final path = 'CategoryImage/$dateTime';
    uploadImage(onSelected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _url = path;
        });

        fb
            .storage()
            .refFromURL('gs://delivery-app-79e14.appspot.com')
            .child(path)
            .put(file);
      }
    });
  }
}
