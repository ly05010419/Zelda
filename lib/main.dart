import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'PageIndicator.dart';

void main() => runApp(MyApp());

List<Model> imageList = [
  Model("assets/image_Link.jpg", "Link"),
  Model("assets/image_Zelda.jpg", "Zelda"),
  Model("assets/image_Mipha.jpg", "Mipha"),
  Model("assets/image_Daruk.jpg", "Daruk"),
  Model("assets/image_Revali.jpg", "Revali"),
  Model("assets/image_Urbosa.jpg", "Urbosa"),
];

class Model {
  String image;

  Model(this.image, this.name);

  String name;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int currentImage = 0;

  AnimationController animationController;

  Animation<double> nameAnimation;
  Animation<double> textAnimation;
  Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);
    animationController.addListener(() {
      setState(() {});
    });
    nameAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animationController, curve: Interval(0, 0.8)));

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.4, 1.0)));

    textAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController, curve: Interval(0.5, 0.8)));

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 4,
                      offset: Offset(4, 4),
                      blurRadius: 10)
                ],
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(80),
                    topLeft: Radius.circular(10)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(80),
                    topLeft: Radius.circular(10)),
                child: Container(
                  width: width,
                  height: width * 1.2,
                  child: Image.asset(
                    imageList[currentImage].image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
                right: 10,
                bottom: 20,
                child: Transform.translate(
                  offset: Offset(0.0, 20 - (20 * nameAnimation.value)),
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Text(
                      imageList[currentImage].name,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Montserrat-Black",
                          color: Colors.white),
                    ),
                  ),
                )),
            Positioned(
                right: 10,
                bottom: 5,
                child: Transform.translate(
                  offset: Offset(0.0, 20 - (20 * textAnimation.value)),
                  child: Opacity(
                    opacity: opacityAnimation.value,
                    child: Text(
                      "The Legend of Zelda Breath of the Wild",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Montserrat-Medium",
                          color: Colors.white),
                    ),
                  ),
                )),
            Positioned(
                top: 10,
                left: 140,
                child: PageIndicator(currentImage, imageList.length)),
            Positioned.fill(child: GestureDetector(
              onHorizontalDragEnd: (details) {
                animationController.reset();
                animationController.forward();
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  setState(() {
                    if (currentImage > 0) {
                      currentImage--;
                    } else {
                      currentImage = imageList.length - 1;
                    }
                  });
                } else {
                  setState(() {
                    if (currentImage < imageList.length - 1) {
                      currentImage++;
                    } else {
                      currentImage = 0;
                    }
                  });
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
