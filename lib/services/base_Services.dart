import 'package:flutter_application_2/models/photos_model.dart';
import 'package:flutter_application_2/models/video_model.dart';

abstract class BaseServices {
  Future<PhotoModel> getPhotos(int page);
  Future<VideoModel> getVideos(int page);
}
