import 'package:Npay/BLOC/PPOB/PPOBPraBloc.dart';
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/HELPER/skeletonFrame.dart';
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:Npay/UI/AUTH/codeScreen.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class FormPPOBPra extends StatefulWidget {
  final String type;
  FormPPOBPra({this.type});
  @override
  _FormPPOBPraState createState() => _FormPPOBPraState();
}

class _FormPPOBPraState extends State<FormPPOBPra>  with SingleTickerProviderStateMixin{
  final ContactPicker _contactPicker = new ContactPicker();
  Contact _contact;
  TabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final formatter = new NumberFormat("#,###");
  final userRepository = ApiService();
  String nohp = '',_currentItemSelectedLayanan = 'Mobile Credit', layanan = '';
  bool isLoading = false;
  bool isLoading2 = false;
  var nohpController  = TextEditingController();
  var serviceController  = TextEditingController();
  final FocusNode nohpFocus = FocusNode();
  bool _showSecond = false;
  var rplc;
  Future getSession() async {
    setState(() {
      rplc = Constant().rplcToUnderScore(widget.type);
    });
    print(rplc);
    var res = await userRepository.getNoHp();
    setState(() {
      serviceController.text = widget.type;
      nohp = res;
      nohpController.text = nohp;
    });
    ppobPraBloc.fetchPpobPra(rplc,nohp);
    print(nohp);
  }

  Future save() async{
    var rplc = Constant().rplcToUnderScore(widget.type);
    if(nohpController.text == ''){
      setState(() {
        isLoading = false;
      });
      ppobPraBloc.fetchPpobPra(rplc,nohp);
    }else{
      setState(() {
        isLoading = false;
      });
      ppobPraBloc.fetchPpobPra(rplc,nohpController.text);
    }
  }

  Future checkout() async{
    setState(() {
      isLoading2=false;
      Navigator.of(context).pop();
    });
    print('masuk cekout');
    Constant().notifAlert(context, "success", "TRANSACTION SUCCESS",'Your transaction was successful.',true);
  }

  @override
  void initState() {
    getSession();
    super.initState();
    _controller = new TabController(length: 2, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Constant().appBarQ(context, widget.type),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              backgroundHeader(),summaryCash(),
            ],
          ),

          Container(
            child: StreamBuilder(
              stream: ppobPraBloc.getResult,
              builder: (context, AsyncSnapshot<PpobPraModel> snapshot){
                if (snapshot.hasData) {
                  return builds(snapshot, context);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return _loading();
              }
            ),
          )
        ],
      ),
    );

  }

  Widget builds(AsyncSnapshot<PpobPraModel> snapshot, BuildContext context) {
    if(snapshot.data.result.data.length > 0){
      return  ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapshot.data.result.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Material(
            child: InkWell(
              onTap: () {
                _settingModalBottomSheet(
                  context,
                  serviceController.text,
                  snapshot.data.result.data[index].prov,
                  snapshot.data.result.data[index].nominal,
                  snapshot.data.result.data[index].price,
                );
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
                          Padding(padding: EdgeInsets.only(top: 5)),
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
                                  _settingModalBottomSheet(
                                    context,
                                    serviceController.text,
                                    snapshot.data.result.data[index].prov,
                                    snapshot.data.result.data[index].nominal,
                                    snapshot.data.result.data[index].price,
                                  );
                                },
                                child: Center(
                                  child: Text("Buy Now",
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
      );
    }else{
      return NoData();
    }

  }


  Widget _textField(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextField(
            readOnly: true,
            controller: serviceController,
            maxLength: 20,
            decoration: InputDecoration(
              labelText: "Service",
              labelStyle: TextStyle(color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
              hintStyle: TextStyle(color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
              counterText: "",
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.backgroundColor2,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.backgroundColor1,
                  width: 3.0,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: nohpController,
            maxLength: 20,
            focusNode: FocusNode(),
            decoration: InputDecoration(
              labelText: "No Handphone",
              labelStyle: TextStyle(color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
              hintStyle: TextStyle(color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
              counterText: "",
              border: UnderlineInputBorder(),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.backgroundColor2,
                  width: 1.5,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Constant.backgroundColor1,
                  width: 3.0,
                ),
              ),
              suffixIcon: new IconButton(
                  icon: Icon(Icons.contact_phone,color: Constant.backgroundColor1),
                  onPressed: () async{
                    Contact contact = await _contactPicker.selectContact();
                    setState(() {
                      _contact = contact;
                      var cek = _contact.phoneNumber.number.toString().replaceAll("+62 ", "0");
                      nohp = cek.replaceAll("-", "");
                      nohpController.text = cek.replaceAll("-", "");
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                    save();
                  }
              ),
            ),
            onFieldSubmitted: (x){
              setState(() {
                isLoading = true;
//                nohpController.text = x;
//                nohp=nohpController.text;
                print("############# IEU NAON $x ########################");
              });
              save();
//              nohpController.clear();
            },
          )
        ],
      ),
    );
  }

  Widget summaryCash() {
    return Positioned(
      top: 30,
      left: 16,
      right: 16,
      child: Container(
        width: 370,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(0),
        ),
        child: _textField(),
      ),
    );
  }
  Widget backgroundHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.4, 0.7, 0.9],
          colors: [
            Color(0xFFEF6C00),
            Color(0xFFF57C00),
            Color(0xFFFA7266),
            Color(0xFFFFB74D),
          ],
        ),
      ),
      height: 150,
      width: double.infinity,
//      decoration: BoxDecoration(
//        color: Colors.pinkAccent,
//        borderRadius: BorderRadius.only(
//          bottomLeft: Radius.circular(0),
//          bottomRight: Radius.circular(0),
//        ),
//      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('enter your mobile number or browse from internal contact',style:TextStyle(color: Colors.white,fontFamily: 'Rubik',fontWeight: FontWeight.bold),)
//            CustomHeading(title: 'enter your mobile number or browse from internal contact'),
          ],
        ),
      ),
    );
  }
  void _settingModalBottomSheet(context,var type,prov,voucher,price){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
        context: context,
        builder: (BuildContext bc){
          return Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
            ),
            padding: EdgeInsets.all(20.0),
            child: new Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: (){Navigator.of(context).pop();},
                        child: Icon(Icons.arrow_back_ios,color: Colors.white) // the arrow back icon
                      ),
                      SizedBox(width: 20.0),
                      Text('Detail Payment',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Rubik'))
                    ],
                  ),
                ),
                SizedBox(height: 50.0),
                structurDetailPayment('Type Product',type,Colors.grey),
                Divider(color: Constant.backgroundColor1),
                structurDetailPayment('Provider',prov,Colors.grey),
//                Divider(color: Constant.backgroundColor1),
//                structurDetailPayment('Voucher','Rp. '+ voucher,Constant.backgroundColor3),
                Divider(color: Constant.backgroundColor1),
                structurDetailPayment('Price',price,Constant.backgroundColor3),
                Divider(color: Constant.backgroundColor1),
                structurDetailPayment('Phone Number',nohpController.text,Colors.grey),
                Divider(color: Constant.backgroundColor1),
                structurDetailPayment('Payment','Saldo Akun',Colors.grey),
                Divider(color: Constant.backgroundColor1),
                Container(
                  padding: EdgeInsets.only(bottom:10.0,top:10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(price,style:TextStyle(color: Constant.backgroundColor3,fontWeight: FontWeight.bold,fontFamily: 'Rubik')),
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
                                setState(() {
                                  isLoading2=true;
//                                  Navigator.of(context).pop();
                                });
                                print('cek');
                                Navigator.of(context, rootNavigator: true).push(
                                  new CupertinoPageRoute(builder: (context) => CodeScreen(code:'123456',param: 'pin',check: (param){
                                    checkout();
                                  })),
                                );

//                                _settingModalBottomSheet(context);
                              },
                              child: Center(
                                child: Text("Buy Now", style: TextStyle(fontSize:16.0,color: Constant.backgroundColor3,fontFamily: 'Rubik',fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          );

        }
    );
  }
  _loading(){
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Material(
          child: InkWell(
            onTap: () {},
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
                        SkeletonFrame(width: 100,height: 16),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        SkeletonFrame(width: 150,height: 16),
                        Padding( padding: EdgeInsets.only(top: 5)),
                        SkeletonFrame(width: 200,height: 16),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                        child: SkeletonFrame(width: 60,height: 40),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget structurDetailPayment(String title,description,Color colorQ){
    return Container(
      padding: EdgeInsets.only(bottom:10.0,top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Rubik')),
          Text(description,style:TextStyle(color:colorQ,fontWeight: FontWeight.bold,fontFamily: 'Rubik'))
        ],
      ),
    );
  }

}

