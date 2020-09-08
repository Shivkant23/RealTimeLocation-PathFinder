import 'dart:math';
import 'package:SalesTrendz/model/organisationItem.dart';
import 'package:flutter/material.dart';
import 'package:SalesTrendz/widget/WidgetStandarts.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedChip = 1;
  List<Organisation> listOfOrgItems = [];
  var Obj1 = Organisation(avatarString: "Fa", stageName: "Demo", orgName: "Hindustan Feeds, India", owner: "Farah Baria", date: "2 days ago");
  var Obj2 = Organisation(avatarString: "Ab", stageName: "Demo", orgName: "Wali Inc, Iran", owner: "Abbas Rao Chawla", date: "Feb 20, 2020");
  var Obj3 = Organisation(avatarString: "Na", stageName: "Demo", orgName: "Murty and Anthony Co., India", owner: "Nandini Chad", date: "Feb 20, 2020");
  var Obj4 = Organisation(avatarString: "Ka", stageName: "Demo", orgName: "Pandey Ltd, India", owner: "Kajol Sibal", date: "Feb 20, 2020");

  @override
  void initState() {
    listOfOrgItems.add(Obj1);
    listOfOrgItems.add(Obj2);
    listOfOrgItems.add(Obj3);
    listOfOrgItems.add(Obj4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: dashboardBody(),
      bottomNavigationBar: WidgetStandarts.getBottomBar(true, context, 1),
      floatingActionButton: WidgetStandarts.getFloatingButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  _appBar(){
    return AppBar(
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          "Connects",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 25,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: Colors.black54,),
          onPressed: (){
              
          },
        ),
        IconButton(
          icon: Icon(Icons.add_circle, color: Colors.red),
          onPressed: (){
              
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.black54),
          onPressed: (){
              
          },
        ),
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, //remove this when you add image.
            ),
            child: CircleAvatar(
              child: Image.asset('assets/SalesTrendz-Logo.png'),
            ),
          ),
        )

      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 80,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                  GestureDetector(
                    child: getChips(1, 'Leads', Colors.black, Colors.white),
                    onTap: (){
                      setState(() {
                        selectedChip = 1;
                      });
                    },
                  ),
                  GestureDetector(
                    child: getChips(2, 'Distributors', Colors.black, Colors.white),
                    onTap: (){
                      setState(() {
                        selectedChip = 2;
                      });
                    },
                  ),
                  GestureDetector(
                    child: getChips(3, 'Retailers', Colors.black, Colors.white),
                    onTap: (){
                      setState(() {
                        selectedChip = 3;
                      });
                    },
                  ),
                  GestureDetector(
                    child: getChips(4, 'Retailers', Colors.black, Colors.white),
                    onTap: (){
                      setState(() {
                        selectedChip = 4;
                      });
                    },
                  ),
                ],),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.filter_b_and_w, color: Colors.black54),
                            Text("Filter", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
                                alignment: Alignment.center,
                                child: Text('4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.sort_by_alpha, color: Colors.black54),
                            Text("Sort", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                          ],
                        ),
                        onTap: (){},
                      ),
                      
                    ],
                  ),
                  Row(children: <Widget>[
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search, color: Colors.black54),
                          Text("Search", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                        ],
                      ),
                      onTap: (){},
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.more_horiz, color: Colors.black),
                        ],
                      ),
                      onTap: (){},
                    ),
                  ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getChips(int chipNum, String label, Color bColor, Color textColor){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        padding: EdgeInsets.all(10),
        label: Text(label, style: TextStyle(
          color: selectedChip == chipNum ? textColor : bColor, 
          fontWeight: FontWeight.bold),),
        backgroundColor: selectedChip == chipNum ? bColor : textColor,
      ),
    );
  }

  Widget dashboardBody(){
    return Container(
      // padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Select Organisation:",
                              style: TextStyle(color: Colors.black38),

                            ),
                            TextSpan(
                              text: "   Mumbai +1",
                              style: TextStyle(color: Colors.black),

                            ),
                          ]
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Select Route:",
                              style: TextStyle(color: Colors.black38),

                            ),
                            TextSpan(
                              text: "   Andheri +3",
                              style: TextStyle(color: Colors.black),

                            ),
                          ]
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_right)
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listOfOrgItems.length,
              itemBuilder: (BuildContext context, int index){
                return getListItem(listOfOrgItems[index]);
              }
            ),
          )
        ],
      ),      
    );
  }

  Widget getListItem(Organisation organisationItem){

    Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return Container(
      padding: EdgeInsets.all(10),
      child:Row(
        children: <Widget>[
          Container(
            child: CircleAvatar(
              child: Text(organisationItem.getAvatarString, style: TextStyle(color: Colors.white),),
              backgroundColor: color,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: color,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 0.2)
                )
              ],
              color: Colors.amber
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: "Stage:", style: TextStyle(color: Colors.black38)),
                            TextSpan(text: "  ${organisationItem.getStageName}",style: TextStyle(color: Colors.black),),
                          ]
                        ),
                      ),
                      Flexible(child: Text(organisationItem.getDate, style: TextStyle(color: Colors.black38), textAlign: TextAlign.end,)),
                    ],
                  ),
                  Text(organisationItem.getOrgName, style: TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis,),
                  Text(organisationItem.getOwner, style: TextStyle(fontSize: 12, color: Colors.black38),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
