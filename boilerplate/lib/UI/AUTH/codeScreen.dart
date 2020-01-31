import 'package:Npay/HELPER/apiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';

class CodeScreen extends StatefulWidget {
  final String code,param;
  final Function(String code) check;
  CodeScreen({this.code,this.param,this.check});
  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String currentText = '';

  void biometrics(){
    print('print');
  }

  @override
  Widget build(BuildContext context) {
    String desc = '';
    if(widget.param == 'otp'){
      desc = 'Enter the OTP Code That We Have Sent Through WhatsApp Message';
    }else{
      desc = 'Enter the pin for the security of your account';
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: LockScreen(
          showFingerPass: true,
          forgotPin: 'forgot PIN ? Click here',
          fingerFunction: biometrics,
          title: "SECURITY",
          passLength: widget.param == 'otp' ? 4 : 6,
          bgImage: "assets/images/bg.jpg",
          borderColor: Colors.black,
          showWrongPassDialog: true,
          wrongPassContent: widget.param == 'otp' ? "OTP Code Mismatch" : "PIN Does Not Match",
          wrongPassTitle: "Opps!",
          wrongPassCancelButtonText: "Cancel",
          deskripsi: "$desc ${ApiService().showCode == true ? widget.code : ""}",
          passCodeVerify: (passcode) async {
            var concatenate = StringBuffer();
            passcode.forEach((item){
              concatenate.write(item);
            });
            setState(() {
              currentText = concatenate.toString();
            });
            if(currentText != widget.code){
              return false;
            }
            return true;
          },
          onSuccess: () {
            print(currentText);
            widget.check(currentText);
          }
        ),
      )
    );
  }
}
