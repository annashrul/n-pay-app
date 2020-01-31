import 'package:Npay/BLOC/PPOB/PPOBPraBloc.dart';
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabPPOBPra extends StatefulWidget {
  final String nohp;
  TabPPOBPra({this.nohp});
  @override
  _TabPPOBPraState createState() => _TabPPOBPraState();
}

class _TabPPOBPraState extends State<TabPPOBPra> {

  final formatter = new NumberFormat("#,###");
  final userRepository = ApiService();
  String nohp = '';
  Future getSession() async {
    var res = await userRepository.getNoHp();
    print(nohp);
    setState(() {
      nohp = res;
    });
    if(widget.nohp == ''){
      ppobPraBloc.fetchPpobPra('PULSA',nohp);
    }else{
      ppobPraBloc.fetchPpobPra('PULSA',widget.nohp);
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();

  }

  @override
  Widget build(BuildContext context){
    return StreamBuilder(
        stream: ppobPraBloc.getResult,
        builder: (context, AsyncSnapshot<PpobPraModel> snapshot){
          if (snapshot.hasData) {
            return builds(snapshot, context);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Container(child: Center(child: CircularProgressIndicator()));
        }
    );
  }


  Widget builds(AsyncSnapshot<PpobPraModel> snapshot, BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.result.data.length,
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
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${snapshot.data.result.data[index].code} ${snapshot.data.result.data[index].nominal}",
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
                            "${snapshot.data.result.data[index].note}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily:'Rubik',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                          ),
                          Text(
                            "Rp ${formatter.format(snapshot.data.result.data[index].rawPrice)}",
                            style: TextStyle(
                              color: Constant.backgroundColor3,
                              fontSize: 12,
                              fontFamily:'Rubik',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Constant.backgroundColor3,
                                  width: 2.0
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {

                                },
                                child: Center(
                                  child: Text("Buy",
                                    style: TextStyle(fontSize:16.0,color: Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
