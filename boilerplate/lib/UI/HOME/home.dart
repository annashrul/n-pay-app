import 'dart:convert';

import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/HELPER/skeletonFrame.dart';
import 'package:Npay/MODEL/INFO/infoModel.dart';
import 'package:Npay/PROVIDER/INFO/infoProvider.dart';
import 'package:Npay/UI/FINANCE/deposit.dart';
import 'package:Npay/UI/PRODUCT/formPPOBPasca.dart';
import 'package:Npay/UI/PRODUCT/formPPOBPra.dart';
import 'package:Npay/UI/notif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _key = GlobalKey<RefreshIndicatorState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final userRepository = ApiService();
  int _current = 0;
  int arrCurrentList = 8;
  String title = 'all';
  static bool isLoading = false;
  InfoModel info;
  String picture = '',saldoMain='0';
  final formatter = new NumberFormat("#,###");
  final constant = Constant();
  int countNotif=0;
  Future checkConnection() async{
    final checkConnection = await constant.check();
    if(checkConnection == false){
      setState(() {
        isLoading=false;
      });
      return constant.showInSnackBar(scaffoldKey,context,'no internet connection', 'failed');
    }
  }

  Future<void> load() async{
    setState(() {
      isLoading = true;
    });
    if(mounted){
      final checkConnection = await constant.check();
      if(checkConnection == false){
        setState(() {
          isLoading=false;
        });
        return constant.showInSnackBar(scaffoldKey,context,'no internet connection', 'failed');
      }else{
        final token = await userRepository.getToken();
        final username = userRepository.username;
        final password = userRepository.password;
        var jsonString = await http.get(ApiService().baseUrl+'info',headers: {'Authorization':token,'username':username,'password':password});
        if (jsonString.statusCode == 200) {
          if(jsonString.body.isNotEmpty){
            final jsonResponse = json.decode(jsonString.body);
            if(jsonString.body.length > 0){
              setState(() {
                info = InfoModel.fromJson(jsonResponse);
                picture = info.result.picture;
                saldoMain = info.result.saldoMain;
                countNotif = info.result.notifikasi;
                isLoading = false;
              });
              print(jsonString.body);
            }else{
              print(jsonString.body);
            }
          }else{
            print(jsonString.body);
          }
        } else {
          setState(() {
            isLoading = false;
          });
          throw Exception('Failed to load info');
        }
      }
    }
  }
  Future showHide(param) async{

    setState(() {
      isLoading = true;
    });
    if(param=='all'){

      setState(() {
        title = 'etc';
        isLoading = false;
        arrCurrentList = info.result.productType.length;
      });
    }else{
      setState(() {
        title = 'all';
        isLoading = false;
        arrCurrentList = 8;
      });
    }
    print(title);
  }

  @override
  void initState() {
    super.initState();
//    _scrollController = ScrollController();
    load();

//    checkConnection();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    load();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      key: scaffoldKey,
      body: RefreshIndicator(
          child: Container(
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
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:20.0,right:20.0,top:50.0,bottom: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          isLoading ? SkeletonFrame(width:  MediaQuery.of(context).size.width/2.0,height: 20) : Text(saldoMain, style: TextStyle(fontFamily:'Rubik',color: Colors.white, fontSize: ScreenUtil.getInstance().setHeight(36), fontWeight: FontWeight.w700),),
                          Container(
                            child: Row(
                              children: <Widget>[
                                isLoading ? CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(child: SkeletonFrame(width: 30,height: 30),
                                  ),
                                ):Stack(
                                  children: <Widget>[
                                    InkWell(
                                      child: Icon(Icons.notifications, color: Color(0xFFFFE0B2)),
                                      onTap: (){
                                        if(countNotif != 0){
                                          Navigator.of(context, rootNavigator: true).push(
                                            new CupertinoPageRoute(builder: (context) =>  Notif())
                                          );
                                        }
                                      },
                                    ),
                                    countNotif != 0 ? Positioned(  // draw a red marble
                                      top: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 0),
                                        padding: EdgeInsets.all(2),
                                        decoration: new BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        constraints: BoxConstraints(minWidth: 12,minHeight: 12),
                                        child: Text(
                                          "$countNotif",
                                          style: TextStyle(color: Colors.white, fontSize: 8),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ) : Container()
                                  ]
                                ),
                                SizedBox(width: 16),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(child: isLoading?SkeletonFrame(width: 60,height: 60):Image.network(picture, fit: BoxFit.cover)),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      isLoading ? SkeletonFrame(width: MediaQuery.of(context).size.width/2.0,height: 20) : Text("Available Balance", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFFFFE0B2))),
                      SizedBox(height : ScreenUtil.getInstance().setHeight(24)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.of(context, rootNavigator: true).push(
                                  new CupertinoPageRoute(builder: (context) =>  Deposit())
                              );
                            },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 245, 248, 1),
                                        borderRadius: BorderRadius.all(Radius.circular(18))
                                    ),
                                    child: Icon(Icons.account_balance_wallet, color: Colors.black54, size: 30,),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  SizedBox(height: ScreenUtil.getInstance().setHeight(4)),
                                  Text("Deposit", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFFFFE0B2)),),
                                ],
                              ),
                            ),
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(243, 245, 248, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child: Icon(Icons.transform, color: Colors.black54, size: 30,),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(4),
                                ),
                                Text("Transfer", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFFFFE0B2)),),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(243, 245, 248, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child: Icon(Icons.attach_money, color: Colors.black54, size: 30,),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(4),
                                ),
                                Text("History", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFFFFE0B2)),),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(243, 245, 248, 1),
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  child: Icon(Icons.trending_down, color: Colors.black54, size: 30,),
                                  padding: EdgeInsets.all(12),
                                ),
                                SizedBox(
                                  height: ScreenUtil.getInstance().setHeight(4),
                                ),
                                Text("Topup", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFFFFE0B2)),),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints){
                    return DraggableScrollableSheet(
                      builder: (context, scrollController){
                        return Container(
                          decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: ScreenUtil.getInstance().setHeight(24)),
                                Container(
                                  height: ScreenUtil.getInstance().setHeight(250),
                                  color: Colors.transparent,
                                  padding: EdgeInsets.all(16.0),
                                  child: isLoading?loadingSlider(context):info.result.slider.length>0?Swiper(
                                    autoplay: true,
                                    fade: 0.0,
                                    itemCount: info.result.slider.length,
                                    itemBuilder: (BuildContext context, int index){
                                      return Container(
                                        height: MediaQuery.of(context).size.height/2.6,
                                        margin: EdgeInsets.all(5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                          child: Stack(children: <Widget>[
                                            Image.network(info.result.slider[index].image, fit: BoxFit.cover, width: 1000.0),
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
                                                  info.result.slider[index].title,
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
                                    },
                                    viewportFraction: 0.8,
                                    scale: 0.9,
                                  ):Container(child:Center(child: Text(Constant.noMsgData,style:TextStyle(fontFamily:'Rubik'),))),
                                ),
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          CustomHeading(title: 'Product'),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  showHide(title);
                                                },
                                                shape: new RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(10.0),
                                                    side: BorderSide(color: title == 'all' ? Constant.backgroundColor1 : Constant.backgroundColor3)
                                                ),
                                                padding: EdgeInsets.all(10.0),
                                                child: Row( // Replace with a Row for horizontal icon + text
                                                  children: <Widget>[
                                                    Icon(title == 'all' ? Icons.add_circle : Icons.remove_circle,color: Colors.orangeAccent,),
                                                    SizedBox(width: 5.0),
                                                    Text(title=='all'?"See All":'See Some',style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 16, color: Colors.grey[800]))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      padding: EdgeInsets.only(right: 15.0),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left:10.0,right:10.0,top: 30),
                                      child: isLoading?_loading(context):arrCurrentList > 0 ? GridView.builder(
                                        itemCount: arrCurrentList,
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: ()=>{
                                              Navigator.of(context, rootNavigator: true).push(
                                                new CupertinoPageRoute(builder: (context) => info.result.productType[index].type == '0' ? FormPPOBPra(type: info.result.productType[index].title) : FormPPOBPasca(type: info.result.productType[index].title))
                                              )
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5.0),
                                                margin: EdgeInsets.only(top:5.0,bottom:5.0,right:5.0,left:5.0),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  border: Border.all(color:  Color(0xFFEF6C00), width:1.5),
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      child: Center(
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor: Colors.white,
                                                          child: ClipOval(child: Image.network(info.result.productType[index].image, height: ScreenUtil.getInstance().setHeight(50),),),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: MediaQuery.of(context).size.height/220),
                                                    Flexible(child: Text(info.result.productType[index].title+" | "+info.result.productType[index].type,textAlign: TextAlign.center,style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.bold, fontSize: ScreenUtil.getInstance().setHeight(20), color: Colors.black),),
                                                    )
                                                  ],
                                                )
                                            ),
                                          );
                                        },
                                      ) : Container(child:Center(child: Text(Constant.noMsgData,style:TextStyle(fontFamily:'Rubik'),))),
                                    )
                                  ],
                                ),
                                SizedBox(height: ScreenUtil.getInstance().setHeight(16)),
                                CustomHeading(title: 'Hot Sale'),
                                SizedBox(height: ScreenUtil.getInstance().setHeight(25)),
                                isLoading ? loadingHotSale(context) : info.result.hotSale.length > 0 ?  ListView.builder(
                                  itemBuilder: (context, index){
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 0),
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    borderRadius: BorderRadius.all(Radius.circular(18))
                                                ),
                                                child: Icon(Icons.directions_car, color: Colors.lightBlue[900],),
                                                padding: EdgeInsets.all(12),
                                              ),

                                              SizedBox(width: 16,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(info.result.hotSale[index].provider, style: TextStyle(fontFamily:'Rubik',fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                                                    SizedBox(height:5.0,),
                                                    Text(info.result.hotSale[index].note, style: TextStyle(fontFamily:'Rubik',fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text("Rp ${formatter.format(info.result.hotSale[index].price)}", style: TextStyle(fontFamily:'Rubik',fontSize: 14, fontWeight: FontWeight.w700, color: Colors.orange),),
                                                  SizedBox(height:5.0),
                                                  Text("Rp ${formatter.format(info.result.hotSale[index].priceBefore)}", style: TextStyle(decoration: TextDecoration.lineThrough,fontFamily:'Rubik',fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:EdgeInsets.only(left:15.0,right:15.0),
                                          child: Divider(),
                                        )
                                      ],
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: info.result.hotSale.length,
                                  padding: EdgeInsets.all(0),
                                  controller: ScrollController(keepScrollOffset: false),
                                ) : Container(child:Center(child: Text(Constant.noMsgData,style:TextStyle(fontFamily:'Rubik'),))),
                                //now expense
                              ],
                            ),
                            controller: scrollController,
//                        controller: listScroll,
                            physics: ClampingScrollPhysics(),
                          ),
                        );
                      },
                      initialChildSize:constraints.maxWidth >= 350 ? 0.65:0.60,
                      minChildSize:constraints.maxWidth >= 350 ? 0.65:0.60,
                      maxChildSize: 1,
                    );
                  },
                )
              ],
            ),
          ),
          key: _key,
          onRefresh: load
      ),
    );
  }





  Widget loadingSlider(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height/2.6,
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          SkeletonFrame(width: MediaQuery.of(context).size.width/1.0,height: MediaQuery.of(context).size.height/2.6),

        ]),
      ),
    );
  }
  Widget _loading(BuildContext context){
    return GridView.builder(
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.only(top:5.0,bottom:5.0,right:5.0,left:5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color:  Color(0xFFEF6C00), width:1.5),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: ClipOval(child: SkeletonFrame(width: ScreenUtil.getInstance().setWidth(100),height: ScreenUtil.getInstance().setHeight(100))),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(5)),
                  Flexible(child: SkeletonFrame(width: ScreenUtil.getInstance().setWidth(100),height: ScreenUtil.getInstance().setHeight(25)))
                ],
              )
          ),
        );
      },
    );
  }

  Widget loadingHotSale(BuildContext context){
    return ListView.builder(
      itemBuilder: (context, index){
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: ClipOval(child: isLoading?SkeletonFrame(width: 60,height: 60):Image.network(picture, fit: BoxFit.contain,),
                    ),
                  ),

                  SizedBox(width: 16,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SkeletonFrame(width: MediaQuery.of(context).size.width/3.0,height: 15),
                        SkeletonFrame(width: MediaQuery.of(context).size.width/3.0,height: 15),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SkeletonFrame(width: MediaQuery.of(context).size.width/3.0,height: 15),
                      SkeletonFrame(width: MediaQuery.of(context).size.width/3.0,height: 15),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding:EdgeInsets.only(left:15.0,right:15.0),
              child: Divider(),
            )
          ],
        );
      },
      shrinkWrap: true,
      itemCount: 5,
      padding: EdgeInsets.all(0),
      controller: ScrollController(keepScrollOffset: false),
    );
  }




  Future moves(param) async{
    print(param);
  }


}





