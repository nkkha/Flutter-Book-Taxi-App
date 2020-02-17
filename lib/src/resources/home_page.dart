import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/src/resources/widgets/home_menu.dart';
import 'package:flutter_taxiapp/src/resources/widgets/ride_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(10.7915178, 106.7271422), zoom: 14.4746),
            ),
            Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Book Taxi App',
                    style: TextStyle(color: Colors.black),
                  ),
                  leading: FlatButton(
                    onPressed: () {
                      print('Click menu');
//                        Scaffold.of(context).openDrawer();
                      _scaffoldKey.currentState.openDrawer();
                    },
                    child: Image.asset('ic_menu.png'),
                  ),
                  actions: <Widget>[Image.asset('ic_notify.png')],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: RidePicker(),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMenu(),
      ),
    );
  }
}
