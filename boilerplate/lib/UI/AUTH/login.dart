import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/MODEL/AUTH/login.dart';
import 'package:Npay/MODEL/general.dart';
import 'package:Npay/PROVIDER/AUTH/authProvider.dart';
import 'package:Npay/UI/AUTH/codeScreen.dart';
import 'package:Npay/UI/AUTH/register.dart';
import 'package:Npay/UI/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var nameController = TextEditingController();
  var nohpController = TextEditingController();
  var kdreferralController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode nohpFocus = FocusNode();
  final FocusNode kdreferralFocus = FocusNode();
  bool isLoading = false;
  final constant = Constant();
  Future login() async{
    if(nohpController.text == ''){
      setState(() {isLoading = false;});
      return constant.showInSnackBar(_scaffoldKey,context,'no handphone cannot be empty', 'failed');
    }else{
      final checkConnection = await constant.check();
      if(checkConnection == false){
        setState(() {isLoading = false;});
        return constant.showInSnackBar(_scaffoldKey,context,'no internet connection', 'failed');
      }else{
        var status = await OneSignal.shared.getPermissionSubscriptionState();
        String onesignalUserId = status.subscriptionStatus.userId;
        var res = await AuthProvider().fetchLogin(nohpController.text, onesignalUserId);
        if(res is LoginModel){
          LoginModel results = res;
          if(results.status == 'success'){
            setState(() {isLoading = false;});
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('token', results.result.token);
            prefs.setString('id', results.result.id);
            prefs.setString('name', results.result.name);
            prefs.setString('picture', results.result.picture);
            prefs.setString('kdreferral', results.result.kdReferral);
            prefs.setString('pin', results.result.pin.toString());
            prefs.setString('nohp', results.result.noHp.toString());
            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) => CodeScreen(
              code: results.result.otp,param: 'otp',check: (String param){
                Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) => Index()), (Route<dynamic> route) => false);
              },
            )), (Route<dynamic> route) => false);
          }else{
            setState(() {isLoading = false;});
            return constant.showInSnackBar(_scaffoldKey,context,results.msg, 'failed');
          }
        }else{
          setState(() {isLoading = false;});
          General results = res;
          return constant.showInSnackBar(_scaffoldKey,context,results.msg, 'failed');
        }
      }
    }
  }

  Future checkOtp(){
    Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) => Index()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      key: _scaffoldKey,
      body:Container(
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
        padding: EdgeInsets.all(20.0),
        alignment: Alignment.center,
        child: Center(
          child: new ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            children: [
              Center(child: _iconRegister()),
              Center(child: _titleDescription()),
              Center(child: _textField()),
              Center(child: _buildButton(context)),
            ]
          ),
        ),
      ),
    );
  }

  Widget _iconRegister() {
    return Image.asset(
      "assets/images/icon_login.png",
      width: ScreenUtil.getInstance().setWidth(250),
      height: ScreenUtil.getInstance().setWidth(250),
    );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0)),
        Text("Masuk", style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: 'Rubik',fontWeight: FontWeight.bold)),
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tincidunt ante lacus, eu pretium purus vulputate sit amet.",
          style: TextStyle(
              fontSize: 12.0,
              color: Colors.white, fontFamily: 'Rubik',fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _textField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
        ),

        TextFormField(
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Constant.backgroundColor1,
                width: 3.0,
              ),
            ),
            hintText: "No Handphone",
            hintStyle: TextStyle(color: Colors.white,fontFamily: 'Rubik',fontWeight: FontWeight.bold),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
          ], // Only nu
          style: TextStyle(color: Colors.white),
          obscureText: false,
          autofocus: false,
          controller: nohpController,
          focusNode: nohpFocus,
          onFieldSubmitted: (term){
            setState(() {isLoading = true;});
            login();
          },
          textInputAction: TextInputAction.done,
        ),

      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        InkWell(
          onTap: (){
            setState(() {isLoading = true;});
            print(isLoading);
            login();
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: isLoading?Container(child:Center(child:CircularProgressIndicator())):Text(
              'Login',
              style: TextStyle(fontSize:16.0,color: Constant.backgroundColor2,fontFamily: 'Rubik',fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            HorizontalLine(),
            Text("OR",style: TextStyle(color:Colors.white,fontSize: 16.0, fontFamily: "Rubik", fontWeight: FontWeight.bold)),
            HorizontalLine(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.0),
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.white,
                  width: 3.0
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    new CupertinoPageRoute(builder: (context) => Register()),
                  );
                },
                child: Center(
                  child: Text("Register",
                    style: TextStyle(fontSize:16.0,color: Colors.white,fontFamily: 'Rubik',fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
