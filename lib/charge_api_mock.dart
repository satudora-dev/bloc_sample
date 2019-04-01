import 'dart:async';

class ChargeAPIMock {
  Future<int> post(int chargeMoney) async {
    print("post");
    await Future.delayed(new Duration(seconds: 3));
    return chargeMoney;
  }
}
