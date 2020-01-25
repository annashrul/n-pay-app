import 'package:Npay/UI/PRODUCT/index.dart';
import 'package:Npay/UI/notif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 20.0),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color(0xFFFFB74D),
                  Color(0xFFFA7266),
                  Color(0xFFF57C00),
                  Color(0xFFEF6C00),
                ],
              ),
            ),
            padding: EdgeInsets.only(left:20.0,right:20.0,top:50.0,bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Rp 1,000,000", style: TextStyle(fontFamily:'Rubik',color: Colors.white, fontSize: 36, fontWeight: FontWeight.w700),),
                    Container(
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            child: Icon(Icons.notifications, color: Color(0xFFFFE0B2)),
                            onTap: (){
                              Navigator.of(context, rootNavigator: true).push(
                                new CupertinoPageRoute(builder: (context) => Notif()),
                              );
                            },
                          ),
                          SizedBox(width: 16,),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: ClipOval(child: Image.network("https://pngimage.net/wp-content/uploads/2018/06/logo-orang-png.png", fit: BoxFit.contain,),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Text("Available Balance", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFFFFE0B2))),
                SizedBox(height : 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
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
                          SizedBox(
                            height: 4,
                          ),
                          Text("Deposit", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFFFFE0B2)),),
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
                            child: Icon(Icons.transform, color: Colors.black54, size: 30,),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
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
                            height: 4,
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
                            height: 4,
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


          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController){
              return Container(
//                color: Colors.white,
                decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomHeading(title: 'Product'),
//                            Text("Product", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black),),
                            Text("See all", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.w700, fontSize: 16, color: Colors.grey[800]),)
                          ],
                        ),
                        padding: EdgeInsets.only(right: 15.0),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:10.0,right:10.0),
                        child: GridView.builder(
                          itemCount: 12,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: ()=>{
                                Navigator.of(context, rootNavigator: true).push(
                                  new CupertinoPageRoute(builder: (context) => Index()),
                                )
                              },
                              child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  margin: EdgeInsets.only(top:1.0,bottom:5.0,right:5.0,left:5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    border: Border.all(color:  Color(0xFFEF6C00), width:1.5),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(child: Image.network("http://dekape.co.id/assets/img/partners/telkomsel.png", fit: BoxFit.contain,),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Flexible(child: Text("Telp / Internet", style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.bold, fontSize: 10, color: Colors.black),),)
                                    ],
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                      //now expense
                      SizedBox(height: 16,),
                      CustomHeading(title: 'Hot Sale'),
                      SizedBox(height: 25,),
                      ListView.builder(
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
                                          Text("Petrol", style: TextStyle(fontFamily:'Rubik',fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                                          Text("Payment from Saad", style: TextStyle(fontFamily:'Rubik',fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                        ],
                                      ),
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text("-\$500.5", style: TextStyle(fontFamily:'Rubik',fontSize: 18, fontWeight: FontWeight.w700, color: Colors.orange),),
                                        Text("26 Jan", style: TextStyle(fontFamily:'Rubik',fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
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
                        itemCount: 4,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: false),
                      ),

                      //now expense


                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.70,
            minChildSize: 0.70,
            maxChildSize: 1,
          ),
        ],
      ),
    );
  }




  Future moves(param) async{
    print(param);
  }
}


