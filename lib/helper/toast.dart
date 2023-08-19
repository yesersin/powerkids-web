import 'package:fluttertoast/fluttertoast.dart';

void toast({required String msg, ToastGravity? gravity = null}) {
  Fluttertoast.showToast(msg: msg, gravity: gravity ?? ToastGravity.CENTER);
}
