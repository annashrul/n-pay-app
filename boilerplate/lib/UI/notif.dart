import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notif extends StatefulWidget {
  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top:30.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomHeading(
                    title: 'Direct Messages',
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      child: Icon(Icons.clear),
                      onTap: (){Navigator.pop(context);},
                    ),
                  )
                ],
              ),
              ListView.builder(
                itemCount: 50,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Material(
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(

                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(50),
                              offset: Offset(0, 0),
                              blurRadius: 5,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.transparent
//                          color: Colors.white,
                        ),
                        child: Row(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  child: Icon(Icons.notifications,color: Colors.deepOrangeAccent,size: 20.0,),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Pembelian Pulsa Telkomsel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily:'Rubik',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                  Text(
                                    'XXXXXXXXXXXX',
                                    style: TextStyle(
                                      color: Color(0xFF4563DB),
                                      fontSize: 12,
                                      fontFamily:'Rubik',
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Text(
                                      '$index:00 AM',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontFamily:'Rubik',
                                      ),
                                    )
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomHeading extends StatelessWidget {
  final String title;

  const CustomHeading({Key key, @required this.title}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: Row(
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily:'Rubik',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 15,
            width: 30,
            height: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 1],
                  colors: [
                    Color(0xFFFFB74D),
                    Color(0xFFFA7266),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}