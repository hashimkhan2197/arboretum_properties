import 'package:arboretumproperties/apartments/apartments_list/Apartment_list.dart';
import 'package:arboretumproperties/apartments/offers.dart';
import 'package:flutter/material.dart';

class ProfessionalNavigationBar extends StatefulWidget {
  final AsyncSnapshot userSnapshot;

  ProfessionalNavigationBar(this.userSnapshot);

  @override
  _ProfessionalNavigationBarState createState() => _ProfessionalNavigationBarState();
}

class _ProfessionalNavigationBarState extends State<ProfessionalNavigationBar> {
 //navbar
  int pageIndex = 0;
  bool animate = true;
  ApartmentList _professionalroomstorent;
  ApartmentOffers _offers;

  Widget _showPage;
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _professionalroomstorent;

      case 1:
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

    _professionalroomstorent = ApartmentList(widget.userSnapshot,'Professional Rooms','professionalRooms');
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
