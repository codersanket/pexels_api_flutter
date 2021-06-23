import 'dart:developer';

import 'package:flutter_application_2/models/video_model.dart';
import 'package:flutter_application_2/services/service.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  Services _services;
  VideoController({required Services services})
      : _services = services,
        super();
  var videoList = Rx<List<Video>>([]);
  VideoModel? videoModel;

  @override
  onInit() {
    getVideos();
    super.onInit();
  }

  getVideos() async {
    log("Getting Videos");

    videoModel = await _services
        .getVideos(videoModel != null ? videoModel!.page + 1 : 1);
    videoList.value = [...videoList.value, ...?videoModel?.videos];
  }
}
