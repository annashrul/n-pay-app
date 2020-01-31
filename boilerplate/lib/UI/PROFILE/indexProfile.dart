import 'package:flutter/material.dart';

class IndexProfile extends StatefulWidget {
  @override
  _IndexProfileState createState() => _IndexProfileState();
}

class _IndexProfileState extends State<IndexProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ProfileContainer(),
              SizedBox(height: 21.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CircularButton(
                    title: 'Wallet',
                    icon: Icons.account_balance_wallet,
                    onTap: () {},
                  ),
                  CircularButton(
                    title: 'Delivery',
                    icon: Icons.send,
                    onTap: () {},
                  ),
                  CircularButton(
                    number: 11,
                    title: 'Message',
                    icon: Icons.message,
                    onTap: () {},
                  ),
                  CircularButton(
                    title: 'Service',
                    icon: Icons.attach_money,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 21.0),
              Flexible(child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 9.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 3.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                            color: Color(0xff8d7bef),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.location_on,color: Colors.white),
                      ),
                      title: Text('Address'),
                      subtitle: Text('Ensure your harvesting address'),
                      trailing: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 9.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 3.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                            color: Color(0xfff468b9),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.lock,color: Colors.white),
                      ),
                      title: Text('Privacy'),
                      subtitle: Text('System permission change'),
                      trailing: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 9.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 3.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                            color: Color(0xffffca59),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.settings,color: Colors.white),
                      ),
                      title: Text('General'),
                      subtitle: Text('Basic functional settings'),
                      trailing: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 9.0),
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[200],
                          blurRadius: 3.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                        padding: EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                            color: Color(0xff5bd2d4),
                            shape: BoxShape.circle
                        ),
                        child: Icon(Icons.notifications,color: Colors.white),
                      ),
                      title: Text('notification'),
                      subtitle: Text('Take over the news in time'),
                      trailing: IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final int number;
  final GestureTapCallback onTap;
  const CircularButton(
      {Key key, this.title, this.icon, this.number, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          LimitedBox(
            maxHeight: 50,
            maxWidth: 50,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 5,
                  right: 5,
                  bottom: 3,
                  left: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.black54),
                  ),
                ),
                number != null
                    ? Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    height: 21,
                    width: 21,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: FittedBox(
                      child: Text(
                        number > 9 ? "+9" : "$number",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle,
          )
        ],
      ),
    );
  }
}


class ProfileContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200],
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(2.3),
                decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: CircleAvatar(
                  maxRadius: 35.0,
                  backgroundImage: NetworkImage(
                    'https://img.icons8.com/plasticine/2x/person-male.png',
                  ),
                ),
              ),
              SizedBox(width: 21),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Collect',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .apply(fontWeightDelta: 2, color: Colors.white),
                        ),
                        SizedBox(width: 15.0),
                        GestureDetector(
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Afternoon',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle
                          .apply(color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "849",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(color: Colors.white),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'Track',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "51",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(color: Colors.white),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'Coupons',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "291",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(color: Colors.white),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'Track',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    "39",
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .apply(color: Colors.white),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    'Coupons',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}