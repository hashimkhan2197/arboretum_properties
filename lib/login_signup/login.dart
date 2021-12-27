import 'package:arboretumproperties/login_signup/signup.dart';
import 'package:arboretumproperties/main_categories.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var _formKey = GlobalKey<FormState>();
  final _scacffoldKey = GlobalKey<ScaffoldState>();
  var _isLoading = false;

  ///Text Editing Controllers
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scacffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  _input('Email', 'Email address', Icons.mail,emailController),
                  SizedBox(
                    height: 20,
                  ),
                  _inputPassword('Password', 'Enter password', Icons.vpn_key,passwordController),
                  SizedBox(
                    height: 30,
                  ),
                  if (!_isLoading)
                  GestureDetector(
                    onTap: () {
                      _resetPassword(emailController.text, context);
                    },
                    child: Text(
                      "Forgot Password?",
                    ),
                  ),
                  if (!_isLoading)
                  SizedBox(
                    height: 10,
                  ),
                  if (_isLoading)
                    Center(child: CircularProgressIndicator()),
                  if (!_isLoading)
                  RaisedButton(

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                      //Only gets here if the fields pass
                      _formKey.currentState.save();
                      _login(emailController.text, passwordController.text, context);
                    }
                    },
                    padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                    textColor: Colors.orange[200],
                    color: Colors.black,
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (!_isLoading)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don\'t have account ? ",
                        //style: TextStyle(color: Colors.black)
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup(),),);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black)),
                          ),
                          child: Text(
                            "Signup",
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String label, String hint, IconData icon,TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            // BoxShadow(
            //     color: Colors.grey.withOpacity(0.3),
            //     blurRadius: 10,
            //     offset: Offset(0, 5))
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextFormField(
          obscureText: false,
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return "This field must not be empty.";
            }
            return null;
          },
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[600],fontSize: 18),
              labelText: label,
              hintText: hint,
              focusColor: Colors.grey,
              prefixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
              //fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              fillColor: Colors.green),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
  Widget _inputPassword(String label, String hint, IconData icon,TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          boxShadow: [
            // BoxShadow(
            //     color: Colors.grey.withOpacity(0.3),
            //     blurRadius: 10,
            //     offset: Offset(0, 5))
          ]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextFormField(
          obscureText: true,
          controller: controller,
          validator: (value) {
            if (value.isEmpty) {
              return "This field must not be empty.";
            }
            return null;
          },
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[600],fontSize: 18),
              labelText: label,
              hintText: hint,
              focusColor: Colors.grey,
              prefixIcon: Icon(
                icon,
                color: Colors.grey,
              ),
              //fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              fillColor: Colors.green),
          //keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
      ),
    );
  }
  void _login(email, password, BuildContext ctx) async {

    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
            return MainCategories();
          }), (route) => false);
    } on PlatformException catch (err) {
      var message = "An error has occured, please check your credentials.";

      if (err.message != null) {
        message = err.message;
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }
  void _resetPassword(String email, BuildContext ctx) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          "A recovery email has been sent to you.",
        ),
        backgroundColor: Theme.of(ctx).primaryColor,
      ));
    } on PlatformException catch (err) {
      var message = "An error has occured, please check your credentials.";

      if (err.message != null) {
        message = err.message;
      }

      if (email == null || email.isEmpty) {
        message = "Please enter your registered email";
      }

      _scacffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        backgroundColor: Theme.of(ctx).errorColor,
      ));

      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);

      setState(() {
        _isLoading = false;
      });
    }
  }

}

