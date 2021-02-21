import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vacayathome/reusable_widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:location/location.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

// maybe we can cover this stuff with a splash screen in the end, for those logged in already?

class _MainViewState extends State<MainView> {
  var _controller;
  var _visible = false;
  //final Location location = Location();
  Future<LocationData> _locationData;
  Location location = new Location();

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _controller = null;
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = VideoPlayerController.asset("assets/videos/picksix.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
    _getLocation();
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Colors.blue.withAlpha(120),
    );
  }

  _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
//LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar(),
        drawer: ReusableWidgets.getDrawer(context),
        body: Stack(
          children: [
            _getVideoBackground(),
            _getBackgroundColor(),
            FutureBuilder(
                future: _locationData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Hello there! Your location:\nLatitude: ${snapshot.data.latitude}\nLongitude: ${snapshot.data.longitude}",
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                    );
                  }
                  return Container();
                })
          ],
        ));
  }
}
