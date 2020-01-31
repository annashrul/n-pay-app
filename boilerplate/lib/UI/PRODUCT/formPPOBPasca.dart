import 'package:Npay/HELPER/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormPPOBPasca extends StatefulWidget {
  final String type;
  FormPPOBPasca({this.type});
  @override
  _FormPPOBPascaState createState() => _FormPPOBPascaState();
}

class _FormPPOBPascaState extends State<FormPPOBPasca> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var nohpController  = TextEditingController();
  final FocusNode nohpFocus = FocusNode();
  var idPelangganController  = TextEditingController();
  final FocusNode idPelangganFocus = FocusNode();
  bool isLoading = false;
  Future browseContact() async{
    final cek = await Constant().browseContact(context, nohpController.text);
    print("######################## $cek ###########################");
    nohpController.text = cek;
  }
  Future checkProduct() async{
    setState(() {
      isLoading=false;
    });

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

        ],
      ),
    );
  }

  Widget _textField(){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'No Handphone',
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
              suffixIcon: IconButton(
                icon: Icon(Icons.contact_phone,color: Constant.backgroundColor1),
                onPressed: () async{
                  browseContact();
                }
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ], // Only nu
            style: TextStyle(color: Constant.backgroundColor1),
            obscureText: false,
            autofocus: false,
            controller: nohpController,
            focusNode: nohpFocus,
            onFieldSubmitted: (term){
              Constant().fieldFocusChange(context, nohpFocus, idPelangganFocus);
            },
            textInputAction: TextInputAction.next,
          ),

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

}
