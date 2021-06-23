import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/controllers.dart';
import 'package:flutter_application_2/presentation/videos/widgets/video_player.dart';

import 'package:flutter_application_2/presentation/widgets/pageview_widget.dart';
import 'package:get/get.dart';

import 'package:cached_network_image/cached_network_image.dart';

class VideoView extends StatefulWidget {
  VideoView({Key? key}) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView>
    with AutomaticKeepAliveClientMixin {
  VideoController _videoController = Get.find<VideoController>();

  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent) {
        _videoController.getVideos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetX<VideoController>(
      builder: (_) {
        if (_videoController.videoList.value.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return PageViewWidget(
            pageController: _pageController,
            itemCount: _videoController.videoList.value.length,
            itemBuilder: (context, index) {
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
                    imageUrl: _videoController
                        .videoList.value[index].videoPictures[3].picture,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Column(
                          children: [
                            Text(
                              "Artist:${_videoController.videoList.value[index].user.name}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            )
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoApp(
                                    url: _videoController.videoList.value[index]
                                        .videoFiles[0].link,
                                  )));
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.play_circle,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              );
            });
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
