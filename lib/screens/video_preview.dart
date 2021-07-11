import 'package:flutter/material.dart';

class VideoPreview extends StatefulWidget {
  // const VideoPreview({Key? key}) : super(key: key);
  // Future uploadVideoToFirebase(BuildContext context, File fileMedia) async {
  //   // String fileName = basename(_imageFile.path);
  //   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
  //       'recorded_sessions/${FirebaseAuth.instance.currentUser.uid}/recorded_laughie.mp4');
  //   UploadTask uploadTask = firebaseStorageRef.putFile(fileMedia);
  //   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
  //   taskSnapshot.ref.getDownloadURL().then(
  //         (value) => print("Done: $value"),
  //       );
  // }

  // _saveFile(File fileMedia) async {
  //
  //   print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@save File called');
  //
  //   print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&${fileMedia.path}");
  //   // GallerySaver.saveVideo(fileMedia.path).then((bool success) {
  //   //   print(
  //   //       '++++++++++++++++++++++++++++++++++ video saved +++++++++++++++++++++');
  //   // });
  //

  //   // File savedFile = File('${directory.path}/recorded_session.mp4');

  //   final Reference storageRef = FirebaseStorage.instance.ref().child(
  //       'recorded_sessions/${FirebaseAuth.instance.currentUser.uid}/recorded_laughie.mp4');
  //   UploadTask uploadTask = storageRef.putFile(fileMedia);
  //   String downloadUrl;
  //   try {
  //     TaskSnapshot taskSnapshot = await uploadTask;
  //     downloadUrl = await taskSnapshot.ref.getDownloadURL();
  //     print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$downloadUrl");
  //
  //     //
  //
  //
  //     await storageRef.writeToFile(savedFile);
  //     print("================================================${savedFile}");
  //
  //
  //   } on FirebaseException catch (e) {
  //     // e.g, e.code == 'canceled'
  //     print("))))))))))))))))))))))))))))))))))))))))${e.message}");
  //   }
  // }
  //
  // _test() async {
  //   // File savedFile = File(directory.path + "/$fileName");
  //   // print('-------------------before------------------${savedFile.path}');
  //   // // savedFile = fileMedia;
  //   // print('-------------------after------------------${savedFile.path}');
  // }

  // Directory directory;
  // directory = await getExternalStorageDirectory();
  // print(
  //     "--------------------------------------------------------------${directory.path}");
  // String audioFileLoc = directory.path + "/recorded_session.mp3";
  // String newPath = "";
  // // final Dio dio = Dio();
  // List<String> folders = directory.path.split('/');
  // for (int x = 1; x < folders.length; x++) {
  //   if (folders[x] != "Android") {
  //     newPath += "/" + folders[x];
  //   } else {
  //     break;
  //   }
  // }
  // newPath = newPath + "/Laughie";
  // directory = Directory(newPath);
  // print("#########################${directory.path}");
  // // savedFile = File(directory.path + "/$fileName");

  // if (!await directory.exists()) {
  //   print(
  //       '666666666666666666666666666666666666666 inside directory does snot ');
  //   await directory.create(recursive: true);
  //   print('habababab ))))))))))))))))))))))))))))))))))))))))');
  // }
  // if (await directory.exists()) {
  //   print('666666666666666666666666666666666666666 inside directory ');
  //   savedFile = File(directory.path + "/$fileName");
  //
  //   // await dio.download(downloadUrl, savedFile.path);
  // }
  //
  // savedFile = await recordedVideo.copy(savedFile.path);
  //
  // print(
  //     "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!${savedFile.path}\n &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&${recordedVideo.path}");
  // print(
  //     '!!!!!!!!!!!!!!!!!!!!!!!!!!!!! recorded video is not null !!!!!!!!!!!!!!!!!!!');
  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
