import 'package:flutter/material.dart';
import 'package:flutter_trip/widget/search_bar.dart';
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage({Key key, this.hideLeft, this.searchUrl, this.keyword, this.hint}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(),
          MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Expanded(
                flex: 1,
                  child: Text("search")
              ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    print(widget.hideLeft);
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x66000000), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: SearchBar(
              speakClick: _jumpToSpeak,
              defaultText: widget.keyword ?? "",
              hideLeft: widget.hideLeft,
              hint: widget.hint ?? "",
              leftButtonClick: (){
                Navigator.pop(context);
              },
              onChanged: _onTextChange,
            ),
          ),
        ),
      ],
    );
  }

  _jumpToSpeak() {
  print('jumptoSpeak=======');
  }

  _onTextChange(String s) {
    print(s+'TextChange=========');
  }
}
