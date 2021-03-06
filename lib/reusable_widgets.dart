import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart' as fAuth;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:vacayathome/muser.dart';
//import 'package:flutter_icons/flutter_icons.dart';
//import 'package:home_gym/models/models.dart';
//import 'package:provider/provider.dart';

class ReusableWidgets {
  static getAppBar({TabController tabController, List<Tab> tabs}) {
    return AppBar(
      title: Text("Vacay @ Home"),
      bottom: tabController == null
          ? null
          : new TabBar(
              controller: tabController,
              tabs: tabs,
            ),
    );
  }

  static getDrawer(BuildContext context) {
    bool isNewRouteSameAsCurrent = false;
    String newRouteName;

    return Consumer<Muser>(builder: (context, user, child) {
      return Drawer(
        child: Column(children: [
          DrawerHeader(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    //color: Colors.blueGrey[200],
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              Color(0xFFCB8421), //Colors.brown.shade800,
                          backgroundImage: fAuth.FirebaseAuth?.instance
                                          ?.currentUser?.photoURL ==
                                      null ||
                                  ((fAuth.FirebaseAuth?.instance?.currentUser
                                          ?.photoURL?.isEmpty) ??
                                      false)
                              ? AssetImage("assets/images/pos_icon.png")
                              : NetworkImage(fAuth.FirebaseAuth?.instance
                                  ?.currentUser?.photoURL),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 35),
                            //Image.asset("assets/images/pos_icon.png"),
                            Text(fAuth.FirebaseAuth?.instance?.currentUser
                                    ?.displayName ??
                                "A user"),
                            SizedBox(height: 10),
                            InkWell(
                              child: Text(
                                "View Profile",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              onTap: () {
                                newRouteName = "/profile";
                                Navigator.canPop(context);
                                // if the current route is the exact location we're at (first on the stack), mark that
                                Navigator.popUntil(context, (route) {
                                  if (route.settings.name == newRouteName) {
                                    isNewRouteSameAsCurrent = true;
                                  } else {
                                    isNewRouteSameAsCurrent = false;
                                  }
                                  return true;
                                });
                                // if it isn't, go to the new route
                                if (!isNewRouteSameAsCurrent) {
                                  Navigator.pushNamed(context, newRouteName);
                                }
                                // again if it is, just pop the drawer away
                                else {
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                      //trailing: ,
                    ),
                  ),
                ),
                // ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(children: [
              ListTile(
                  title: Text("Pick Lift"),
                  leading: Icon(Icons.fitness_center),
                  // TODO: this is yet messed up because login doesn't route to pick_day it builds it's own.... so breaks if we do this the first time through.
                  onTap: () {
                    newRouteName = "/pick_day";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                  title: Text("Do Lift"),
                  leading: Icon(Icons.directions_run),
                  // typical is icons, and need a similar iimage for all (image is bigger than icon) but to think about
                  //leading: Image.asset("assets/images/pos_icon.png"),
                  onTap: () {
                    newRouteName = "/today";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                  title: Text("My Weights"),
                  // rotate this icon
                  leading: RotatedBox(
                      //alignment: Alignment.center,
                      //transform: Matrix4.rotationX(pi),
                      quarterTurns: 3,
                      child: Icon(Icons.filter_list)),
                  onTap: () {
                    newRouteName = "/lifter_weights";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                  title: Text("My Maxes"),
                  //leading: Icon(Icons.description),
                  leading: Icon(Icons.format_list_bulleted),
                  onTap: () {
                    newRouteName = "/lifter_maxes";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                  title: Text("My PRs"),
                  //leading: Icon(Icons.description),
                  leading: Icon(Icons.trending_up), //whatshot_outlined
                  onTap: () {
                    newRouteName = "/prs";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                  title: Text("My Lifts"),
                  //leading: Icon(Icons.description),
                  leading: Icon(Icons.video_library),
                  onTap: () {
                    newRouteName = "/lifter_videos";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                  title: Text("My Programs"),
                  //leading: Icon(Icons.description),
                  leading: Icon(EvilIcons.archive),
                  onTap: () {
                    newRouteName = "/lifter_programs";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(
                        context,
                        newRouteName,
                      );
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              /*
              ListTile(
                  title: Text("Check Form Picture"),
                  //leading: Icon(Icons.description),
                  leading: Icon(Icons.accessibility),
                  onTap: () {
                    newRouteName = "/form_check";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
                  */ /*
              ListTile(
                  title: Text("Check Form Video"),
                  //leading: Icon(Icons.description),
                  leading: Icon(Icons.flash_auto), //auto_awesome or fix
                  onTap: () {
                    newRouteName = "/form_check_copy";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),*/
              ListTile(
                  title: Text("Help"),
                  leading: Icon(Icons.help),
                  onTap: () {
                    newRouteName = "/help";
                    // if the current route is the exact location we're at (first on the stack), mark that
                    Navigator.popUntil(context, (route) {
                      if (route.settings.name == newRouteName) {
                        isNewRouteSameAsCurrent = true;
                      } else {
                        isNewRouteSameAsCurrent = false;
                      }
                      return true;
                    });
                    // if it isn't, go to the new route
                    if (!isNewRouteSameAsCurrent) {
                      Navigator.pushNamed(context, newRouteName);
                    }
                    // again if it is, just pop the drawer away
                    else {
                      Navigator.pop(context);
                    }
                  }),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
                onTap: () {
                  newRouteName = "/settings";
                  // if the current route is the exact location we're at (first on the stack), mark that
                  Navigator.popUntil(context, (route) {
                    if (route.settings.name == newRouteName) {
                      isNewRouteSameAsCurrent = true;
                    } else {
                      isNewRouteSameAsCurrent = false;
                    }
                    return true;
                  });
                  // if it isn't, go to the new route
                  if (!isNewRouteSameAsCurrent) {
                    Navigator.pushNamed(context, newRouteName);
                  }
                  // again if it is, just pop the drawer away
                  else {
                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                title: Text("Log Out"),
                leading: Icon(Icons.exit_to_app),
                onTap: () async {
                  // wait while we log the user out.
                  //var exerciseDay =
                  //  Provider.of<ExerciseDay>(context, listen: false);
                  /*var prs = Provider.of<Prs>(context, listen: false);
                  if (prs.prs != null) {
                    prs.prs.clear();
                  }
                  prs.prs = null;*/
                  //exerciseDay.lift = null;

                  //await fAuth.FirebaseAuth?.instance?.signOut();
                  await user.logout();
                  //fAuth.FirebaseAuth.instance.currentUser. = null;

                  print("successfully logged out");
                  // pop until we get to the login page
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login',
                    (Route<dynamic> route) => false,
                  );
                  //arguments: true); // this doesn't actually work because of static + on every page
                  // so clicking open the drawer fires events
                },
              ),
            ]),
          ),
        ]),
      );
    });
  }
}
//)
//;
////}
//}
