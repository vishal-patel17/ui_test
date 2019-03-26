import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:youtube_player/youtube_player.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static File _image;

  Future _getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _currentPage == 0
          ? FloatingActionButton(
              onPressed: () => _getImage(),
              child: Icon(Icons.add),
            )
          : SizedBox(),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.add_a_photo, title: "Image"),
          TabData(iconData: Icons.video_call, title: "Video"),
        ],
        onTabChangedListener: (position) {
          setState(() {
            _currentPage = position;
          });
        },
      ),
      body: _currentPage == 0
          ? _image != null
              ? Center(
                  child: PhotoView(
                    backgroundDecoration: BoxDecoration(color: Colors.white),
                    imageProvider: FileImage(_image),
                  ),
                )
              : Center(
                  child: Text('No image selected...'),
                )
          : Center(
              child: YoutubePlayer(
                context: context,
                source: "https://www.youtube.com/watch?v=TVq3NpCsnIA",
                quality: YoutubeQuality.HD,
                autoPlay: false,
                showThumbnail: true,
              ),
            ),
    );
  }
}
