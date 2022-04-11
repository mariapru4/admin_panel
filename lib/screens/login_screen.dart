import 'package:admin_panel/screens/home_screen.dart';
import 'package:admin_panel/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'lodin-screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  FirebaseServices _services = FirebaseServices();
  String? username;
  String? password;

  login() async {
    _services.getAdminCerdentials().then((value) {
      value.docs.forEach((doc) async {
        if (doc.get('username') == username) {
          if (doc.get('password') == password) {
            final userCredential =
                await FirebaseAuth.instance.signInAnonymously();

            if (userCredential.user!.uid != null) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomeScreen()));
              return;
            }
          } else {
            _services.showMyDialog(
                context: context,
                title: 'Incorrect Password',
                message: 'Password you entered is incorrect.Please try again');
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF84c225),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF84c225), Colors.white],
              stops: [1.0, 1.0],
              begin: Alignment.topCenter,
              end: Alignment(0.0, 0.0)),
        ),
        child: Center(
          child: Container(
            width: 300,
            height: 400,
            child: Card(
              elevation: 6,
              shape:
                  Border.all(color: Theme.of(context).primaryColor, width: 2),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset('images/logo.png'),
                            Text('Delivery  App',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 20)),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Username';
                                }
                                setState(() {
                                  username = value;
                                });
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: 'User Name',
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2)),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Password';
                                }
                                if (value.length < 6) {
                                  return 'Minimum 6 characters';
                                }
                                setState(() {
                                  password = value;
                                });
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.vpn_key_outlined),
                                hintText: 'Password',
                                contentPadding:
                                    EdgeInsets.only(left: 20, right: 20),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      login();
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
