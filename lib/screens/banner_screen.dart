import 'dart:html';
import 'package:admin_panel/services/firebase_services.dart';
import 'package:admin_panel/services/sidebar.dart';
import 'package:admin_panel/widgets/banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:firebase/firebase.dart' as fb;

class BannerScreen extends StatefulWidget {
  static const id = 'banners-screen';

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  SideBarWidget _sideBar = SideBarWidget();
  FirebaseServices _services = FirebaseServices();
  var _fileNameTextController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = true;
  String? _url;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      sideBar: _sideBar.SideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add / Delete Home Screen Banner'),
              Divider(
                thickness: 5,
              ),
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              Container(
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
                              AbsorbPointer(
                                absorbing: true,
                                child: SizedBox(
                                    width: 300,
                                    height: 40,
                                    child: TextField(
                                      controller: _fileNameTextController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 1),
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
                                    _services
                                        .uploadBannerImageToDb(_url)
                                        .then((downloadUrl) {
                                      if (downloadUrl != null) {}
                                    });
                                  },
                                  child: Text('Save Image',
                                      style: TextStyle(color: Colors.white)),
                                  color: _imageSelected
                                      ? Colors.black12
                                      : Colors.black54,
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
                          child: Text('Add new Banner',
                              style: TextStyle(color: Colors.white)),
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
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
    final path = 'bannerImage/$dateTime';
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
