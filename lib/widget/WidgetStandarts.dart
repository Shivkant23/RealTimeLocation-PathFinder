import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:SalesTrendz/widget/Colors.dart';
import 'package:SalesTrendz/screens/pro/mapPage.dart';

class WidgetStandarts {
  static double height;
  static double width;

  static BoxDecoration getHeaderDecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      colors: UIColors.orangeGradients,
    ));
  }


  static getText(String text,
      [double _fontSize,
      FontStyle _fontStyle,
      FontWeight _fontWeight,
      Color color]) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Text(
        text,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: _fontWeight,
          color: color,
        ),
      ),
    );
  }

  static FloatingActionButton getFloatingButton(BuildContext pContext) {
    return FloatingActionButton(
      backgroundColor:
          Theme.of(pContext).floatingActionButtonTheme.backgroundColor,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.home),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  static BottomNavigationBar getBottomBar(
      [bool activeFlag, BuildContext context, int index]) {
    return BottomNavigationBar(
      unselectedItemColor: UIColors.black54Color,
      selectedItemColor: activeFlag ? Colors.deepPurple : UIColors.black12Color,
      showUnselectedLabels: true,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("UPDATES", style: TextStyle(fontSize: 10))),
        BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            title: Text("CONNECTS", style: TextStyle(fontSize: 10))),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            title: Text("")),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("PEOPLE", style: TextStyle(fontSize: 10))),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("DASHBOARD", style: TextStyle(fontSize: 10))),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            pushWithRouteNameAndRemoveUntilMenu(context, '');
            break;
          case 1:
            pushWithRouteNameAndRemoveUntilMenu(context, '');
            break;
          case 2:
            pushWithRouteNameAndRemoveUntilMenu(context, '');
            break;
          case 3:
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MapPage()),
            );
            break;
        }
      },
    );
  }

  static pushWithRouteNameAndRemoveUntilMenu(
      BuildContext context, String pushRouteName) {
    return Navigator.pushNamedAndRemoveUntil(
        context, pushRouteName, ModalRoute.withName('dashboard'));
  }

  static flatcancelButton(BuildContext context, String buttonName) {
    return FlatButton(
      color: UIColors.whiteColor,
      child: Text(
        buttonName,
        style: TextStyle(color: UIColors.blackColor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  static void getWidthAndHeight(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }

  static getFlutterToast({String msg}) {
    return Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black,
        toastLength: Toast.LENGTH_LONG);
  }
}
