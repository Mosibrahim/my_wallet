import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class User extends ParseUser {
  User(super.username, super.password, super.emailAddress, this.amount,
      this.lastTransactionAmount);

  late int id;

  double amount = 0.0;
  double lastTransactionAmount = 0.0;
  DateTime lastTransactionDate = DateTime.now();

  Map<String, dynamic> toDBJson() {
    Map<String, dynamic> map = {};
    map["amount"] = amount;
    map["lastTransactionAmount"] = lastTransactionAmount;
    map["lastTransactionDate"] = lastTransactionDate.toIso8601String();
    return map;
  }

  static User fromDBJson(map) {
    User user=User(map["username"], map["password"],"", map["amount"], map["lastTransactionAmount"]);
    user.id=map["id"];
    user.lastTransactionDate=DateTime.tryParse(map["lastTransactionDate"])??DateTime.now();
    return user;
  }
}
