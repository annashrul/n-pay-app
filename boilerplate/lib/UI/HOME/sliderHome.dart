import 'package:Npay/BLOC/INFO/infoBloc.dart';
import 'package:Npay/MODEL/INFO/infoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class SliderHome extends StatefulWidget {
  @override
  _SliderHomeState createState() => _SliderHomeState();
}

class _SliderHomeState extends State<SliderHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      infoBloc.fetchInfo();
    }
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return StreamBuilder(
        stream: infoBloc.getResult,
        builder: (context, AsyncSnapshot<InfoModel> snapshot){
          if (snapshot.hasData) {
            return Swiper(
              autoplay: true,
              fade: 0.0,
              itemCount: snapshot.data.result.slider.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  height: MediaQuery.of(context).size.height/2.6,
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(children: <Widget>[
                      Image.network(snapshot.data.result.slider[index].image, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            snapshot.data.result.slider[index].image,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil.getInstance().setSp(40),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                );
//                return Text("acuy");
              },
              viewportFraction: 0.8,
              scale: 0.9,
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        }
    );
  }
}