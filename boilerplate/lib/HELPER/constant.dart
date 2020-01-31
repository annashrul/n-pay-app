import 'package:Npay/HELPER/ALERTDIALOGQ/alertq.dart';
import 'package:Npay/UI/index.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class CustomColor{
  static const colorOne   = Color(0xFFFFB74D);
  static const colorTwo   = Color(0xFFFA7266);
  static const colorThree = Color(0xFFF57C00);
  static const colorFour  = Color(0xFFEF6C00);
}


class Constant {
  static const primaryColor = Color(0xff5364e8);
  static const primaryDarkColor = Color(0xff607Cbf);
  static const underlineTextField = Color(0xff8b97ff);
  static const hintColor = Color(0xffccd1ff);
  static const backgroundColor1 = Color(0xFFFFB74D);
  static const backgroundColor2 = Color(0xFFFA7266);
  static const backgroundColor3 = Color(0xFFF57C00);
  static const backgroundColor4 = Color(0xFFEF6C00);
  static const noMsgData = "Data Not Available";


  Future browseContact(BuildContext context,String param) async {
    final ContactPicker _contactPicker = new ContactPicker();
    Contact _contact;
    Contact contact = await _contactPicker.selectContact();
    _contact = contact;
    var cek = _contact.phoneNumber.number.toString().replaceAll("+62 ", "0");
    param = cek.replaceAll("-", "");
//    print(param);
    var no = param;
    FocusScope.of(context).requestFocus(FocusNode());
    return no;
  }




  appBarQ(BuildContext context,String title){
    var cek = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios,color: Colors.white),
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      centerTitle: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              CustomColor.colorOne,
              CustomColor.colorTwo,
              CustomColor.colorThree,
              CustomColor.colorFour,
            ],
          ),
        ),
      ),
      elevation: 1.0,
      automaticallyImplyLeading: false,
      title: new Text(title, style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Rubik')),
    );
    return cek;
  }

  rplcToUnderScore(String txt){
    var cek = txt.replaceAll(" ", "_").toUpperCase();
    return cek;
  }
  rplcToSpace(String txt){
    var cek = txt.replaceAll("_", " ").toLowerCase();
    return cek;
  }

  void showInSnackBar(_scaffoldKey,BuildContext context,String value,param) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "Rubik"),
      ),
      backgroundColor: param=='failed' ? Colors.redAccent : Colors.greenAccent,
      duration: Duration(seconds: 3),
    ));
    return;
  }

  void fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
    return;
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void notifAlert(BuildContext context,type,title,desc,bool isTrue) async{
    AlertQ(
      context: context,
      type: type=='success'? AlertType.success:(type=='info'?AlertType.info:AlertType.error),
      title: title,
      desc: desc,
      style: AlertStyle(titleStyle:TextStyle(fontSize: 14,fontFamily: 'Rubik',fontWeight:FontWeight.bold), descStyle: TextStyle(fontSize: 12,fontFamily: 'Rubik',fontWeight:FontWeight.bold)),
      buttons: [
        DialogButton(
          child: Text(
            "BACK", style: TextStyle(color: Colors.white, fontFamily: 'Rubik',fontSize: 20,fontWeight:FontWeight.bold)
          ),
          onPressed: () {
            isTrue==true?Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Index()), (Route<dynamic> route) => false):Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
    return;
  }


}


class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 50.0,
            child: Image.network('https://web.sekota.id/assets/images/nodata-review.png'),
          ),
        ],
      ),
    );
  }
}


class HorizontalLine extends StatefulWidget {
  @override
  _HorizontalLineState createState() => _HorizontalLineState();
}

class _HorizontalLineState extends State<HorizontalLine> {
  void cek(){

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil.getInstance().setWidth(120),
        height: 1.0,
        color: Colors.white.withOpacity(.2),
      ),
    );
  }
}


const BUBBLE_WIDTH = 55.0;

const FULL_TARNSITION_PX = 300.0;

const PERCENT_PER_MILLISECOND = 0.00125;

enum SlideDirection {
  leftToRight,
  rightToLeft,
  none,
}

enum UpdateType {
  dragging,
  doneDragging,
  animating,
  doneAnimating,
}

enum TransitionGoal {
  open,
  close,
}









