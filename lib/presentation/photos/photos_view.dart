import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/controllers.dart';
import 'package:flutter_application_2/presentation/widgets/pageview_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PhotosView extends StatefulWidget {
  @override
  _PhotosViewState createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController = PageController();

  PhotoController _photoController = Get.find<PhotoController>();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(onListen);
  }

  onListen() {
    var maxExtent = _pageController.position.maxScrollExtent;

    if (_pageController.position.pixels == maxExtent)
      _photoController.getImageList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetX<PhotoController>(builder: (controller) {
        log(_photoController.imageList.value.length.toString());
        if (_photoController.imageList.value.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return PageViewWidget(
          itemCount: _photoController.imageList.value.length,
          pageController: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  progressIndicatorBuilder: (context, _, progress) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    );
                  },
                  imageUrl: _photoController.imageList.value[index].src.medium,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        _photoController.addTofavorite(index);
                      },
                      child: Icon(
                        _photoController.imageList.value[index].liked
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Text(
                        "Artist:${_photoController.imageList.value[index].photographer}",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    _pageController.removeListener(onListen);
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
