import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_2/helpers/constatnts.dart';
import 'package:flutter_application_2/models/photos_model.dart';
import 'package:flutter_application_2/models/video_model.dart';
import 'package:flutter_application_2/services/base_Services.dart';
import 'package:http/http.dart' as http;

class Services extends BaseServices {
  @override
  Future<PhotoModel> getPhotos(int page) async {
    print(page);
    http.Response response = await http.get(
        Uri.parse("$photourl?page=$page&per_page=5"),
        headers: {"Authorization": apiKey});
    log("response");

    return PhotoModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<VideoModel> getVideos(int page) async {
    http.Response response = await http.get(
        Uri.parse("$videoUrl?page=$page&per_page=5"),
        headers: {"Authorization": apiKey});

    return VideoModel.fromJson(jsonDecode(response.body));
  }
}
