import 'package:flutter/material.dart';
import 'package:flutter_application_2/presentation/photos/photos_view.dart';
import 'package:flutter_application_2/presentation/videos/video_view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: TabBarView(
          children: [PhotosView(), VideoView()], controller: _tabController),
      bottomSheet: Container(
        height: kToolbarHeight,
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.photo),
              text: "Photos",
            ),
            Tab(
              icon: Icon(Icons.video_call),
              text: "Videos",
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
