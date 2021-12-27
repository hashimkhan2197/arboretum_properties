import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostOffer extends StatefulWidget {
  PostOffer({Key key}) : super(key: key);

  @override
  _PostOfferState createState() => _PostOfferState();
}

class _PostOfferState extends State<PostOffer> {

  File _image;
  String url = '';
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  bool _loading = false;

  //image picker
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    String fileName = '${DateTime.now().toString()}.png';

    ///Saving Pdf to firebase
    StorageReference reference =  FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData(image.readAsBytesSync());
    String urlImage = await (await uploadTask.onComplete).ref.getDownloadURL();

    setState(() {
      _image = image;
      url = urlImage;
    });
  }


  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Offer',
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
          SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(66, 10, 65, 10),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5))
                      ]),
//                  width: 150,
                  height: 170,
                  child: _image == null
                              ? Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                  color: Colors.grey,
                                )
                              : Image.file(_image,fit: BoxFit.fill,),
                ),
                onTap: getImage,
              ),
            ),
            SizedBox(height: 20),
            _description('Description...', descriptionController),
            SizedBox(height: 20),
            _input('Phone', 'Phone number with country code', Icons.phone, phoneController),
            SizedBox(height: 20),

          ///Button for posting the offer
          _loading == true?Center(child: CircularProgressIndicator()):Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.grey[300],
                textColor: Colors.black,
                child: Text("POST OFFER",
                    style: TextStyle(
                      fontSize: 16.0,
                    )),
                onPressed: () {
                  if (url == ""){
                    showDialog(
                        context: context,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.red[400],
                              )),
                          title: Text("Image"),
                          content:
                          Text("Please upload an image for the offer."),
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
                          Text("Please write a description for the offer."),
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
                          Text("Please provide a phone number for the offer."),
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
                  else if(url != "" && descriptionController.text != '' && phoneController.text != ""){
                    setState(() {
                      _loading = true;
                    });

                    Firestore.instance.collection('offers').add({
                      'description': descriptionController.text,
                      'phoneNumber': phoneController.text,
                      'imageUrl' : url
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
                            Text("An error has occured. Please check your internet connection or try again after some time."),
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

        ],
      ),
      ),
    );
  }

  ///Description Container
  Widget _description(String hint, TextEditingController controller) {
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

  ///phone Controller
  Widget _input(String label, String hint, IconData icon, TextEditingController controller) {
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

}


