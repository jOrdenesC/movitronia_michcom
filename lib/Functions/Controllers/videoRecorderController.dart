import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class VideoController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  GifController controller3;
  List<double> gifframes = [0, 14, 45, 33];
  List<Duration> gifduration = [
    Duration(milliseconds: 200),
    Duration(milliseconds: 850),
    Duration(milliseconds: 2200),
    Duration(milliseconds: 2230)
  ];
  var loading = false.obs;
  var gifName2 = 'Assets/images/C1.gif'.obs;
  var index = 0.obs;
  String assetFolder = 'Assets/images/';
  List<String> giflist = ['0.gif', 'C1.gif', 'C2.gif', 'C3.gif'];
  //Changed Value is already altering data inside the video so we have some kind of degree of controll over the gif
  changeValue(int indexValue) {
    gifName2.value = assetFolder + giflist[indexValue];
    index.value = indexValue;
  }

  //Observe changes done to variable and return different controller??
  //Get Controller over here and send it to another class so we can easily change it as an observable??
  recordMovie() async {
    final file = await ImagePicker().getVideo(source: ImageSource.camera);
    loading.value = true;
    File selected = File(file.path);
    await VideoCompress.setLogLevel(0);
    final info = await VideoCompress.compressVideo(
      file.path,
      duration: 15,
      quality: VideoQuality.LowQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    if (info != null) {
      //Should send video location on back
      Get.back();
      loading.value = false;
      //If Method is Successfull save file location to a variable and change another one that is observable and change back to screen
      log(info.path);
      /*setState(() {
                          log(info.path);
                          _controllerVideo =
                              VideoPlayerController.file(selected);

                          log(_controllerVideo.value.initialized.toString());

                          location = true;
                        });*/
      /*_controllerVideo = VideoPlayerController.file(selected)
                          ..initialize().then((_) {
                            _controllerVideo.play();
                            setState(() {});
                          });*/
    }
  }
}
