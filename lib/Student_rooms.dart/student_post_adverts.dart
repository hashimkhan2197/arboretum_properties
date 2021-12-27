import 'dart:io';

import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

class StudentPostAdverts extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  StudentPostAdverts(this.userSnapshot);

  @override
  _StudentPostAdvertsState createState() => _StudentPostAdvertsState();
}

class _StudentPostAdvertsState extends State<StudentPostAdverts> {
  int studentGenderSelector = 1;
  String studentGenderString = '1 male';
  int typeOfRoomSelector = 1;
  String typeOfRoomString = 'Double bed room';
  int budgetSelector = 1;
  String budgetString = '200 - 300';
  int smokingSelector = 1;
  String smokingString = 'Yes';
  int petSelector = 1;
  String petString = 'Yes';
  int newGenderSelector = 1;
  String newGenderString = 'Males';
  int newOccupationSelector = 1;
  String newOccupationString = "Don't mind";
  int newSmokingSelector = 1;
  String newSmokingString = "Don't mind";

  bool _loading = false;
//  DateTime _dateTime;


  //variables
  bool furnishedCheckbox = false;
  bool sharedlivingroomCheckbox = false;
  bool washingmachineCheckbox = false;
  bool gardenCheckbox = false;
  bool balcanyCheckbox = false;
  bool parkingCheckbox = false;
  bool garageCheckbox = false;
  bool disabledaccessCheckbox = false;
  bool broadbandCheckbox = false;
  bool ensuitCheckbox = false;
  bool lastNameDisplayCheckbox = false;
  DateTime _dateTime;



  ///Text Controllers
  TextEditingController minAccomodationPeriodController =
      TextEditingController(text: '');
  TextEditingController maxAccomodationPeriodController =
      TextEditingController(text: '');
  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController newMinAgeController = TextEditingController(text: '');

  //small containers controllers
  TextEditingController newMaxAgeController = TextEditingController(text: '');
  TextEditingController titleController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');

  @override
  void dispose() {
    minAccomodationPeriodController.dispose();
    maxAccomodationPeriodController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    newMinAgeController.dispose();
    newMaxAgeController.dispose();
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  //multi image picker
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  void initState() {
    _dateTime = DateTime.now();
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 25,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Arboretum Properties",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      images = resultList;
      if (images.length > 0) print(images.first.name);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Room wanted',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            children: [
              SizedBox(height: 15),
              _heading('Post Advert'),
              SizedBox(height: 15),
              //Select gender
              Padding(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  textColor: Colors.black,
                  color: Colors.grey[200],
                  label: Text(
                    'Select your gender',
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _selectgenderBottomsheet(context);
                  },
                ),
              ),
              //Select type of room
              Padding(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  textColor: Colors.black,
                  color: Colors.grey[200],
                  label: Text(
                    'Type of room',
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _roomTypeBottomsheet(context);
                  },
                ),
              ),
              //Select budget
              Padding(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  textColor: Colors.black,
                  color: Colors.grey[200],
                  label: Text(
                    'Select your budget',
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _selectbudgetBottomsheet(context);
                  },
                ),
              ),
              SizedBox(height: 35),
              Center(
                  child: Text(
                'I am available to move in from',
                style: TextStyle(fontSize: 15),
              )),
              //date of birth
              // Text(_dateTime == null
              //     ? ''
              //     :
              //     //_dateTime.toString()
              //     'Date Picked', textAlign: TextAlign.center,),
              Padding(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  textColor: Colors.black,
                  color: Colors.grey[200],
                  label: Text('Select date'),
                  icon: Icon(Icons.date_range),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate:
                                _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2061))
                        .then((date) {
                      setState(() {
                        _dateTime = date;
                        print(_dateTime.toString());
                      });
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              //period
              Center(
                  child: Text(
                'period accommodation needed for',
                style: TextStyle(fontSize: 15),
              )),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _input(
                      'No minimum', 'months', minAccomodationPeriodController),
                  Text('to'),
                  _input(
                      'No maximum', 'months', maxAccomodationPeriodController),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              _heading('I Would Prefer These Amenities'),
              SizedBox(height: 5),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: sharedlivingroomCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            sharedlivingroomCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Shared living room',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: furnishedCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            furnishedCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Furnished',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: gardenCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            gardenCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Garden / roof terrace',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(width: 5),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: garageCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            garageCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Garage',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: balcanyCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            balcanyCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Balcony / roof terrace',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(width: 2),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: parkingCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            parkingCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Parking',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: washingmachineCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            washingmachineCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Washing machine',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(width: 27),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: broadbandCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            broadbandCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Broadband',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: disabledaccessCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            disabledaccessCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'Disabled access',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(width: 35),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.black,
                        checkColor: Colors.white,
                        value: ensuitCheckbox,
                        onChanged: (bool value) {
                          setState(() {
                            ensuitCheckbox = value;
                          });
                        },
                      ),
                      Text(
                        'En suite',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 10),
              _heading('About You'),
              SizedBox(height: 5),
              //Select type of room
              Padding(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  textColor: Colors.black,
                  color: Colors.grey[200],
                  label: Text(
                    'Do you smoke?',
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _doyousmokeBottomsheet(context);
                  },
                ),
              ),
              //Select budget
              Padding(
                padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  textColor: Colors.black,
                  color: Colors.grey[200],
                  label: Text(
                    'Do you have any pets',
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _anypetsBottomsheet(context);
                  },
                ),
              ),
              SizedBox(height: 20),
              _inputname('First name', 'First name', firstNameController),
              SizedBox(height: 10),
              _inputname('Last name', 'Last name', lastNameController),
              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.black,
                    checkColor: Colors.white,
                    value: lastNameDisplayCheckbox,
                    onChanged: (bool value) {
                      setState(() {
                        lastNameDisplayCheckbox = value;
                      });
                    },
                  ),
                  Text(
                    'Display last name on advert?',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
              Divider(),
              SizedBox(height: 10),
              _heading('Your Preferred Flatmate'),
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
                    _flatmategenderBottomsheet(context);
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
                    _flatmateoccupationBottomsheet(context);
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
                    'Smoking',
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    _flatmatesmokingBottomsheet(context);
                  },
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'Age range',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _input('Age', 'Minimum 18', newMinAgeController),
                  Text('to'),
                  _input('Age', 'Maximum 99', newMaxAgeController),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              _inputname('Title', 'Short description', titleController),
              SizedBox(height: 10),
              _description('Description...', descriptionController),
              SizedBox(height: 20),

              ///Upload Pictures
              ///upload pictures Widget
              Center(
                child: Text(
                  'Upload pictures',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey[500]),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ]),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.art_track_sharp,
                      color: Colors.grey[700],
                      size: 40,
                    ),
                  ),
                  onTap: loadAssets,
                ),
              ),
              if (images.length != 0) buildImageListView(),
              SizedBox(height: 20),

              ///Post Advert Button

              _loading == true
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: Colors.grey[300],
                        textColor: Colors.black,
                        child: Text("Post Advert",
                            style: TextStyle(
                              fontSize: 16.0,
                            )),
                        onPressed: () async {
                          if (firstNameController.text == "") {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red[400],
                                      )),
                                  title: Text("First Name"),
                                  content:
                                      Text("Please enter your first name."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style:
                                            TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          }
                          else if (titleController.text == "") {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red[400],
                                      )),
                                  title: Text("Title"),
                                  content: Text("Please provide a title."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style:
                                            TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          }
                          else if (descriptionController.text == "") {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red[400],
                                      )),
                                  title: Text("Description.."),
                                  content: Text("Please write a description."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style:
                                            TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          }
                          else if (lastNameController.text == "") {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red[400],
                                      )),
                                  title: Text("Last Name"),
                                  content: Text("Please enter your last name."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style:
                                            TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          }
                          else if (images.length < 1) {
                            showDialog(
                                context: context,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.red[400],
                                      )),
                                  title: Text("Images"),
                                  content: Text(
                                      "Please provide at least one image."),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        "OK",
                                        style:
                                            TextStyle(color: Colors.red[400]),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    )
                                  ],
                                ));
                          }
                          else if (titleController.text != "" &&
                              descriptionController.text != '' &&
                              firstNameController.text != "" &&
                          lastNameController.text != '' && images.length > 0) {
                            List<String> urlList = List<String>();
                            bool errorStorage = false;
                            setState(() {
                              _loading = true;
                            });

                            for (Asset image in images) {
                              try {
                                var path2 =
                                    await FlutterAbsolutePath.getAbsolutePath(
                                        image.identifier);
                                File file = File(path2);
                                String fileName =
                                    '${image.name + DateTime.now().toString()}.png';

                                ///Saving Pdf to firebase
                                StorageReference reference = FirebaseStorage
                                    .instance
                                    .ref()
                                    .child(fileName);
                                StorageUploadTask uploadTask =
                                    reference.putData(file.readAsBytesSync());
                                String urlImage =
                                    await (await uploadTask.onComplete)
                                        .ref
                                        .getDownloadURL();
                                urlList.add(urlImage);
                              } catch (e) {
                                setState(() {
                                  errorStorage = true;
                                  _loading = false;
                                });
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Error!!"),
                                      content: Text(
                                          "An error has occured. Please check your internet connection or try again after some time."),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Colors.red[400]),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ));
                              }
                            }
                            if (errorStorage == false)
                              Firestore.instance.collection('studentAds').document(widget.userSnapshot.data.documentID).setData({
                                'moveInFrom': _dateTime.toString(),
                                'approved': false,
                                'urlList': urlList,
                                'timePosted': DateTime.now().toString(),
                                //all TextFormFields
                                'minPerionStay':
                                    minAccomodationPeriodController.text
                                        .trim(),
                                'maxPerionStay':
                                    maxAccomodationPeriodController.text
                                        .trim(),
                                'newMinAge':
                                    newMinAgeController.text.trim(),
                                'newMaxAge':
                                    newMaxAgeController.text.trim(),
                                'title': titleController.text.trim(),
                                'description':
                                    descriptionController.text.trim(),
                                'firstName': firstNameController.text.trim(),
                                'lastName': lastNameController.text.trim(),
                                //All Checkboxes
                                'sharedLivingRoom': sharedlivingroomCheckbox,
                                'furnishings': furnishedCheckbox,
                                'garden': gardenCheckbox,
                                'garage': garageCheckbox,
                                'balcony': balcanyCheckbox,
                                'parking': parkingCheckbox,
                                'washingMachine': washingmachineCheckbox,
                                'broadband': broadbandCheckbox,
                                'disabledAccess': disabledaccessCheckbox,
                                'ensuite': ensuitCheckbox,
                                'lastNameDisplay': lastNameDisplayCheckbox,
                                //bottom sheet selectors
                                'gender': studentGenderString,
                                'typeOfRoom': typeOfRoomString,
                                'budget': budgetString,
                                'smoking': smokingString,
                                'pets': petString,
                                'newGender': newGenderString,
                                'newOccupation': newOccupationString,
                                'newSmoking': newSmokingString,
                                //---------------
                                'personPic': widget.userSnapshot.data['userImage'],
                                'personUid':widget.userSnapshot.data.documentID,
                                'personName': widget.userSnapshot.data['name'],
                                'personEmail': widget.userSnapshot.data['email'],
                                'personAge': widget.userSnapshot.data['age']
                                //

                              }).then((value) {
                                _loading = false;
                                Navigator.pop(context);
                              }).catchError((e) {
                                setState(() {
                                  _loading = false;
                                });
                                showDialog(
                                    context: context,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side: BorderSide(
                                            color: Colors.red[400],
                                          )),
                                      title: Text("Error!!"),
                                      content: Text(
                                          "An error has occured. Please check your internet connection or try again after some time."),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text(
                                            "OK",
                                            style: TextStyle(
                                                color: Colors.red[400]),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ));
                              });
                          }
                        },
                      ),
                    ),
              SizedBox(height: 20),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  Widget buildImageListView() {
    return Container(
      height: 250,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AssetThumb(
              asset: images[index],
              width: 200,
              height: 200,
            ),
          );
        },
        itemCount: images.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
///Student Gender Selector Bottomsheet
  void _selectgenderBottomsheet(context) {
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
              height: 280,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          studentGenderSelector = 1;
                          studentGenderString = '1 Male';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: studentGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '1 male',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //1 female
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          studentGenderSelector = 2;
                          studentGenderString = '1 Female';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2,groupValue: studentGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '1 Female',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                   //1 male 1 female
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          studentGenderSelector = 3;
                          studentGenderString = '1 Male 1 Female';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: studentGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '1 Male 1 Female',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //2males
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          studentGenderSelector = 4;
                          studentGenderString = '2 Males';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 4, groupValue: studentGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '2 Males',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //2 Females
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          studentGenderSelector = 5;
                          studentGenderString = '2 Female';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 5, groupValue: studentGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '2 Female',
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
///Type of room bottom sheet
  void _roomTypeBottomsheet(context) {
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
              height: 230,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //Double Bed Room
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 1;
                          typeOfRoomString = 'Double Bed Room';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Double Bed Room',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //Single Bed Room
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 2;
                          typeOfRoomString = 'Single Bed Room';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Single Bed Room',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //En-suit
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 3;
                          typeOfRoomString = 'En-suit';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'En-suit',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //Studio
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 4;
                          typeOfRoomString = 'Studio';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 4, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Studio',
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
///budget bottom sheet
  void _selectbudgetBottomsheet(context) {
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
              height: 320,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    //200 - 300
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          budgetSelector = 1;
                          budgetString = '200 - 300';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: budgetSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '200 -300',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //300 - 400
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          budgetSelector = 2;
                          budgetString = '300 - 400';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: budgetSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '300 -400',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //400 - 500
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          budgetSelector = 3;
                          budgetString = '400 - 500';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: budgetSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '400 -500',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //500 - 600
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          budgetSelector = 4;
                          budgetString = '500 - 600';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 4, groupValue: budgetSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '500 -600',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //600 - 700
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          budgetSelector = 5;
                          budgetString = '600 - 700';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 5, groupValue: budgetSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '600 -700',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //700+
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          budgetSelector = 6;
                          budgetString = '700+';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 6, groupValue: budgetSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            '700',
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
///smoking bottom sheet
  void _doyousmokeBottomsheet(context) {
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
                          smokingSelector = 1;
                          smokingString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: smokingSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Yes',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    //no
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          smokingSelector = 2;
                          smokingString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: smokingSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'No',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),      ],
                ),
              ),
            ),
          );
        });
  }
///pets bottomsheet
  void _anypetsBottomsheet(context) {
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
                          petSelector = 1;
                          petString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: petSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Yes',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          petSelector = 2;
                          petString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: petSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'No',
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
///new gender bottom sheet
  void _flatmategenderBottomsheet(context) {
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
              height: 200,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newGenderSelector = 1;
                          newGenderString = 'Males';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Males',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newGenderSelector = 2;
                          newGenderString = 'Females';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Females',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newGenderSelector = 3;
                          newGenderString = "Don't mind";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: newGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            "Don't mind",
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
///new occupation bottomsheet
  void _flatmateoccupationBottomsheet(context) {
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
              height: 180,
              //height: MediaQuery.of(context).size.height * 80,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newOccupationSelector = 1;
                          newOccupationString = "Don't mind";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            "Don't mind",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newOccupationSelector = 2;
                          newOccupationString = "Students";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            "Students",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newOccupationSelector = 3;
                          newOccupationString = "Professionals";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: newOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            "Professionals",
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
///new Smoking
  void _flatmatesmokingBottomsheet(context) {
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
                          newSmokingSelector = 1;
                          newSmokingString = "Don't mind";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newSmokingSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            "Don't mind",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newSmokingSelector = 2;
                          newSmokingString = "No Thanks";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newSmokingSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            "No Thanks",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),                  ],
                ),
              ),
            ),
          );
        });
  }
}

Widget _input(String label, String hint, TextEditingController controller) {
  return Container(
    height: 50,
    width: 150,
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
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelStyle: TextStyle(
              color: Colors.grey[600],
            ),
            labelText: label,
            hintText: hint,
            focusColor: Colors.grey,

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

Widget _inputname(String label, String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
    child: Container(
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
          controller: controller,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
              labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

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
    ),
  );
}

Widget _description(String hint, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
    child: Container(
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
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
              //labelText: label,
              hintText: hint,
              focusColor: Colors.grey,

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
    ),
  );
}

Widget _heading(String title) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[600]),
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      ),
    ),
  );
}
