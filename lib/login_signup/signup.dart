import 'package:arboretumproperties/login_signup/login.dart';
import 'package:arboretumproperties/main_categories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  ///Text Editing Controllers
  TextEditingController nameController = TextEditingController(text:'');
  TextEditingController ageController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  int genderSelector = 1;
  String genderString = "Male";
  int occupationSelector = 1;
  String occupationString = "Student";


  //image picker
  File _image;
  String _imageUrl = "";
  bool signupLoading = false;
  var _formKey = GlobalKey<FormState>();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });

      final FirebaseStorage _storgae =
      FirebaseStorage(storageBucket: 'gs://arboretum-17724.appspot.com/');
      StorageUploadTask uploadTask;
      String filePath = '${DateTime.now()}.png';
      uploadTask = _storgae.ref().child(filePath).putFile(image);
      uploadTask.onComplete.then((_) async {
        print(1);
        String url1 = await uploadTask.lastSnapshot.ref.getDownloadURL();
        print(url1);
        _imageUrl = url1;
      });
    }
  }

  final _scacffoldKey = GlobalKey<ScaffoldState>();

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
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(60.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: Offset(0, 5))
                            ]),
                        child: InkWell(
                          child: CircleAvatar(
                            child: _image == null
                                ? Icon(
                              Icons.camera_alt,
                              size: 50,
                            )
                                : null,
                            radius: 60,
                            backgroundImage:
                            _image != null ? FileImage(_image) : null,
                            backgroundColor: Colors.white,
                          ),
                          onTap: getImage,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Profile picture'),
                      SizedBox(
                        height: 30,
                      ),
                      _input('Name', 'Full name', Icons.person,nameController),
                      SizedBox(
                        height: 20,
                      ),
                      _input('Email', 'Email address', Icons.mail,emailController),
                      SizedBox(
                        height: 20,
                      ),
                      _input('Phone', 'Phone number', Icons.phone,phoneController),
                      SizedBox(
                        height: 20,
                      ),
                      _input('Age', 'age must be greater than 18',
                          Icons.calendar_today,ageController),
                      SizedBox(
                        height: 20,
                      ),
                      _input('Password', 'Enter password', Icons.vpn_key,passwordController),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    textColor: Colors.black,
                    color: Colors.grey[200],
                    label: Text(
                      'Gender',
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      _usergenderBottomsheet(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    textColor: Colors.black,
                    color: Colors.grey[200],
                    label: Text(
                      'Occupation',
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      _useroccupationBottomsheet(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                signupLoading
                    ? Center(child: CircularProgressIndicator()):Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    onPressed: () async {
                      //Condition to see if profile image is uploaded
                      if (_imageUrl != "" &&
                          _formKey.currentState.validate()) {
                        signUp();
                      } else {
                        _imageUrl == ''
                            ? showDialog(
                            context: context,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius
                                      .circular(18.0),
                                  side: BorderSide(
                                    color: Colors.red[400],
                                  )),
                              title: Text("Wait..."),
                              content:
                              Text("Image Not Uploaded"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color:
                                        Colors.red[400]),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ))
                            : null;
                      }
                    },
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    textColor: Colors.orange[200],
                    color: Colors.black,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account? ",
                      //style: TextStyle(color: Colors.black)
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.black)),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
              ],
            )));
  }

  void _usergenderBottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 120,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          genderSelector = 1;
                          genderString = 'Male';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: genderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Male',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          genderSelector = 2;
                          genderString = 'Female';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: genderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Female',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _useroccupationBottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              height: 120,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          occupationSelector = 1;
                          occupationString = 'Student';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: occupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Student',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          occupationSelector = 2;
                          occupationString = 'Professional';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: occupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Professional',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  ///Firebase creating user with email & password and error handling
  Future<void> signUp() async {
    setState(() {
      signupLoading = true;
    });
    try {
      final AuthResult user =
      (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ));

      if (user != null) {
        String userUid = user.user.uid;

        await addUsertoFirebase(userUid);

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
              return MainCategories();
            }), (route) => false);
        setState(() {
          signupLoading = false;
        });
      }
    } catch (signUpError) {
      setState(() {
        signupLoading = false;
      });

      //Error handling
      if (signUpError is PlatformException) {
        if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Email already in use"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_WEAK_PASSWORD') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Weak Password"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }

        if (signUpError.code == 'ERROR_INVALID_EMAIL') {
          showDialog(
              context: context,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.red[400],
                    )),
                title: Text("Invalid Email"),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ));
        }
      }
    }
  }

  ///function to add user data to a firebase collection
  Future<void> addUsertoFirebase(String userUid) async {
    await Firestore.instance.collection("users").document(userUid).setData({
      'userImage': _imageUrl,
      'name': nameController.text.trim(),
      'age':ageController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'password': passwordController.text.trim(),
      'gender': genderString,
      'occupation': occupationString,
      'x': 'good'
    });
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
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "This field must not be empty.";
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
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

}

