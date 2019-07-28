import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/trip_dao.dart';
import 'package:flutter_trip/modal/TravelModal.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/widget/webview.dart';

import 'loading_widget.dart';

const PAGE_Size = 10;
const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031179411169828484&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';
class TabBarViewWidget extends StatefulWidget {
  final String travelUrl;
  final Map params;
  final String groupChannelCode;

  const TabBarViewWidget({Key key, this.travelUrl, this.params, this.groupChannelCode}) : super(key: key);
  @override
  _TabBarViewWidgetState createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget> with AutomaticKeepAliveClientMixin {


  TravelModel model;
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool loading = false;

  ScrollController _scrollController = new ScrollController();
  Future<Null> refresh(){
    print(widget.params.toString()+"widget.para=======");
     TripDao.fetch(widget.travelUrl ?? _TRAVEL_URL, widget.params, widget.groupChannelCode, pageIndex, PAGE_Size).then((TravelModel model){
       List<TravelItem> items = _filterItems(model.travelItems);
       setState(() {
         if (travelItems != null) {
           travelItems.addAll(items);
         } else {
           travelItems = items;
         }
         loading = false;
       });
     });
     return null;
  }

  List<TravelItem> _filterItems(List<TravelItem> resultList) {
    if (resultList == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    resultList.forEach((item) {
      if (item.article != null) {
        //移除article为空的模型
        filterItems.add(item);
      }
    });
    return filterItems;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    refresh();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadData(loadMore: true);
      }
    });
    // TODO: implement initState
    super.initState();
  }


  loadData({loadMore = false}){
    if(!loadMore){
     setState(() {
       pageIndex++;
     });
    }else{
      pageIndex = 0;
    }
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return LoadWidget(
      isLoading: loading,
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: RefreshIndicator(
          onRefresh: refresh,
          child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            itemCount: travelItems?.length ?? 0,
            crossAxisCount: 4,
            staggeredTileBuilder:  (int index) => new StaggeredTile.fit(2),
            itemBuilder: (BuildContext context, int index) => _TravelItem(
              index: index,
              item: travelItems[index],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//为true，在我切换tab之间可以不重新拉去数据，使用缓存
}

class _TravelItem  extends StatelessWidget{
  final int index;
  final TravelItem item;

  const _TravelItem({Key key, this.index, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  item.article.articleTitle,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _itemInfo(),
            ],
          ),
        ),
      ) ,
    onTap: (){
    if (item.article.urls != null && item.article.urls.length > 0) {
      NavigatorUtil.push(
        context,
        WebView(url: item.article.urls[0].h5Url,  title: '详情',
        ),
      );
    }
    },);
  }

  _itemImage() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
          left: 8,
          bottom: 8,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black54,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(
                    Icons.location_on,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(
                    item.article.pois == null || item.article.pois.length == 0
                        ? '未知'
                        : item.article.pois[0]?.poiName ?? '未知',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _itemInfo() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  item.article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }


}
