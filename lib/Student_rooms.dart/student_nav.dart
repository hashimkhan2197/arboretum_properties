import 'package:arboretumproperties/Student_rooms.dart/student_post_adverts.dart';
import 'package:arboretumproperties/Student_rooms.dart/flatmate/student_view_flatemates.dart';
import 'package:arboretumproperties/apartments/apartments_list/Apartment_list.dart';
import 'package:arboretumproperties/apartments/offers.dart';
import 'package:flutter/material.dart';

class StudentNavigationBar extends StatefulWidget {
  final AsyncSnapshot userSnapshot;

  StudentNavigationBar(this.userSnapshot);

  @override
  _StudentNavigationBarState createState() => _StudentNavigationBarState();
}

class _StudentNavigationBarState extends State<StudentNavigationBar> {
  //navbar
  int pageIndex = 0;
  bool animate = true;
  ApartmentList _roomstorent;
  StudentPostAdverts _postadverts;
  StudentViewFlatmates _viewflatmates;
  ApartmentOffers _offers;

  Widget _showPage;
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _roomstorent;

      case 1:
        return _viewflatmates;

      case 2:
        return _postadverts;

      case 3:
        return _offers;
      default:
        return new Container(
            child: new Center(
          child: new Text(
            'No Page found by page thrower',
            style: new TextStyle(fontSize: 30),
          ),
        ));
    }
  }

  @override
  void initState() {
    super.initState();
    _roomstorent = ApartmentList(widget.userSnapshot,'Student Rooms','studentRooms');
    _postadverts = StudentPostAdverts(widget.userSnapshot);
    _viewflatmates = StudentViewFlatmates(widget.userSnapshot);
    _offers = ApartmentOffers();

    pageIndex = 0;
    _showPage = _pageChooser(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 27,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 27,
              ),
              label: 'Flatmates',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons. post_add,
                size: 27,
              ),
              label: 'Post Advert',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_offer,
                size: 27,
              ),
              label: 'Offers',
            ),
          ],
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          currentIndex: pageIndex,
          selectedItemColor: Colors.black,
          onTap: (int tappedIndex) {
            setState(() {
              animate = true;
              pageIndex = tappedIndex;
              _showPage = _pageChooser(tappedIndex);
            });
          }),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _showPage,
        ),
      ),
    );
  }
}
