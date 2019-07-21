import 'package:flutter/material.dart';

class LoadWidget extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final bool isCover;

  const LoadWidget({Key key, @required this.isLoading, this.isCover=false, @required  this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return !isCover
        ? !isLoading ? child : _circleView()
        : Stack(
            children: <Widget>[
              child,
              Positioned(
                child: isLoading ? _circleView() : null,
              ),
            ],
          );
  }

  _circleView() {
    return Container(
      decoration: BoxDecoration(color: Color(0xfff2f2f2)),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
