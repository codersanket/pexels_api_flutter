import 'package:connectivity/connectivity.dart' as cs;
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class Connectivity extends GetxController {
  var _connnectivity = Rxn<cs.ConnectivityResult>();

  @override
  void onInit() {
    checkConnectivity();
    super.onInit();
  }

  checkConnectivity() async {
    print("Jds");
    cs.Connectivity().onConnectivityChanged.listen((event) {
      print(event);
      if (_connnectivity.value != event) {
        _connnectivity.value = event;
      }
      if (event == cs.ConnectivityResult.none) {
        Get.snackbar("Error", "Please turn on data connection or Wifi");
      }
    });
  }
}
