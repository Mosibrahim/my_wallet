import 'package:flutter/material.dart';
import 'package:my_wallet/model/user.dart';
import 'package:my_wallet/util/constants.dart';
import 'package:my_wallet/util/users_cubit/view.dart';

class MyHomePage extends StatelessWidget {
  User user;

  MyHomePage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    String gratingMessage =
        DateTime.now().hour >= 12 ? "Good Evening" : "Good Morning";
    return Scaffold(
      appBar: AppBar(),
      body: CustomPaint(
        painter: BluePainter(),
        child: Container(
          width: getWidth(context),
          height: getHeight(context),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                        minRadius: 35,
                        backgroundColor: Colors.yellow,
                        child: Image.asset(
                          'assets/user_avatar.png',
                          width: 50.0,
                          height: 50.0,
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        gratingMessage,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        user.username!,
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                      height: getWidth(context) * .35,
                      child: Column(
                        children: [
                          Container(
                            width: getWidth(context) * 0.4,
                            height: getHeight(context) * 0.06,
                            color: Colors.black,
                            child: Center(
                                child: Text(
                              "Wallet",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                          ),
                          Icon(
                            Icons.account_balance_wallet,
                            size: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Text("EGP"),
                              ),
                              Text(
                                "${user.amount.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 35),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Last updated ${user.lastTransactionDate.day}/${user.lastTransactionDate.month}"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      height: getHeight(context) * .35,
                      child: Column(
                        children: [
                          Container(
                            width: getWidth(context) * 0.4,
                            height: getHeight(context) * 0.06,
                            color: Colors.grey,
                            child: Center(
                                child: Text(
                              "Last Transaction",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )),
                          ),
                          Icon(
                            Icons.credit_card,
                            size: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RotatedBox(
                                quarterTurns: 1,
                                child: Text("EGP"),
                              ),
                              Text(
                                "${user.lastTransactionAmount.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 35),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "Last updated ${user.lastTransactionDate.day}/${user.lastTransactionDate.month}"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.indigo,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              )),
                          child: Text(
                            "Test",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed: () async {}),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Users",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                ],
              ),
              UsersCubitPage(),
            ],
          ),
        ),
      ),
    );
  }
}

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(width, height * 0.55);

    // paint a curve from current position to middle of the screen
    ovalPath.relativeQuadraticBezierTo(
        width, height * 0.60, width * 0.70, height * 0.40);
    ovalPath.relativeQuadraticBezierTo(
        width * 0.70, height * 0.38, width * 0.60, height * 0.25);
    ovalPath.relativeQuadraticBezierTo(
        width * 0.70, height * 0.40, width * 0.45, height * 0.30);
    ovalPath.relativeQuadraticBezierTo(
        0, height * 0.60, width * 0.40, height * 0.20);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height * 0.20);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Colors.orange.shade200;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
