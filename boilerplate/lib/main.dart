import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/HELPER/onboarding/onboarding.dart';
import 'package:Npay/UI/AUTH/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transparent_image/transparent_image.dart';

import 'HELPER/apiService.dart';
import 'MODEL/ONBOARDING/onBoardingModel.dart';
import 'MODEL/ONBOARDING/pageViewModel.dart';
import 'UI/index.dart';


void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };
    OneSignal.shared.init("a4f782cc-0b52-4526-862d-4530805ec1d3", iOSSettings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
//      home:  OTP(otp: '0909',param: 'pin',check: (param){}),
      home: Splash(),
    );
  }
}





class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  ImageProvider logo;
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("ISLOGIN");
    print(prefs.getBool('seen'));
    bool _seen = (prefs.getBool('seen') ?? false);
    print("##############################IEU SEEN $_seen #################################");
    print("##############################IEU CEK ${prefs.getBool('cek')} #################################");
    if (_seen) {
      Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new Index()));
    } else {
      prefs.setBool('seen', true);
      prefs.setBool('cek', true);

      if(prefs.getBool('cek') == true){
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new IntroScreen()));

      }else{
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => new Index()));
      }
    }
  }
  @override
  void didChangeDependencies() async {
    logo = AssetImage(ApiService().logo);
    await precacheImage(logo, context);
    super.didChangeDependencies();
    print('abus');
  }
  @override
  void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 1000), () {
      checkFirstSeen();
    });
//    getLogo();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.transparent),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//                      FadeInImage(
//                        placeholder: MemoryImage(kTransparentImage),
//                        image: AssetImage(ApiService().logo,),
//                      ),
                      getLogo(),
                      SizedBox(height: 20.0,),
                      Text('Versi '+ApiService().versionCode,style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),)
                    ],
                  ),
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }

  Widget getLogo() {
    Image logoImage = Image(fit:BoxFit.contain,image: logo, width: ScreenUtil.getInstance().setWidth(250), height: ScreenUtil.getInstance().setHeight(250));
    return Padding(
        padding: EdgeInsets.only(right: 5.0 * 5, left: 5.0 * 5),
        child: logoImage
    );
  }

}




class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  List<PageViewModel> wrapOnboarding = [];
  var cek = [];
  bool isLoading = false;
  var res;
  Future load() async{
    Client client = Client();
    final response = await client.get(ApiService().baseUrl2+'info/onboarding');
    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      if(response.body.isNotEmpty){
        OnboardingModel onboardingModel = OnboardingModel.fromJson(jsonResponse);
        onboardingModel.result.map((Result items){
          setState(() {
            wrapOnboarding.add(PageViewModel(
              pageColor: Colors.black,
              bubbleBackgroundColor: Colors.white,
              title: Container(),
              body: Column(
                children: <Widget>[
                  Text(items.title,style: TextStyle(fontFamily: 'Rubik',color:Colors.white,fontWeight: FontWeight.bold)),
                  Text(items.description,style: TextStyle(color:Colors.white,fontSize: 12.0,fontFamily: 'Rubik',fontWeight: FontWeight.bold)),
                ],
              ),
              mainImage: Image.network(
                items.picture,
                width: 285.0,
                alignment: Alignment.center,
              ),
              textStyle: TextStyle(color: Colors.black,fontFamily: 'Rubik',),
            ));
          });

        }).toList();
        setState(() {
          isLoading = false;
        });
      }
      print(wrapOnboarding);
    }else {
      throw Exception('Failed to load info');
    }
  }
  @override
  void initState(){
    load();
    isLoading = true;
  }
  SharedPreferences preferences;
  Future<Null> go() async {
    final userRepository = ApiService();
    var id = await userRepository.getID() ;
    print(id);
    if(id == null || id == ''){
      Navigator.of(context, rootNavigator: true).push(
        new CupertinoPageRoute(builder: (context) => Login()),
      );
    }else{
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) => Index()), (Route<dynamic> route) => false);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading?Container(child: Center(child: CircularProgressIndicator(),),):Container(
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
          child: Stack(
            children: <Widget>[
              IntroViewsFlutter(
                wrapOnboarding,
                onTapDoneButton: (){
                  go();
                },
                background: Colors.black,
                showNextButton: true,
                showSkipButton: true,
                showBackButton: true,
                doneText: Text("GET STARTED",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Rubik')),
                pageButtonsColor: Colors.white,
                pageButtonTextStyles: new TextStyle(
                  fontSize: 16.0,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.bold
                ),
              ),
              Positioned(
                  top: 20.0,
                  left: MediaQuery.of(context).size.width/2 - 50,
                  child: Image.network('https://cdn.iconscout.com/icon/free/png-512/paytm-226448.png', width: 100,)
              )
            ],
          ),
        )
    );
  }
}
