import 'package:Npay/BLOC/HISTORY/historyBloc.dart';
import 'package:Npay/HELPER/LOADMORE/loadmoreQ.dart';
import 'package:Npay/HELPER/apiService.dart';
import 'package:Npay/HELPER/constant.dart';
import 'package:Npay/HELPER/skeletonFrame.dart';
import 'package:Npay/MODEL/HISTORY/historyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
//import 'package:loadmore/loadmore.dart';

class IndexHistory extends StatefulWidget {
  @override
  _IndexHistoryState createState() => _IndexHistoryState();
}

class _IndexHistoryState extends State<IndexHistory> {
  final userRepository = ApiService();
  bool isLoading = false;
  String picture = '';
  Future getSession() async {
    picture = await userRepository.getPicture();
    print(picture);
  }
  String label  = 'Periode';
  String from   = '';
  String to     = '';
  int perpage=7;
  var total=0;
  var fromHari = DateFormat.d().format( DateTime.now());
  var toHari = DateFormat.d().format( DateTime.now());
  var fromBulan = DateFormat.M().format( DateTime.now());
  var toBulan = DateFormat.M().format( DateTime.now());
  var tahun = DateFormat.y().format( DateTime.now());
  final searchController = TextEditingController();
  final dateController = TextEditingController();
  final FocusNode searchFocus       = FocusNode();
  final FocusNode dateFocus       = FocusNode();
  Future<Null> _selectDate(BuildContext context) async{
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: new DateTime.now(),
        initialLastDate: (new DateTime.now()).add(new Duration(days: 1)),
        firstDate: new DateTime(2015),
        lastDate: new DateTime(2100)
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        isLoading=true;
      });
      print(isLoading);
      setState(() {
        isLoading=false;
        from  = "${picked[0].year}-${picked[0].month}-${picked[0].day}";
        to    = "${picked[1].year}-${picked[1].month}-${picked[1].day}";
        label = "${from} to ${to}";
        dateController.text = label;
      });
      print(isLoading);
    }
  }

  Future _search() async{
    if(dateController.text != '' && searchController.text != ''){
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, '$from','$to',searchController.text);
    }
    if(dateController.text != '' && searchController.text == ''){
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, '$from','$to','');
    }
    if(dateController.text == '' && searchController.text != ''){
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, '$tahun-${fromBulan}-${fromHari}','${tahun}-${toBulan}-${toHari}',searchController.text);
    }
    if(dateController.text == '' && searchController.text == ''){
      _selectDate(context);
    }
    return;
  }

  void load() {
    print("load $perpage");
    setState(() {
      perpage = perpage+=7;
    });
    DateTime today = new DateTime.now();
    DateTime fiftyDaysAgo = today.subtract(new Duration(days: 30));
    if(dateController.text != '' && searchController.text != ''){
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, '$from','$to',searchController.text);
    }else if(dateController.text != '' && searchController.text == ''){
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, '$from','$to','');
    }
    else{
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, fiftyDaysAgo,'${tahun}-${toBulan}-${toHari}','');
    }

    print(perpage);
  }
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
  }
  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    load();
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    getSession();
    DateTime today = new DateTime.now();
    DateTime fiftyDaysAgo = today.subtract(new Duration(days: 30));
    if(mounted){
      historyBloc.fetchHistoryList('mainTrx', 1, perpage, fiftyDaysAgo,'${tahun}-${toBulan}-${toHari}','');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[backgroundHeader(), summaryCash()],
          ),
          Flexible(
            child: StreamBuilder(
              stream: historyBloc.getResult,
              builder: (context,AsyncSnapshot<HistoryModel> snapshot){
                if(snapshot.hasData){
                  return buildContent(snapshot, context);
                }else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return _loading();
              },
            )
          )
        ],
      ),
    );
  }

  Widget buildContent(AsyncSnapshot<HistoryModel> snapshot, BuildContext context){
    return snapshot.data.result.data.length > 0 ?
    LoadMoreQ(
      whenEmptyLoad: true,
      delegate: DefaultLoadMoreDelegate(),
      textBuilder: DefaultLoadMoreTextBuilder.english,
      isFinish: snapshot.data.result.data.length < perpage,
      child: ListView.builder(
        itemCount: snapshot.data.result.data.length,
        itemBuilder: (context,index){
          return Container(
            padding:EdgeInsets.only(left:15.0,right: 15.0),
            child: cardDetail(
              Constant().rplcToSpace(snapshot.data.result.data[index].note.replaceAll(".", "")),
              snapshot.data.result.data[index].kdTrx,
              snapshot.data.result.data[index].trxOut,
              'out'
            ),
          );
        }
      ),
      onLoadMore: _loadMore,
    ) : Container(child:Center(child: Text(Constant.noMsgData,style:TextStyle(fontFamily:'Rubik'),)));
  }

  _loading(){
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context,index){
          return Card(
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                side: BorderSide(width: 1, color: Constant.backgroundColor1)
            ),
            margin: EdgeInsets.only(top: 5, left: 15, right: 15),
            elevation: 0,
            child: ListTile(
              leading: SkeletonFrame(width: 50,height: 50),
              title: SkeletonFrame(width: 50,height: 16),
              subtitle: SkeletonFrame(width: 50,height: 16),
              trailing:SkeletonFrame(width: 50,height: 16),
            ),
          );
        }
    );
  }

  Widget backgroundHeader() {
    return Container(
      height: 200,
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "HISTORY TRANSACTION",
              style: TextStyle(fontFamily:'Rubik',fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
            ),

          ],
        ),
      ),
    );
  }

  Widget summaryCash() {
    return Positioned(
      top: 90,
      left: 15,
      right: 15,
      child: Container(
        width: 370,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0,left:0.0,right:0.0),
          child: Row(
            children: <Widget>[
              new Flexible(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left:15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Periode',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),),
                      TextFormField(
                        style: TextStyle(fontSize:10.0,color: Colors.grey,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                        controller: dateController,
//                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: "this month....",
                          labelStyle: TextStyle(fontSize:10.0,color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                          hintStyle: TextStyle(fontSize:12.0,color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                          counterText: "",
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Constant.backgroundColor2,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Constant.backgroundColor1,
                              width: 1.0,
                            ),
                          ),
                        ),
                        focusNode: dateFocus,
                        onTap: (){
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _selectDate(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
              new Flexible(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left:15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Description',style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),),
                      TextFormField(
                        style: TextStyle(fontSize:10.0,color: Colors.grey,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                        controller: searchController,
//                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: "write something here",
                          labelStyle: TextStyle(fontSize:10,color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                          hintStyle: TextStyle(fontSize:8,color: Constant.backgroundColor1,fontWeight: FontWeight.bold,fontFamily: 'Rubik'),
                          counterText: "",
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Constant.backgroundColor2,
                              width: 0.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Constant.backgroundColor1,
                              width: 1.0,
                            ),
                          ),
                        ),
                        focusNode: searchFocus,
                        onFieldSubmitted: (term){
                          _search();
                        }

                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: IconButton(
                  color: Constant.backgroundColor2,
                  icon: Icon(Icons.search),
                  tooltip: 'Cari',
                  onPressed: () async{
                    _search();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDetail(title, description, price, type) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Constant.backgroundColor1),
//              color: Constant.backgroundColor1,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(18))
                ),
                child: Icon(Icons.history, color: Colors.lightBlue[900],),
                padding: EdgeInsets.all(5),
              ),

              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: TextStyle(fontFamily:'Rubik',fontSize: 14, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                    SizedBox(height:5.0,),
                    Text(price, style: TextStyle(fontFamily:'Rubik',fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(description, style: TextStyle(fontFamily:'Rubik',fontSize: 12, fontWeight: FontWeight.w700, color: Colors.orange),),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
//        Container(
//          padding:EdgeInsets.only(left:15.0,right:15.0),
////          child: Divider(),
//        )
      ],
    );
//    return Card(
////      borderOnForeground: true,
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.all(Radius.circular(10.0)),
//        side: BorderSide(width: 1, color: Constant.backgroundColor1)
//      ),
//      margin: EdgeInsets.only(top: 5, left: 15, right: 15),
//      elevation: 0,
//      child: ListTile(
//        leading: Icon(
//          type == 'out' ? Icons.history:Icons.history,
//          color: Constant.backgroundColor2,
//        ),
//        title: Text(
//          title,
//          style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.bold,fontSize: 12),
//        ),
//        subtitle: Text(description,style: TextStyle(fontFamily:'Rubik',fontWeight: FontWeight.bold,fontSize: 12)),
//        trailing: Text(
//          price,
//          style: TextStyle(fontFamily:'Rubik',color: type == 'out' ? Colors.redAccent:Colors.lightGreen,fontSize: 12),
//        ),
//      ),
//    );
  }

}
