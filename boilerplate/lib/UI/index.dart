
import 'package:Npay/UI/HOME/home.dart';
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
  GlobalKey _bottomNavigationKey = GlobalKey();

  pinda(page){
    if(page == 0){
      return HomeScreen();
    }else if(page == 1){
      print(page);
      return AnimationsPlayground();
    }
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
//        Color(0xFFF57C00),
////        Color(0xFFEF6C00),
        color: Color(0xFFFF9800),
        buttonBackgroundColor: Color(0xFFFF9800),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });

        },
      ),
      body: pinda(_page),

    );
  }
}





class AnimationsPlayground extends StatelessWidget {
  static Route<dynamic> route() {
    return PageRouteBuilder(
      transitionDuration: const Duration(seconds: 10),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return AnimationsPlayground();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CoolAnimatedApp(),
    );
  }
}

class CoolAnimatedApp extends StatefulWidget {
  @override
  _CoolAnimatedAppState createState() => _CoolAnimatedAppState();
}

class _CoolAnimatedAppState extends State<CoolAnimatedApp> {
  Animation<double> controller;
  Animation<Offset> imageTranslation;
  Animation<Offset> textTranslation;
  Animation<Offset> buttonTranslation;
  Animation<double> imageOpacity;
  Animation<double> textOpacity;
  Animation<double> buttonOpacity;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controller == null) {
      controller = ModalRoute.of(context).animation;
      imageTranslation = Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0),).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.67, curve: Curves.fastOutSlowIn),),
      );
      imageOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.0, 0.67, curve: Curves.easeIn)),
      );
      textTranslation = Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0),).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.34, 0.84, curve: Curves.ease),),
      );
      textOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.34, 0.84, curve: Curves.linear),),
      );
      buttonTranslation = Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0),).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.67, 1.0, curve: Curves.easeIn),),
      );
      buttonOpacity = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.67, 1.0, curve: Curves.easeIn),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Column(
          children: <Widget>[
            FractionalTranslation(
              translation: imageTranslation.value,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.asset(
                  "assets/images/onboarding2.png",
                  height: 300.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: FractionalTranslation(
                translation: textTranslation.value,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 44.0),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non lorem non justo congue feugiat ut a enim. Ut et sem nec lacus aliquet gravida. Mauris viverra lectus nec vulputate placerat. Nullam sit amet blandit massa, volutpat blandit arcu. Vivamus eu tellus tincidunt, vestibulum neque eu, sagittis neque. Phasellus vitae rutrum magna, eu finibus mi. Suspendisse eget laoreet metus. In mattis dui vitae vestibulum molestie. Curabitur bibendum ut purus in faucibus.",
                    style: Theme.of(context).textTheme.body2,
                  ),
                ),
              ),
            ),
            FractionalTranslation(
              translation: buttonTranslation.value,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                color: Colors.black54,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 34.0, vertical: 8.0),
                  child: Text(
                    "Visit",
                    style: TextStyle(
                        color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "You pushed the button ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.black54,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 34.0),
          ],
        );
      },
    );
  }
}
