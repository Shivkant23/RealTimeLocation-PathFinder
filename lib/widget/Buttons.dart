import 'package:flutter/material.dart';
import 'package:SalesTrendz/widget/Colors.dart';
import 'WidgetStandarts.dart';

class Buttons{

  static Widget roundedRectButton(String title, Function function) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
        child: Stack(
          alignment: Alignment(1.0, 0.0),
          children: <Widget>[
            GestureDetector(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(mContext).size.width / 2,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.blue
                ),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                padding: EdgeInsets.only(top: 16, bottom: 16),
              ),
              onTap: (){
                function();
              },
            ),
          ],
        ),
      );
    });
  }
  static getButton(String name, Color colorname, Function onPressFunction){
    return RaisedButton(
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0)),
      onPressed: onPressFunction,
      textColor: UIColors.whiteColor,
      padding: EdgeInsets.all(0.0),
      color: UIColors.blueAccentColor,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: colorname
        ),
        padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
        child: WidgetStandarts.getText(name),
      ),
    );
  }


  static flatcancelButton(BuildContext context, String buttonName){
    return FlatButton(
      color: UIColors.whiteColor,
      child: Text(buttonName, style: TextStyle(color: UIColors.blackColor),),
      onPressed: (){
        Navigator.of(context).pop();
      },
    );
  }

  static cancelOkButton(context, btnName){
    return Padding(
      padding: EdgeInsets.only(right: 27.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          WidgetStandarts.flatcancelButton(context, "CANCEL"),
          new ButtonTheme(
            minWidth: 60.0,
            height: 36.0,
            child: RaisedButton(
              child: Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                child: Text(btnName, style: TextStyle(fontSize: 14.0),
                ),
              ),
              padding: EdgeInsets.all(0.0),
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              textColor: UIColors.whiteColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  static simpleButton(Function method){
    return RaisedButton(
      child: Text("SUBMIT"),
      onPressed: (){
        method();
      },
    );
  }
}