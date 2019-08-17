import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currenPage;

  final int size;

  PageIndicator(this.currenPage, this.size);

  Widget buildIndicator(bool isActive) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white30,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(1.0, 1.0),
                    spreadRadius: 1)
              ]),

        ),
      ),
    );
  }

  List<Widget> buildIndicatorList() {
    List<Widget> list = new List();

    for (int i = 0; i < size; i++) {
      list.add(buildIndicator(i == currenPage));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buildIndicatorList(),
    );
  }
}
