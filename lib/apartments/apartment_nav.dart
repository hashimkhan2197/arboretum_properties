import 'package:arboretumproperties/apartments/apartments_list/Apartment_list.dart';
import 'package:arboretumproperties/apartments/offers.dart';
import 'package:flutter/material.dart';

class ApartmentNavigationBar extends StatefulWidget {
 final AsyncSnapshot userSnapshot;

  ApartmentNavigationBar(this.userSnapshot);

  @override
  _ApartmentNavigationBarState createState() => _ApartmentNavigationBarState();
}

class _ApartmentNavigationBarState extends State<ApartmentNavigationBar> {
  //navbar
  int pageIndex = 0;
  bool animate = true;
  ApartmentList _apartmentList;
  ApartmentOffers _apartmentOffers;

  Widget _showPage;
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _apartmentList;

      case 1:
        return _apartmentOffers;
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
    _apartmentList = ApartmentList(widget.userSnapshot,'Apartments','apartments');
    _apartmentOffers = ApartmentOffers();

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
