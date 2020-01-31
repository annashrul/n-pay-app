import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/UI/AUTH/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var nameController = TextEditingController();
  var nohpController = TextEditingController();
  var kdreferralController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode nohpFocus = FocusNode();
  final FocusNode kdreferralFocus = FocusNode();
  bool isLoading = false;
  final constant = Constant();
  Future registrasi() async{

    if(nameController.text == ''){
      setState(() {
        isLoading = false;
        FocusScope.of(context).requestFocus(nameFocus);
      });
      return constant.showInSnackBar(_scaffoldKey,context,'name cannot be empty', 'failed');
    }else if(nohpController.text == ''){
      setState(() {isLoading = false;});
      return constant.showInSnackBar(_scaffoldKey,context,'no handphone cannot be empty', 'failed');
    }else if(kdreferralController.text == ''){
      setState(() {isLoading = false;});
      return constant.showInSnackBar(_scaffoldKey,context,'kode referral cannot be empty', 'failed');
    }else{
      final checkConnection = await constant.check();
      if(checkConnection == false){
        setState(() {isLoading = false;});
        return constant.showInSnackBar(_scaffoldKey,context,'no internet connection', 'failed');
      }
      setState(() {isLoading = false;});
      return constant.showInSnackBar(_scaffoldKey,context,'successfully registered', 'success');
    }
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
              Constant.backgroundColor1,
              Constant.backgroundColor2,
              Constant.backgroundColor3,
              Constant.backgroundColor4,
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
      "assets/images/icon_register.png",
      width: ScreenUtil.getInstance().setWidth(250),
      height: ScreenUtil.getInstance().setWidth(250),
    );
  }

  Widget _titleDescription() {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 16.0)),
        Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: 'Rubik',fontWeight: FontWeight.bold)),
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
            hintText: "Full Name",
            hintStyle: TextStyle(color:Colors.white,fontFamily: 'Rubik',fontWeight: FontWeight.bold),

          ),
          style: TextStyle(color: Colors.white),
          controller: nameController,
          autofocus: false,
          focusNode: nameFocus,
          onFieldSubmitted: (term){
            Constant().fieldFocusChange(context, nameFocus, nohpFocus);
          },
          textInputAction: TextInputAction.next,
        ),
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
          style: TextStyle(color: Colors.white),

          autofocus: false,
          controller: nohpController,
          focusNode: nohpFocus,
          onFieldSubmitted: (term){
            Constant().fieldFocusChange(context, nohpFocus, kdreferralFocus);
          },
          textInputAction: TextInputAction.next,
        ),
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
            hintText: "Kode Referral",
            hintStyle: TextStyle(color: Colors.white,fontFamily: 'Rubik',fontWeight: FontWeight.bold),
          ),
          style: TextStyle(color: Colors.white),
          obscureText: false,
          autofocus: false,
          controller: kdreferralController,
          focusNode: kdreferralFocus,
          onFieldSubmitted: (term){
            setState(() {isLoading = true;});
            registrasi();
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
            registrasi();
          },
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: double.infinity,
            child: isLoading?Container(child:Center(child:CircularProgressIndicator())):Text(
              'Register',
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
            Text("Atau",style: TextStyle(color:Colors.white,fontSize: 16.0, fontFamily: "Rubik", fontWeight: FontWeight.bold)),
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
                    new CupertinoPageRoute(builder: (context) => Login()),
                  );
                },
                child: Center(
                  child: Text("Login",
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


