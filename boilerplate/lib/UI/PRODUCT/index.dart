import 'package:Npay/BLOC/INFO/infoBloc.dart';
import 'package:Npay/BLOC/PPOB/PPOBPraBloc.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/HELPER/skeletonFrame.dart';
import 'package:Npay/MODEL/INFO/infoModel.dart';
import 'package:Npay/MODEL/PPOB/PPOBPraModel.dart';
import 'package:Npay/PROVIDER/INFO/infoProvider.dart';
import 'package:Npay/PROVIDER/PPOB/PPOBPraProvider.dart';
import 'package:Npay/UI/PRODUCT/formPPOBPra.dart';
import 'package:Npay/UI/notif.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int arrCurrentList = 8;
  String title = 'all';
  bool isLoading = false;

  final List<String> currentList = [];
  String image = '';
  Future showHide(param) async{
    var res = await InfoProvider().fetchInfo();
    if(param=='all'){
      setState(() {
        title = 'etc';
        isLoading = false;
        arrCurrentList = res.result.productType.length;
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

  Future load() async{
    if(mounted){
      infoBloc.fetchInfo();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Stack(
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
          child: StreamBuilder(
              stream: infoBloc.getResult,
              builder: (context, AsyncSnapshot<InfoModel> snapshot){
                if (snapshot.hasData) {
                  return vwPulsa(snapshot, context);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return _loading();
              }
          ),
        )
      ],
    );
  }

  Widget vwPulsa(AsyncSnapshot<InfoModel> snapshot, BuildContext context){
    return isLoading ? _loading() : GridView.builder(
      itemCount: arrCurrentList,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: ()=>{
            Navigator.of(context, rootNavigator: true).push(
              new CupertinoPageRoute(builder: (context) => FormPPOBPra()),
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
                        child: ClipOval(child: Image.network(snapshot.data.result.productType[index].image, height: ScreenUtil.getInstance().setHeight(50),),),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height/220),
                  Flexible(child: Text(snapshot.data.result.productType[index].title,textAlign: TextAlign.center,style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.bold, fontSize: ScreenUtil.getInstance().setHeight(20), color: Colors.black),),
                )
                ],
              )
          ),
        );
      },
    );

  }


  _loading(){
    return GridView.builder(
      itemCount: 8,
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

}
