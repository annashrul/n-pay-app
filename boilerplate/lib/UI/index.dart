
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/UI/AUTH/login.dart';
import 'package:Npay/UI/HISTORY/index.dart';
import 'package:Npay/UI/HOME/home.dart';
import 'package:Npay/UI/PROFILE/indexProfile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _page = 0;
  PageController pageController = PageController(initialPage: 0);

  GlobalKey _bottomNavigationKey = GlobalKey();
  final userRepository = ApiService();
  moves(page){
    if(page == 0){
      return HomeScreen();
    }else if(page == 1){
      print(page);
      return IndexHistory();
    }else if(page == 4){
      return IndexProfile();
    }
  }

  Future checkLoginStatus() async{
    var id = await userRepository.getID();
    if(id==null||id==''){
      Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (BuildContext context) => Login()), (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.home, size: 30,color:Colors.white),
          Icon(Icons.compare_arrows, size: 30,color:Colors.white),
          Icon(Icons.account_balance_wallet, size: 30,color:Colors.white),
          Icon(Icons.favorite, size: 30,color:Colors.white),
          Icon(Icons.person, size: 30,color:Colors.white),
        ],
        color: CustomColor.colorThree,
        buttonBackgroundColor: CustomColor.colorThree,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: moves(_page)

    );
  }
}





