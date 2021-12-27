import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AdminEditAdvert extends StatefulWidget {
  final AsyncSnapshot userSnapshot;
  final DocumentSnapshot apartmentSnapshot;
  AdminEditAdvert(this.userSnapshot,this.apartmentSnapshot);

  @override
  _AdminEditAdvertState createState() => _AdminEditAdvertState();
}

class _AdminEditAdvertState extends State<AdminEditAdvert> {
  @override
  //multi image picker
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  List<dynamic> urlPicList = List<dynamic>();


  Widget buildImageListView() {
    return Container(height: 250,
      child: ListView.builder(itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AssetThumb(
            asset: images[index],
            width: 200,
            height: 200,
          ),
        );
      },itemCount: images.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
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
      if(images.length > 0)
        print(images.first.name);
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

  bool _loading = false;
  bool _multiPickerBool = false;

  //Post this Advert in Section
  bool studentRoomsCheckbox ;
  bool professionalRoomsCheckbox;
  bool shortTermStayCheckbox;
  bool apartmentsCheckbox ;
  //bottom sheet selectors
  int typeOfPropertySelector ;
  String typeOfPropertyString;
  int sizeOfPropertySelector ;
  String sizeOfPropertyString;
  int typeOfRoomSelector ;
  String typeOfRoomString;

  ///Amenities
  //checkboxes
  bool livingRoomCheckbox;
  bool gardenCheckbox ;
  bool balconyCheckbox;
  bool parkingCheckbox;
  bool garageCheckBox ;
  bool disabledAccessCheckbox;
  //bottom sheet selectors
  int furnishingsSelector ;
  String furnishingsString ;
  int billsIncludedSelector ;
  String billsIncludedString ;
  int broadbandSelector ;
  String broadbandString ;

  var perWeekSelector ;
  String perWeekString ;
  DateTime _dateTime;
  List<DateTime> _multiDateList = List<DateTime>();
  ///Existing Flatmates
  //bottom sheet selectors
  int otherFlatmatesGenderSelector ;
  String otherFlatmatesGenderString ;
  int otherFlatmatesOccupationSelector ;
  String otherFlatmatesOccupationString ;
  int otherFlatmatesSmokingSelector ;
  String otherFlatmatesSmokingString ;
  int otherFlatmatesPetsSelector;
  String otherFlatmatesPetsString ;
  /// New Flatmates Preferences
  //bottom sheet selectors
  int newFlatmatesGenderSelector ;
  String newFlatmatesGenderString  ;
  int newFlatmatesOccupationSelector ;
  String newFlatmatesOccupationString ;
  int newFlatmatesSmokingSelector ;
  String newFlatmatesSmokingString ;
  int newFlatmatesPetsSelector ;
  String newFlatmatesPetsString ;
  int newFlatmatesCoupleWelcomeSelector ;
  String newFlatmatesCouplesWelcomeString ;


  ///Text Controllers
  TextEditingController addressController ;
  TextEditingController securityDepositController ;
  TextEditingController phoneController ;
  TextEditingController titleController ;
  TextEditingController descriptionController ;
  //small containers controllers
  TextEditingController costController ;
  TextEditingController existingFlatmatesMinAgeController ;
  TextEditingController existingFlatmatesMaxAgeController ;
  TextEditingController newFlatmatesMinAgeController;
  TextEditingController newFlatmatesMaxAgeController ;


  @override
  void initState() {
    //Post this Advert in Section
    studentRoomsCheckbox = widget.apartmentSnapshot.data['studentRooms'];
     professionalRoomsCheckbox = widget.apartmentSnapshot.data['professionalRooms'];
     shortTermStayCheckbox = widget.apartmentSnapshot.data['shortTermStay'];
     apartmentsCheckbox = widget.apartmentSnapshot.data['apartments'];
    //bottom sheet selectors
     typeOfPropertySelector = widget.apartmentSnapshot.data['typeOfProperty']=="House"?1:
     widget.apartmentSnapshot.data['typeOfProperty']=="Room"?2:3;
     typeOfPropertyString = widget.apartmentSnapshot.data['typeOfProperty'];
     sizeOfPropertySelector = widget.apartmentSnapshot.data['typeOfProperty']=="1 Bed"?1:
     widget.apartmentSnapshot.data['typeOfProperty']=="2 Bed"?2:
     widget.apartmentSnapshot.data['typeOfProperty']=="3 Bed"?3:widget.apartmentSnapshot.data['typeOfProperty']=="4 Bed"?4:
     widget.apartmentSnapshot.data['typeOfProperty']=="5 Bed"?5:widget.apartmentSnapshot.data['typeOfProperty']=="6 Bed"?6:
     widget.apartmentSnapshot.data['typeOfProperty']=="7 Bed"?7:widget.apartmentSnapshot.data['typeOfProperty']=="8 Bed"?8:
     widget.apartmentSnapshot.data['typeOfProperty']=="9 Bed"?9:widget.apartmentSnapshot.data['typeOfProperty']=="10 Bed"?10:
     widget.apartmentSnapshot.data['typeOfProperty']=="11 Bed"?11:widget.apartmentSnapshot.data['typeOfProperty']=="12 Bed"?12:
     widget.apartmentSnapshot.data['typeOfProperty']=="13 Bed"?13:widget.apartmentSnapshot.data['typeOfProperty']=="14 Bed"?14:15;
     sizeOfPropertyString = widget.apartmentSnapshot.data['sizeOfProperty'];
     typeOfRoomSelector = widget.apartmentSnapshot.data['typeOfRoom']=='Double bed room'?1:
     widget.apartmentSnapshot.data['typeOfRoom']=='Single bed room'?2:
     widget.apartmentSnapshot.data['typeOfRoom']=='En suite'?3:4;
    typeOfRoomString = widget.apartmentSnapshot.data['typeOfRoom'];

    ///Amenities
    //checkboxes
     livingRoomCheckbox = widget.apartmentSnapshot.data['livingRoom'];
     gardenCheckbox = widget.apartmentSnapshot.data['garden'];
     balconyCheckbox = widget.apartmentSnapshot.data['balcony'];
     parkingCheckbox = widget.apartmentSnapshot.data['parking'];
     garageCheckBox = widget.apartmentSnapshot.data['garage'];
    disabledAccessCheckbox = widget.apartmentSnapshot.data['disableAccess'];
    //bottom sheet selectors
    furnishingsSelector = widget.apartmentSnapshot.data['furnishings']=='Furnished'?1:2;
    furnishingsString = widget.apartmentSnapshot.data['furnishings'];
    billsIncludedSelector = widget.apartmentSnapshot.data['billsIncluded']=='Yes'?1:2;
    billsIncludedString = widget.apartmentSnapshot.data['billsIncluded'];
    broadbandSelector = widget.apartmentSnapshot.data['broadband']=='Yes'?1:2;
    broadbandString = widget.apartmentSnapshot.data['broadband'];

    perWeekSelector = widget.apartmentSnapshot.data['rentTimeInterval']=='per day'?1:
    widget.apartmentSnapshot.data['rentTimeInterval']=='per week'?2:3;
    perWeekString = widget.apartmentSnapshot.data['rentTimeInterval'];
    _dateTime= widget.apartmentSnapshot.data['availableFrom'].toDate();

    for(Timestamp date in widget.apartmentSnapshot.data['bookedOn']){
      _multiDateList.add(date.toDate());
//      print(date.toDate().toString());
    }
    for(String url in widget.apartmentSnapshot.data['urlList']){
      urlPicList.add(Image.network(
        url,
        fit: BoxFit.fill,
      ));
    }
    ///Existing Flatmates
    //bottom sheet selectors
    otherFlatmatesGenderSelector = widget.apartmentSnapshot.data['existingGender']=='Male'?1:
    widget.apartmentSnapshot.data['existingGender']=='Female'?2:3;
    otherFlatmatesGenderString = widget.apartmentSnapshot.data['existingGender'];
    otherFlatmatesOccupationSelector = widget.apartmentSnapshot.data['existingOccupation']=='Student'?1:
    widget.apartmentSnapshot.data['existingOccupation']=='Professional'?2:3;
    otherFlatmatesOccupationString = widget.apartmentSnapshot.data['existingOccupation'];
    otherFlatmatesSmokingSelector = widget.apartmentSnapshot.data['existingSmoking']=="Yes"?1:2;
    otherFlatmatesSmokingString = widget.apartmentSnapshot.data['existingSmoking'];
    otherFlatmatesPetsSelector = widget.apartmentSnapshot.data['existingPets']=="Yes"?1:2;
    otherFlatmatesPetsString = widget.apartmentSnapshot.data['existingPets'];
    /// New Flatmates Preferences
    //bottom sheet selectors
    newFlatmatesGenderSelector = widget.apartmentSnapshot.data['newGender']=='Male'?1:
    widget.apartmentSnapshot.data['newGender']=='Female'?2:3;
    newFlatmatesGenderString = widget.apartmentSnapshot.data['newGender'];
    newFlatmatesOccupationSelector = widget.apartmentSnapshot.data['newOccupation']=='Students'?1:
    widget.apartmentSnapshot.data['newOccupation']=='Professionals'?2:3;
    newFlatmatesOccupationString = widget.apartmentSnapshot.data['newOccupation'];
    newFlatmatesSmokingSelector = widget.apartmentSnapshot.data['newSmoking']=='Yes'?1:2;
    newFlatmatesSmokingString = widget.apartmentSnapshot.data['newSmoking'];
    newFlatmatesPetsSelector = widget.apartmentSnapshot.data['newPets']=='Yes'?1:2;
    newFlatmatesPetsString = widget.apartmentSnapshot.data['newPets'];
    newFlatmatesCoupleWelcomeSelector = widget.apartmentSnapshot.data['newCouplesWelcome']=='Yes'?1:2;
    newFlatmatesCouplesWelcomeString = widget.apartmentSnapshot.data['newCouplesWelcome'];


    ///Text Controllers
    addressController = TextEditingController(text: widget.apartmentSnapshot.data['address']);
    securityDepositController = TextEditingController(text: widget.apartmentSnapshot.data['securityDeposit']);
    phoneController = TextEditingController(text: widget.apartmentSnapshot.data['phoneNumber']);
    titleController = TextEditingController(text: widget.apartmentSnapshot.data['title']);
    descriptionController = TextEditingController(text: widget.apartmentSnapshot.data['description']);
    //small containers controllers
    costController = TextEditingController(text: widget.apartmentSnapshot.data['costOfRent'].toString());
    existingFlatmatesMinAgeController = TextEditingController(text: widget.apartmentSnapshot.data['existingMinAge']);
    existingFlatmatesMaxAgeController = TextEditingController(text: widget.apartmentSnapshot.data['existingMaxAge']);
    newFlatmatesMinAgeController = TextEditingController(text: widget.apartmentSnapshot.data['newMinAge']);
    newFlatmatesMaxAgeController = TextEditingController(text: widget.apartmentSnapshot.data['newMaxAge']);

    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    securityDepositController.dispose();
    phoneController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    costController.dispose();
    existingFlatmatesMaxAgeController.dispose();
    existingFlatmatesMinAgeController.dispose();
    newFlatmatesMinAgeController.dispose();
    newFlatmatesMaxAgeController.dispose();
    super.dispose();
  }

  ///Main Scaffold Section
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Post Advert',
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
            SizedBox(height: 20),
//            SizedBox(height: 10),
            Container(
              height: height / 3.0,
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Carousel(
                  overlayShadow: false,
                  dotBgColor: Colors.transparent,
                  autoplay: false,
                  dotIncreaseSize: 2,
                  dotSize: 5,
                  // dotSpacing: 30,

                  dotIncreasedColor: Colors.white,
                  dotColor: Colors.black,
                  images: urlPicList,
                ),
              ),
            ),
            SizedBox(height: 15),

            ///Post This Advert in Checkboxes
            _heading('Post This Advert In'),
            SizedBox(height: 5),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: studentRoomsCheckbox,
                  onChanged: (bool value) {
                    setState(() {
                      studentRoomsCheckbox = value;
                    });
                  },
                ),
                Text(
                  'Student rooms',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: professionalRoomsCheckbox,
                  onChanged: (bool value) {
                    setState(() {
                      professionalRoomsCheckbox = value;
                    });
                  },
                ),
                Text(
                  'Professional rooms',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: apartmentsCheckbox,
                  onChanged: (bool value) {
                    setState(() {
                      apartmentsCheckbox = value;
                    });
                  },
                ),
                Text(
                  'Apartments',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(width: 20),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: shortTermStayCheckbox,
                  onChanged: (bool value) {
                    setState(() {
                      shortTermStayCheckbox = value;
                    });
                  },
                ),
                Text(
                  'short term stay',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            ///Type of Property
            Padding(
              padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                textColor: Colors.black,
                color: Colors.grey[200],
                label: Text(
                  'Type of property',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _typeofpropertyBottomsheet(context);
                },
              ),
            ),
            ///Size of Property
            Padding(
              padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                textColor: Colors.black,
                color: Colors.grey[200],
                label: Text(
                  'Size of Property',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _sizeofpropertyBottomsheet(context);
                },
              ),
            ),
            ///Type of Room
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
                  _typeofroomBottomsheet(context);
                },
              ),
            ),
            SizedBox(height: 20),


            ///Address Container
            _address('Address', Icons.location_on,addressController),
            SizedBox(height: 20),
            Divider(),


            ///Amenities Section Start
            SizedBox(height: 10),
            _heading('Amenities'),
            SizedBox(height: 5),
            Row(
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: livingRoomCheckbox,
                  onChanged: (bool value) {
                    setState(() {
                      livingRoomCheckbox = value;
                    });
                  },
                ),
                Text(
                  'living room',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                )
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
                      'Garden',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(width: 18),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                      value: garageCheckBox,
                      onChanged: (bool value) {
                        setState(() {
                          garageCheckBox = value;
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
                      value: balconyCheckbox,
                      onChanged: (bool value) {
                        setState(() {
                          balconyCheckbox = value;
                        });
                      },
                    ),
                    Text(
                      'Balcony',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(width: 15),
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
              children: [
                Checkbox(
                  activeColor: Colors.black,
                  checkColor: Colors.white,
                  value: disabledAccessCheckbox,
                  onChanged: (bool value) {
                    setState(() {
                      disabledAccessCheckbox = value;
                    });
                  },
                ),
                Text(
                  'Disable access',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                )
              ],
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
                  'Furnishings',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _furnishingsBottomsheet(context);
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
                  'Bills included',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _billsincludedBottomsheet(context);
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
                  'Broadband',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _broadbandBottomsheet(context);
                },
              ),
            ),
            SizedBox(height: 20),


            ///Calendar for selecting Availibility dates
            Center(
                child: Text(
                  'Available from',
                  style: TextStyle(fontSize: 15),
                )),

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
                    });
                  });
                },
              ),
            ),
            SizedBox(height: 20),

            ///Calendar multiple dates
            Center(
                child: Text(
                  'Booked On',
                  style: TextStyle(fontSize: 15),
                )),

            if(_multiPickerBool == true)
              SfDateRangePicker(
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args){
                  setState(() {
                    _multiDateList = args.value;
//                  print(_multiDateList[1].toString());
                  });
                },
                selectionMode: DateRangePickerSelectionMode.multiple,
                initialSelectedDates: _multiDateList,
              ),
            Padding(
              padding: EdgeInsets.fromLTRB(80, 5, 80, 5),
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                textColor: _multiPickerBool == true?Colors.green:Colors.black,
                color: Colors.grey[200],
                label: Text(_multiPickerBool == true?'Done':'Select dates'),
                icon: Icon(_multiPickerBool == true?Icons.check_circle:Icons.date_range),
                onPressed: () {
                  setState(() {
                    _multiPickerBool = !_multiPickerBool;
                  });

                },
              ),
            ),
            SizedBox(height: 20),



            ///Security Deposits Section
            _input('Security deposit', 'Security deposit', Icons.security,securityDepositController),
            SizedBox(height: 20),
            //period

            ///Cost and time for cost row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _shortinput(
                    'Cost',
                    'In pounds',
                    costController
                ),
                //Dropdown for time of cost like perday/
                DropdownButton(
                    value: perWeekSelector,
                    items: [
                      DropdownMenuItem(
                        child: Text('per day'),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text('per week'),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text('per calender month'),
                        value: 3,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        perWeekSelector = value;
                        if(perWeekSelector == 1){
                          perWeekString = 'per day';
                        } else if(perWeekSelector == 2){
                          perWeekString = 'per week';
                        } else if(perWeekSelector == 3){
                          perWeekString = 'per calender month';
                        }
                      });
                    }),
              ],
            ),


            SizedBox(height: 10),
            Divider(),

            ///Existing Flatmates Section
            _heading('Existing Flatmates'),
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
                  _existingFlatmateGenderBottomsheet(context);
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
                  _existingFlatmateoccupationBottomsheet(context);
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
                  _existingFlatmatesmokingBottomsheet(context);
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
                  'Pets',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _existionFlatmatePetsBottomsheet(context);
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
                _shortinput(
                    'Age',
                    'Minimum 18',
                    existingFlatmatesMinAgeController
                ),
                Text('to'),
                _shortinput(
                    'Age',
                    'Maximum 99',
                    existingFlatmatesMaxAgeController
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),


            ///Preferences for new Flatmates
            _heading('Preference For New Flatmates'),
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
                  _preferFlatmateGenderBottomsheet(context);
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
                  _preferFlatmateoccupationBottomsheet(context);
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
                  _preferFlatmatesmokingBottomsheet(context);
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
                  'Pets',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _preferFlatmatePetsBottomsheet(context);
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
                  'Couple welcome',
                ),
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _coupleWelcomeBottomsheet(context);
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
                _shortinput(
                    'Age',
                    'Minimum 18',
                    newFlatmatesMinAgeController
                ),
                Text('to'),
                _shortinput(
                    'Age',
                    'Maximum 99',
                    newFlatmatesMaxAgeController
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),


            ///Title, Description and Phone Number Section
            _inputname('Title', 'Short description',titleController),
            SizedBox(height: 10),
            _description('Description...',descriptionController),
            SizedBox(height: 10),
            _input('Phone', 'Phone Number with country code', Icons.phone, phoneController),
            SizedBox(height: 20),


            ///upload pictures Widget
            Center(
              child: Text(
                'Change pictures',
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
            if (images.length != 0)
              buildImageListView(),
            SizedBox(height: 20),


            ///Post Advert Button

            _loading == true?Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("Update Advert",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: ()async{
                  if (addressController.text == ""){
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.red[400],
                              )),
                          title: Text("Address"),
                          content:
                          Text("Please write the address for the property."),
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
                  else if (titleController.text == ""){
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
                          content:
                          Text("Please provide a Title for the property."),
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
                  else if (descriptionController.text == ""){
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
                          content:
                          Text("Please write a description for the property."),
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
                  else if (phoneController.text == ""){
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.red[400],
                              )),
                          title: Text("Phone Number"),
                          content:
                          Text("Please provide a phone number for contact."),
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
                  else if(addressController.text != "" && descriptionController.text != '' && phoneController.text != ""){
                    List<String> urlList = List<String>();
                    bool errorStorage = false;
                    setState(() {
                      _loading = true;
                    });

                      for (Asset image in images) {
                        try {
                          var path2 = await FlutterAbsolutePath.getAbsolutePath(
                              image.identifier);
                          File file = File(path2);
                          String fileName = '${image.name +
                              DateTime.now().toString()}.png';

                          ///Saving Pdf to firebase
                          StorageReference reference = FirebaseStorage.instance
                              .ref().child(fileName);
                          StorageUploadTask uploadTask = reference.putData(
                              file.readAsBytesSync());
                          String urlImage = await (await uploadTask.onComplete)
                              .ref.getDownloadURL();
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
                                content:
                                Text(
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
                      Firestore.instance.collection('properties')
                          .document(widget.apartmentSnapshot.documentID)
                          .updateData({
                        'availableFrom': _dateTime,
                        'bookedOn':_multiDateList,
                        if(urlList.length>0)
                        'urlList': urlList,
                        'timePosted': DateTime.now(),
                        //all TextFormFields
                        'address' : addressController.text.trim(),
                        'securityDeposit' : securityDepositController.text.trim(),
                        'costOfRent' : double.parse(costController.text.trim()),
                        'existingMinAge' : existingFlatmatesMinAgeController.text.trim(),
                        'existingMaxAge' : existingFlatmatesMaxAgeController.text.trim(),
                        'newMinAge' : newFlatmatesMinAgeController.text.trim(),
                        'newMaxAge' : newFlatmatesMaxAgeController.text.trim(),
                        'title' : titleController.text.trim(),
                        'description' : descriptionController.text.trim(),
                        'phoneNumber' : phoneController.text.trim(),
                        //All Checkboxes
                        'studentRooms' : studentRoomsCheckbox,
                        'professionalRooms' : professionalRoomsCheckbox,
                        'apartments' : apartmentsCheckbox,
                        'shortTermStay' : shortTermStayCheckbox,
                        'livingRoom' : livingRoomCheckbox,
                        'garden' : gardenCheckbox,
                        'balcony' : balconyCheckbox,
                        'disableAccess' : disabledAccessCheckbox,
                        'garage' : garageCheckBox,
                        'parking' : parkingCheckbox,
                        //bottom sheet selectors
                        'typeOfProperty' : typeOfPropertyString,
                        'sizeOfProperty': sizeOfPropertyString,
                        'typeOfRoom': typeOfRoomString,
                        'furnishings': furnishingsString,
                        'billsIncluded': billsIncludedString,
                        'broadband': broadbandString,
                        'existingGender': otherFlatmatesGenderString,
                        'existingOccupation': otherFlatmatesOccupationString,
                        'existingSmoking': otherFlatmatesSmokingString,
                        'existingPets': otherFlatmatesPetsString,
                        'newGender': newFlatmatesGenderString,
                        'newOccupation': newFlatmatesOccupationString,
                        'newSmoking': newFlatmatesSmokingString,
                        'newPets': newFlatmatesPetsString,
                        'newCouplesWelcome': newFlatmatesCouplesWelcomeString,
                        'rentTimeInterval' : perWeekString,
                        //-----------
                        'personPic': widget.userSnapshot.data['userImage'],
                        'personUid':widget.userSnapshot.data.documentID,
                        'personName': widget.userSnapshot.data['name'],
                        'personEmail': widget.userSnapshot.data['email']

                      }).then((value) {
                        _loading = false;
                        Navigator.pop(context);
                      }).catchError((e){
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
                              content:
                                  Text(e.toString()),
//                              Text("An error has occured. Please check your internet connection or try again after some time."),
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
            _loading == true?Center():Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.black,
                textColor: Colors.black,
                child: Text("Delete Advert",
                    style: TextStyle(
                      fontSize: 16.0,color: Colors.white70
                    )),
                onPressed: ()async{
                  setState(() {
                    _loading = true;
                  });
                 await Firestore.instance.collection('properties')
                      .document(widget.apartmentSnapshot.documentID)
                  .delete();
                  _loading = false;
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );

  }


  ///Bottom Sheets Start
  //-------------------------------------------
  ///Type of property Bottom Sheet
  void _typeofpropertyBottomsheet(context) {
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
                      onTap: () {
                        setState(() {
                          typeOfPropertySelector = 1;
                          typeOfPropertyString = "House";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: typeOfPropertySelector,
                            activeColor: Colors.black,

                            onChanged: null,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'House',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          typeOfPropertySelector = 2;
                          typeOfPropertyString = 'Room';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: typeOfPropertySelector,
                            activeColor: Colors.black,
                            onChanged: null,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Room',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          typeOfPropertySelector = 3;
                          typeOfPropertyString = 'Apartment';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                            value: 3,
                            groupValue: typeOfPropertySelector,
                            activeColor: Colors.black,
                            onChanged: null,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Apartment',
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

  ///SIze of Property Bottom Sheet
  void _sizeofpropertyBottomsheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
              height: 980,
              //height: MediaQuery.of(context).size.height * 80,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 1;
                              sizeOfPropertyString = '1 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 1, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '1 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 2;
                              sizeOfPropertyString = '2 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 2, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '2 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 3;
                              sizeOfPropertyString = '3 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 3, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '3 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 4;
                              sizeOfPropertyString = '4 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 4, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '4 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 5;
                              sizeOfPropertyString = '5 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 5, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '5 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 6;
                              sizeOfPropertyString = '6 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 6, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '6 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 7;
                              sizeOfPropertyString = '7 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 7, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '7 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 8;
                              sizeOfPropertyString = '8 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 8, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '8 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 9;
                              sizeOfPropertyString = '9 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 9, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '9 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 10;
                              sizeOfPropertyString = '10 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 10, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '10 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 11;
                              sizeOfPropertyString = '11 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 11, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '11 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 12;
                              sizeOfPropertyString = '12 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 12, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '12 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 13;
                              sizeOfPropertyString = '13 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 13, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '13 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 14;
                              sizeOfPropertyString = '14 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 14, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '14 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              sizeOfPropertySelector = 15;
                              sizeOfPropertyString = '15 Bed';
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              Radio(value: 15, groupValue: sizeOfPropertySelector, onChanged: null),
                              SizedBox(width: 10),
                              Text(
                                '15 bed',
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ///Type of property Bottom Sheet
  void _typeofroomBottomsheet(context) {
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
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 1;
                          typeOfRoomString = 'Double bed room';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Double bed room',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 2;
                          typeOfRoomString = 'Single bed room';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Single bed room',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          typeOfRoomSelector = 3;
                          typeOfRoomString = 'En suite';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: typeOfRoomSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'En suite',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
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

//----------------------------------------------
  ///Furnishing Status Bottom Sheet
  void _furnishingsBottomsheet(context) {
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
                          furnishingsSelector = 1;
                          furnishingsString = 'Furnished';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: furnishingsSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Furnished',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          furnishingsSelector = 2;
                          furnishingsString = 'Unfurnished';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: furnishingsSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Unfurnished',
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

  ///Bills Included Bottom Sheet
  void _billsincludedBottomsheet(context) {
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
                          billsIncludedSelector = 1;
                          billsIncludedString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: billsIncludedSelector, onChanged: null),
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
                          billsIncludedSelector = 2;
                          billsIncludedString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: billsIncludedSelector, onChanged: null),
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

  ///Broad Band Bottom Sheet
  void _broadbandBottomsheet(context) {
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
                          broadbandSelector = 1;
                          broadbandString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: broadbandSelector, onChanged: null),
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
                          broadbandSelector = 2;
                          billsIncludedString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: broadbandSelector, onChanged: null),
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

  //---------------------------------------
  ///Existing Flatmates Gender Bottom Sheet
  void _existingFlatmateGenderBottomsheet(context) {
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
                          otherFlatmatesGenderSelector = 1;
                          otherFlatmatesGenderString = 'Male';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: otherFlatmatesGenderSelector, onChanged: null),
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
                          otherFlatmatesGenderSelector = 2;
                          otherFlatmatesGenderString = 'Female';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: otherFlatmatesGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Female',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          otherFlatmatesGenderSelector = 3;
                          otherFlatmatesGenderString = 'Both Male and Female';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: otherFlatmatesGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Both Male and Female',
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

  ///Existing Flatemates Occupation Bottom Sheet
  void _existingFlatmateoccupationBottomsheet(context) {
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
                          otherFlatmatesOccupationSelector = 1;
                          otherFlatmatesOccupationString = 'Student';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: otherFlatmatesOccupationSelector, onChanged: null),
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
                          otherFlatmatesOccupationSelector = 2;
                          otherFlatmatesOccupationString = 'Professional';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: otherFlatmatesOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Professional',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          otherFlatmatesOccupationSelector = 3;
                          otherFlatmatesOccupationString = 'Mixed';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: otherFlatmatesOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Mixed',
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

  ///Existing Flatmates Smoking Bottom Sheet
  void _existingFlatmatesmokingBottomsheet(context) {
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
                          otherFlatmatesSmokingSelector = 1;
                          otherFlatmatesSmokingString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: otherFlatmatesSmokingSelector, onChanged: null),
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
                          otherFlatmatesSmokingSelector = 2;
                          otherFlatmatesOccupationString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: otherFlatmatesSmokingSelector, onChanged: null),
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

  ///Existing Flatmates Pets Bottom Sheet
  void _existionFlatmatePetsBottomsheet(context) {
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
                          otherFlatmatesPetsSelector = 1;
                          otherFlatmatesPetsString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: otherFlatmatesPetsSelector, onChanged: null),
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
                          otherFlatmatesPetsSelector = 2;
                          otherFlatmatesPetsString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: otherFlatmatesPetsSelector, onChanged: null),
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

  //-------------------------------------
  ///New Flatmates Gender Bottom Sheet
  void _preferFlatmateGenderBottomsheet(context) {
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
                          newFlatmatesGenderSelector = 1;
                          newFlatmatesGenderString = 'Male';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newFlatmatesGenderSelector, onChanged: null),
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
                          newFlatmatesGenderSelector = 2;
                          newFlatmatesGenderString = "Female";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newFlatmatesGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Female',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newFlatmatesGenderSelector = 3;
                          newFlatmatesGenderString = "No Preference";
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: newFlatmatesGenderSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'No preference',
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

  ///new Flatmates Occupation Bottom Sheet
  void _preferFlatmateoccupationBottomsheet(context) {
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
                          newFlatmatesOccupationSelector = 1;
                          newFlatmatesOccupationString = 'Students';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newFlatmatesOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Students',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newFlatmatesOccupationSelector = 2;
                          newFlatmatesOccupationString = 'Professionals';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newFlatmatesOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'Professionals',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          newFlatmatesOccupationSelector = 3;
                          newFlatmatesOccupationString = 'No Preference';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 3, groupValue: newFlatmatesOccupationSelector, onChanged: null),
                          SizedBox(width: 10),
                          Text(
                            'No preference',
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

  ///new Flatmates Smoking Bottom Sheet
  void _preferFlatmatesmokingBottomsheet(context) {
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
                          newFlatmatesSmokingSelector = 1;
                          newFlatmatesSmokingString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newFlatmatesSmokingSelector, onChanged: null),
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
                          newFlatmatesSmokingSelector = 2;
                          newFlatmatesSmokingString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newFlatmatesSmokingSelector, onChanged: null),
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

  ///new Flatmates Pets Bottom Sheet
  void _preferFlatmatePetsBottomsheet(context) {
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
                          newFlatmatesPetsSelector = 1;
                          newFlatmatesPetsString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newFlatmatesPetsSelector, onChanged: null),
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
                          newFlatmatesPetsSelector = 2;
                          newFlatmatesPetsString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newFlatmatesPetsSelector, onChanged: null),
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

  ///Couple Welcome Bottom Sheet
  void _coupleWelcomeBottomsheet(context) {
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
                          newFlatmatesCoupleWelcomeSelector = 1;
                          newFlatmatesCouplesWelcomeString = 'Yes';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 1, groupValue: newFlatmatesCoupleWelcomeSelector, onChanged: null),
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
                          newFlatmatesCoupleWelcomeSelector = 2;
                          newFlatmatesCouplesWelcomeString = 'No';
                          Navigator.pop(context);
                        });
                      },
                      child: Row(
                        children: [
                          Radio(value: 2, groupValue: newFlatmatesCoupleWelcomeSelector, onChanged: null),
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

  //---------------------------------
  ///headings
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

  ///Container for phone etc.
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

  ///input Container for small inputs like age range etc
  Widget _shortinput(String label, String hint,TextEditingController controller) {
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

  ///Description Container
  Widget _description(String hint,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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

  ///Description Container
  Widget _address(String hint, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
            minLines: 1,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
                //labelText: label,
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
      ),
    );
  }

  ///Title Container
  Widget _inputname(String label, String hint,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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


}

