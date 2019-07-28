import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/trip_tab_dao.dart';
import 'package:flutter_trip/modal/TravelModal.dart';
import 'package:flutter_trip/modal/TravelTabModel.dart';
import 'package:flutter_trip/widget/tarBar_view_widget.dart';
class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{
  TabController _controller;
  List<TravelTab> tabs = [];
  TravelTabModel travelTabModel;

  @override
  void initState() {
    _controller = new TabController(length: 0, vsync: this);
    TripTabDao.fetch().then((TravelTabModel model){
      setState(() {
        _controller = new TabController(length: model?.tabs?.length ?? 0, vsync: this);
        tabs = model.tabs;
        travelTabModel = model;
      });
    }).catchError((e) {
      print(e);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30),
            color: Colors.white,
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.only(bottom: 10),
                    borderSide: BorderSide(width: 3, color: Color(0xff2fcfbb),)
                ),
                tabs: tabs.map<Tab>((TravelTab tab){
                  return Tab(
                    text: tab.labelName,
                  );
                }).toList() ?? null
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: _controller,
              children: tabs.map((TravelTab tab){
                return TabBarViewWidget(
                    travelUrl: travelTabModel?.url??null,
                    params: travelTabModel?.params??null,
                    groupChannelCode: tab?.groupChannelCode?? ""
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
