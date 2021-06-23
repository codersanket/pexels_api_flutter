import 'dart:developer';

import 'package:flutter_application_2/models/photos_model.dart';
import 'package:flutter_application_2/services/service.dart';
import 'package:get/get.dart';

class PhotoController extends GetxController {
  Services _services;
  PhotoController({required Services services})
      : _services = services,
        super();
  var imageList = Rx<List<Photo>>([]);
  PhotoModel? photoModel;

  @override
  onInit() {
    getImageList();
    super.onInit();
  }

  getImageList() async {
    log("Getting Images");

    photoModel = await _services
        .getPhotos(photoModel != null ? photoModel!.page + 1 : 1);
    imageList.value = [...imageList.value, ...?photoModel?.photos];
  }

  addTofavorite(int index) {
    imageList.update((val) {
      val![index].liked = !val[index].liked;
    });
    if (imageList.value[index].liked == true) {
      Get.showSnackbar(
        GetBar(
          title: "Added to Favorite",
          message: "Sucefully added to Favorites",
          duration: Duration(milliseconds: 1000),
        ),
      );
    }
  }
}
