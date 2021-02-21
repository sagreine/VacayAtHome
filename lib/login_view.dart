import 'package:firebase_auth/firebase_auth.dart' as fAuth;
import 'package:firebase_auth_ui/providers.dart';
//import 'package:firebase_auth_ui/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:home_gym/models/models.dart';
//import 'package:home_gym/controllers/controllers.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:provider/provider.dart';
import 'package:vacayathome/main_view.dart';
import 'package:vacayathome/muser.dart';
//import 'package:home_gym/views/views.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

// maybe we can cover this stuff with a splash screen in the end, for those logged in already?

class _LoginViewState extends State<LoginView> {
  //LoginController loginController = LoginController();

  //this part we could do in gcp functions instead of code
  //LifterMaxesController lifterMaxesController = LifterMaxesController();
  //LifterWeightsController lifterWeightsController = LifterWeightsController();

  //FirebaseUser _firebaseUser;
  //User _user;
  // TODO model not view....
  //Muser _user;
  String error;
  bool result;
  Muser _user;
  // this flag is to prevent the auth listener from calling twice unnecessarily - when assigned, and when changed.
  // we only want one call, and if we already have a signed in user we can avoid multiple calls.
  var authFlag;
  bool isFirstPull;
  //bool isNewUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //_user = fAuth.FirebaseAuth.instance.currentUser;
    _user = Provider.of<Muser>(context, listen: false);
    var firebaseAuth = fAuth.FirebaseAuth.instance;
    /*if (_user != null) {
      isNewUser =
          fAuth.FirebaseAuth.instance.currentUser.metadata.creationTime ==
              fAuth.FirebaseAuth.instance.currentUser.metadata.lastSignInTime;
    } else {
      isNewUser = true;
    }*/

    //Provider.of<Muser>(context, listen: false);
    //var firebaseAuth = fAuth.FirebaseAuth.instance;
    var haveUser = false;
    if (firebaseAuth != null) {
      haveUser = firebaseAuth.currentUser != null;
    }
    authFlag = (haveUser == true);
    if (haveUser) {
      _user.isNewUser = false;
    }
  }

  //TODO: well this sure isn't UI..
  Future buildDefaultUser() async {
    /*await lifterMaxesController.update1RepMax(
        progression: false,
        context: context,
        lift: "bench",
        newMax: 100,
        updateCloud: true,
        dontNotify: true);*/
  }

  Scaffold buildNextPage() {
    if ((_user?.isNewUser) ?? false) {
      return Scaffold(
        body: Container(child: MainView()),
      );
    } else {
      if (isFirstPull ?? false) {
        isFirstPull = false;
        //loginController.getMaxes(context);
        //loginController.getBarWeights(context);
        //loginController.getPlates(context);
        //loginController.clearLocalPRs(context);
        //loginController.getCurrentPRs(context);

        /*if (_user.getPhotoURL() != null && _user.getPhotoURL().isNotEmpty) {
          precacheImage(new NetworkImage(_user.getPhotoURL()), context);
        }*/
      }
      return Scaffold(
        body: Container(child: MainView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // because some things rebuild everything in the app (e.g. dark theme toggle)
    // we only want to pull these things in the first time this page is 'built' for a given user
    // but, we need to take care beacuse of user generation and etc.
    // so, we use a user-specific item as a proxy

    // below item failed, so instead we will rely on a combo flag of either there is no userid (probably only need this really)
    // to force a repull if they logged out and back in.
    bool nouser =
        Provider.of<Muser>(context, listen: false)?.fAuthUser?.uid == null;
    //((fAuth.FirebaseAuth?.instance?.currentUser == null) ?? null);
    //Provider.of<Muser>(context, listen: false)?.fAuthUser?.uid == null;

    // this only matters if we start rebuilding every page e.g. dark theme
    // it is also a relic of a bad way to do that, so do it the right way
    /*isFirstPull =
        (Provider.of<LifterWeights>(context, listen: false).squatBarWeight ==
                null ||
            nouser);*/

    return authFlag
        // this is if we have a signed in user. so, really, this should never be a new user (you can't be logging in again and be new)
        // but could use the commented out code to be safe
        ? buildNextPage()
        /*FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return buildNextPage();
              }
              return Text("Loading");
            },
            // This should never fire the new user
            future: _user.isNewUser
                ? buildDefaultUser()
                : Future.delayed(Duration(milliseconds: 0)))*/
        : StreamBuilder<FirebaseUser>(
            stream: FirebaseAuthUi.instance().launchAuth(
              [
                AuthProvider.email(),
                AuthProvider.google(),
                //AuthProvider.twitter(),
                //AuthProvider.facebook(),
                //AuthProvider.phone(),
              ],
              //TODO: actual deep links.
              tosUrl: "https://sagrehomegym.web.app/",
              privacyPolicyUrl: "https://sagrehomegym.web.app/",
            ).catchError((error) {
              if (error is PlatformException) {
                setState(() {
                  if (error.code == FirebaseAuthUi.kUserCancelledError) {}
                });
              }
            }).asStream(),
            builder: (context, snapshot) {
              authFlag = true;
              if (snapshot.connectionState == ConnectionState.done) {
                //_user = fAuth.FirebaseAuth.instance.currentUser;
                _user.fAuthUser = fAuth.FirebaseAuth.instance.currentUser;
                /*isNewUser = fAuth.FirebaseAuth.instance.currentUser.metadata
                        .creationTime ==
                    fAuth.FirebaseAuth.instance.currentUser.metadata
                        .lastSignInTime;*/
                // pull in this users' information or build a default user
                if ((snapshot.data?.isNewUser != false) ?? false) {
                  _user.isNewUser = true;
                  var future = buildDefaultUser();
                  return FutureBuilder(
                      builder: (context, snapshot2) {
                        if (snapshot2.connectionState == ConnectionState.done) {
                          return buildNextPage();
                        }
                        return Container();
                      },
                      future: future);
                  //buildDefaultUser();
                } else {
                  _user.isNewUser = false;
                  return buildNextPage();
                }
              } else {
                return Scaffold(
                  body: Center(
                    child: Container(),
                  ),
                );
              }
            },
          );
  }
}
