import 'package:flutter/material.dart';
import 'package:my_wallet/model/user.dart';
import 'package:my_wallet/util/constants.dart';

class UserCardScreen extends StatelessWidget {
  User user;

  UserCardScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: getHeight(context)*.3,
        width: getWidth(context)*.35,
        child: Stack(
          children: [
            Card(
              elevation: 10,
              child: Container(
                height: getHeight(context)*.3,
                child: Column(
                  children: [
                    Container(
                      width: getWidth(context) * 0.5,
                      height: getHeight(context) * 0.1,
                      color: Colors.yellow,
                      child:Column(children: [
                        SizedBox(height: 20,),
                        Text("${user.username}",style: TextStyle(color: Colors.white),),
                        Text("total spending",style: TextStyle(color: Colors.white),),
                      ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Text("EGP"),
                          ),
                          Text("${user.amount.toStringAsFixed(2)}",style: TextStyle(fontSize: 20),),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Last Spend on${user.lastTransactionDate.day}/${user.lastTransactionDate.month}"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: -30,
                left: getWidth(context)*.12,
                child: Center(
                  child: CircleAvatar(
                      minRadius: 30,
                      backgroundColor: Colors.orange.shade300,
                      child: Image.asset(
                        'assets/user_avatar.png',
                        width: 40.0,
                        height: 40.0,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
