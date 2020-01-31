import 'package:Npay/HELPER/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import '../notif.dart';

class Deposit extends StatefulWidget {
  @override
  _DepositState createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  bool isSelected = false;
  var saldoController  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var moneyController = MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',');
    moneyController.updateValue(0.00);

    moneyController.addListener((){
      print(moneyController.numberValue);
    });
    return Scaffold(
      appBar: Constant().appBarQ(context, "Deposit"),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color:  Color(0xFFEF6C00), width:1.5),
              ),
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Image.network("https://i.ya-webdesign.com/images/icon-wallet-png-3.png",height: 30,width: 30,),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("wallet balance",style:TextStyle(color:Colors.grey,fontFamily: 'Rubik',fontWeight: FontWeight.bold)),
                      Text("Rp 0",style:TextStyle(fontSize:14.0,fontFamily: 'Rubik',fontWeight: FontWeight.bold)),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color:  Color(0xFFEF6C00), width:1.5),
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Rp",style: TextStyle(fontSize: 20.0,color: Constant.backgroundColor3,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),),
                            SizedBox(width: 10.0),
                            new Expanded(
                              child: new TextField(
                                style: TextStyle(fontSize: 20.0,color:Constant.backgroundColor3,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
//                                  WhitelistingTextInputFormatter.digitsOnly,
//                                  new CurrencyInputFormatter()
                                  LengthLimitingTextInputFormatter(12),
                                  WhitelistingTextInputFormatter.digitsOnly,
                                  BlacklistingTextInputFormatter.singleLineFormatter,
                                ],
                                controller: moneyController,
                                decoration: InputDecoration(
                                  hintText: "100.000",
                                  labelStyle: TextStyle(color: Constant.backgroundColor3,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                                  hintStyle: TextStyle(color: Constant.backgroundColor3,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                                  counterText: "",
                                  border: UnderlineInputBorder(),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomHeading(title: 'Deposit Addition'),
//                  Text("Deposit Addition",style:TextStyle(fontSize:14.0,color:Colors.grey,fontFamily: 'Rubik',fontWeight: FontWeight.bold)),
                  GridView.count(
                    padding: EdgeInsets.only(top:10, bottom: 10, right: 2),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 2,
                    shrinkWrap: true,
                    children: <Widget>[
                      RaisedButton(
                        elevation: 0.5,padding: EdgeInsets.all(1),color:Colors.white,
                        onPressed: () {moneyController.text = "100,000.00";},
                        child: Text("Rp 100,000.00",style: TextStyle(color:Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
                      ),
                      RaisedButton(
                        elevation: 0.5,padding: EdgeInsets.all(1),color:Colors.white,
                        onPressed: () {moneyController.text = "200,000.00";},
                        child: Text("Rp 200,000.00",style: TextStyle(color:Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
                      ),
                      RaisedButton(
                        elevation: 0.5,padding: EdgeInsets.all(1),color:Colors.white,
                        onPressed: () {moneyController.text = "300,000.00";},
                        child: Text("Rp 300,000.00",style: TextStyle(color:Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
                      ),
                      RaisedButton(
                        elevation: 0.5,padding: EdgeInsets.all(1),color:Colors.white,
                        onPressed: () {moneyController.text = "400,000.00";},
                        child: Text("Rp 400,000.00",style: TextStyle(color:Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
                      ),
                      RaisedButton(
                        elevation: 0.5,padding: EdgeInsets.all(1),color:Colors.white,
                        onPressed: () {moneyController.text = "500,000.00";},
                        child: Text("Rp 500,000.00",style: TextStyle(color:Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
                      ),
                      RaisedButton(
                        elevation: 0.5,padding: EdgeInsets.all(1),color:Colors.white,
                        onPressed: () {moneyController.text = "1,000,000.00";},
                        child: Text("Rp 1,000,000.00",style: TextStyle(color:Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cepat(String val, String nominal){
    var moneyController = MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: ',');
    moneyController.updateValue(0.00);

    moneyController.addListener((){
      print(moneyController.numberValue);
    });
    return RaisedButton(
      elevation: 0.5,
      padding: EdgeInsets.all(1),
      color:Colors.white,
      onPressed: () {
        moneyController.text = "$val";
      },
      child: Text("$nominal",style: TextStyle(color:Colors.red,fontFamily: 'Rubik',fontWeight: FontWeight.bold),),
    );
  }

}
