import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../rewidgets/video_widget.dart';
import 'dart:io';
import '../rewidgets/bottomNavBar.dart';

class VideoRecorder extends StatefulWidget {
  static String id = 'video_recorder';
  @override
  _VideoRecorderState createState() => _VideoRecorderState();
}

class _VideoRecorderState extends State<VideoRecorder> {
  File fileMedia;

  Future<File> pickCameraMedia(BuildContext context) async {
    // bool saved = await saveFile('recording.mp4');
    // ModalRoute is used to retrieve the info that has been passed down using Navigator
    //final MediaSource source = ModalRoute.of(context).settings.arguments;
    // ImagePicker is the plugin that we've integrated.
    // source is used to determine whether to select getImage or getVideo
    final getMedia = ImagePicker().getVideo;
    // Since this widget is for picking images from gallery
    final media = await getMedia(source: ImageSource.camera);

    final file = File(media.path);
    return file;
    // Navigator.of(context).pop(file);
  }

  Future capture(BuildContext context) async {
    setState(() {
      this.fileMedia = null;
    });
    // source is passed down to SourcePage() using a property called 'settings';
    // The info wrapped inside RouteSettings will then be received on the other side
    // final result = await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => SourcePage(),
    //     settings: RouteSettings(
    //       arguments: source,
    //     ),
    //   ),
    // );
    final result = await pickCameraMedia(context);
    if (result == null) {
      return;
    } else {
      setState(() {
        fileMedia = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavBar(
        id: VideoRecorder.id,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: 550,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  child: fileMedia == null
                      ? Icon(
                          Icons.photo,
                          size: 120,
                        )
                      : VideoWidget(fileMedia)),
              // ElevatedButton(
              //   onPressed: () {
              //     print('onPressed: Image Button');
              //     capture(MediaSource.image);
              //   },
              //   child: Text('Capture Image'),
              // ),
              ElevatedButton(
                onPressed: () {
                  print('onPressed: Video Button');
                  capture(context);
                },
                child: Text('Capture Video'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
