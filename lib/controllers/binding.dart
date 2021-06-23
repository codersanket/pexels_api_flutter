import 'package:flutter_application_2/services/service.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class GetBindings extends Bindings {
  Services _services = Services();
  @override
  void dependencies() {
    Get.put(Connectivity());
    Get.lazyPut<PhotoController>(() => PhotoController(services: _services));
    Get.lazyPut<VideoController>(() => VideoController(services: _services));
  }
}
