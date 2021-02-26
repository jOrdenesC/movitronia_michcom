import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/QuestionData.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Models/TipsData.dart';
import 'package:movitronia/Database/Repository/QuestionDataRepository/QuestionDataRepository.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Database/Repository/TipsDataRepository/TipsDataRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:movitronia/Database/Models/ResponseModels/ResultClassModel.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:video_player/video_player.dart';

class TestinApi extends StatefulWidget {
  @override
  _TestinApiState createState() => _TestinApiState();
}

class _TestinApiState extends State<TestinApi> {
  ExcerciseDataRepository _excerciseRepository = GetIt.I.get();
  ClassDataRepository _classRepository = GetIt.I.get();
  QuestionDataRepository _questionDataRepository = GetIt.I.get();
  TipsDataRepository _tipsDataRepository = GetIt.I.get();

  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();

  String videoName = "video2.mp4";
  String audioName;
  String downloadMessage = 'Initializing...';
  String theme = "";
  String selected = "You have selected";
  bool _isDownloading = false;
  double _percentage = 0;

  bool _isplaying = false;
  bool videoActive = false;
  bool showVideo = false;
  bool videoInitialized = false;
  String url = "";
// file name that you desire to keep
//Videos
  var dir;
  int simpleindex = 0;
  //VideoPlayerController videoPlayerController;

  VlcPlayerController _videoPlayerController;
  @override
  void initState() {
    getDirectory();
    initializePlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Main View
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: videoActive == false ? audioView() : videoView()),
    );
  }

  Widget videoView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FloatingActionButton.extended(
            heroTag: "btn1",
            onPressed: () {
              setState(() {
                videoActive = false;
              });
            },
            label: Text("Go back")),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
                heroTag: "btn2",
                onPressed: () {
                  videoName = "video1.mp4";
                  setState(() {
                    _isDownloading = !_isDownloading;
                  });
                  download(video: 0);
                  flushbarNotification(
                      "Downloading", "You are downloading a video");
                },
                label: Text("Download video 1")),
            FloatingActionButton.extended(
                heroTag: "btn3",
                onPressed: () {
                  videoName = "video2.mp4";
                  setState(() {
                    _isDownloading = !_isDownloading;
                  });
                  download(video: 1);
                  flushbarNotification(
                      "Downloading", "You are downloading a video");
                },
                label: Text("Download video 2")),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          downloadMessage ?? '',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(value: _percentage),
        ),
        SizedBox(
          height: 30,
        ),
        FloatingActionButton.extended(
            heroTag: "btn4",
            onPressed: () {
              initializePlayer();
            },
            label: Text("Initialize Video")),
        SizedBox(
          height: 20,
        ),
        FloatingActionButton.extended(
            heroTag: "btn5",
            onPressed: () {
              if (showVideo == true) {
                if (videoInitialized == true) {
                  print("paused");
                  //ideoPlayerController1.pause();
                }
              } else {
                if (videoInitialized == false) {
                } else {
                  // videoPlayerController1.play();
                }
              }
              setState(() {
                showVideo = !showVideo;
              });
            },
            label: Text("Play Video")),
        showVideo == true
            ? Column(
                children: [
                  Center(
                    child: Container(
                      child: VlcPlayer(
                        controller: _videoPlayerController,
                        aspectRatio: 4 / 3,
                        placeholder: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton.extended(
                          heroTag: "btn6",
                          onPressed: () {
                            videoName = "C3.mp4";
                            setState(() {
                              updateController();
                            });
                            //updateController();
                          },
                          label: Text("Select Video 1")),
                      FloatingActionButton.extended(
                          heroTag: "btn7",
                          onPressed: () {
                            videoName = "C4.mp4";
                            setState(() {
                              updateController();
                            });
                            //updateController();
                          },
                          label: Text("Select Video 2")),
                    ],
                  )
                ],
              )
            : SizedBox()
      ],
    );
  }

  Widget audioView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                  heroTag: "btn8",
                  onPressed: () {
                    theme = "Fierce Battle Theme";
                    audioName = "Fierce.mp3";
                    flushbarNotification(
                        "Url Changed", "$selected Fierce Battle Theme");
                    url =
                        "https://fi.zophar.net/soundfiles/nintendo-snes-spc/final-fantasy-v/119%20The%20Fierce%20Battle.mp3";
                  },
                  label: Text("Fierce")),
              FloatingActionButton.extended(
                  heroTag: "btn9",
                  onPressed: () {
                    flushbarNotification(
                        "Url Changed", "$selected Fanfare Theme");
                    theme = "Fanfare Theme";
                    audioName = "Fanfare.mp3";
                    "https://fi.zophar.net/soundfiles/nintendo-snes-spc/final-fantasy-v/108%20Victory's%20Fanfare.mp3";
                  },
                  label: Text("Fanfare")),
              FloatingActionButton.extended(
                  heroTag: "btn10",
                  onPressed: () {
                    theme = "Harvest Theme";
                    audioName = "Harvest.mp3";
                    flushbarNotification(
                        "Url Changed", "$selected Harvest Theme");
                    url =
                        "https://fi.zophar.net/soundfiles/nintendo-snes-spc/final-fantasy-v/116%20Harvest.mp3";
                  },
                  label: Text("Harvest")),
            ],
          ),
        ),
        FloatingActionButton.extended(
          heroTag: "btn11",
          onPressed: () async {
            if (url == "") {
              Flushbar(
                title: "Error",
                message: "Select one of the audios above to start downloading",
                duration: Duration(seconds: 3),
              )..show(context);
            } else {
              setState(() {
                _isDownloading = !_isDownloading;
              });
              flushbarNotification(
                  "Downloading", "You are now downloading $theme");
              download();
            }
          },
          label: Text('Download'),
          icon: Icon(Icons.file_download),
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          downloadMessage ?? '',
          style: Theme.of(context).textTheme.headline5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: LinearProgressIndicator(value: _percentage),
        ),
        FloatingActionButton.extended(
          heroTag: "btn12",
          onPressed: () async {
            setState(() {
              playAudio('${dir.path}/$audioName');
            });
          },
          label: _isplaying == false ? Text("Play Audio") : Text("Stop Audio"),
          icon: Icon(Icons.audiotrack),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
            heroTag: "btn13",
            onPressed: () {
              setState(() {
                videoActive = true;
              });
            },
            label: Text("Video")),
        FloatingActionButton.extended(
            heroTag: "btn14",
            onPressed: () {
              //getHttp();
              //getobjectTest();
              //downloadAllVideos();
              goToSessionPage("60324793ec2b1b36dc72b97d");
            },
            label: Text("API TEST"))
      ],
    );
  }

  getobjectTest() async {
    final result = await _classRepository.getAllClassLevel();
    print(result[0].classID);
  }

  getDirectory() async {
    dir = await getApplicationDocumentsDirectory();
    print(dir.path);
  }

  updateController() async {
    _videoPlayerController
        .setMediaFromFile(File('${dir.path}/videos/$videoName'));

    //_videoPlayerController.dispose();

    //await _videoPlayerController.initialize();
    setState(() {});
  }

  initializePlayer() async {
    print("initializing player");
    var dir = await getApplicationDocumentsDirectory();
    //String dir = "/data/user/0/com.michcom.movitronia/app_flutter";
    _videoPlayerController = VlcPlayerController.file(
      File('${dir.path}/videos/$videoName'),
      hwAcc: HwAcc.FULL,
      autoPlay: true,
      autoInitialize: true,
      onInit: () async {
        await _videoPlayerController.startRendererScanning();
      },
      options: VlcPlayerOptions(extras: ['--input-repeat=65535']),
    );
    _videoPlayerController.addListener(listener);
    /*
    videoPlayerController =
        VideoPlayerController.network('${dir.path}/$videoName');
    print('${dir.path}/$videoName');

    videoPlayerController
      ..initialize().then((value) => null)
      ..setLooping(true)
      ..play();*/

    setState(() {
      videoInitialized = true;
    });
  }

  void listener() async {
    if (!mounted) return;
    //
    if (_videoPlayerController.value.isInitialized) {
      //print("Value initialized");
    }

    /* if (_videoPlayerController.isReadyToInitialize) {
      //print("Ready to initialize");
      // await _videoPlayerController.initialize();
    }*/
  }

  download({int video}) async {
    Dio dio = Dio();
    if (videoActive != true) {
      print("Downloading Audio");
      dio.download(url, '${dir.path}/$audioName',
          onReceiveProgress: (actualbytes, totalbytes) {
        var percentage = actualbytes / totalbytes * 100;
        _percentage = percentage / 100;
        setState(() {
          downloadMessage = 'Downloading... ${percentage.floor()}%';
        });
      });
    } else {
      print("Downloading Video");
      String urlvideo =
          "https://bucketparaaprender.s3.sa-east-1.amazonaws.com/output_file.mp4?AWSAccessKeyId=AKIAWJAHU5HUSFG3ZS7R&Expires=1613925476&Signature=awd8WY0hHgH4VWRJFIKrKKMb%2Bkw%3D";
      String urlvideo2 =
          "https://movitronia-exercises.s3.sa-east-1.amazonaws.com/T%20-%20V%20DE%20TOBILLOS.mp4?AWSAccessKeyId=AKIAWJAHU5HUSFG3ZS7R&Expires=1614117692&Signature=a46oUVZIwH5b6SfNNKvDRT6fcnw%3D";
      dio.download(
          video == 0 ? urlvideo : urlvideo2, '${dir.path}/videos/$videoName',
          onReceiveProgress: (actualbytes, totalbytes) {
        var percentage = actualbytes / totalbytes * 100;
        _percentage = percentage / 100;
        setState(() {
          downloadMessage = 'Downloading... ${percentage.floor()}%';
        });
      }).then((value) => initializePlayer());
    }
  }

  flushbarNotification(String title, String audio) {
    return Flushbar(
      title: title,
      message: "$audio",
      duration: Duration(seconds: 3),
    )..show(context);
  }

  playAudio(String audio) async {
    if (_isplaying == false) {
      print("Play Audio");
      if (Platform.isIOS) {
        if (audioCache.fixedPlayer != null) {
          audioCache.fixedPlayer.startHeadlessService();
        }
      }
      //Testing Out a List with audio Names
      //audioPlayer = await audioCache.play(audio);
      int result = await audioPlayer.play(audio);
      if (result == 1) {
        setState(() {
          _isplaying = true;
        });

        print("Success");
      }
    } else {
      audioPlayer.stop();
      setState(() {
        _isplaying = false;
      });
    }
  }

  getHttp() async {
    print("HTTP");
    try {
      String token =
          "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MDFhZDVjNDMxZThmOTQ5M2Q2NDhhOWYiLCJhdWQiOiJtb2JpbGV1c2VyIiwiaWF0IjoxNjEzNTAyNjk3LCJpZCI6IjYwMWFkNWM0MzFlOGY5NDkzZDY0OGE5ZiIsInJ1dCI6IjE5NzY4MzQyMiIsImVtYWlsIjoiamF2aWVyb3JkZW5lczUwQGdtYWlsLmNvbSIsIm5hbWUiOiJqYXZpZXIgb3JkZW5lcyIsInNjb3BlIjoidXNlciIsInRlcm1zQWNjZXB0ZWQiOnRydWV9.sBdRGcbdpqgyBOCTiBwIqLvbSpZoNAi-YTFgxvG33zZXNNpGVFDiueyLMt2DHjHb_KM2Q4tfvgHR-3lmP-U2jA";
      Response response = await Dio().get(
          "https://intranet.movitronia.com/api/mobile/classes/1?token=$token");
      //TODO Activate getExercises
      //await getExercises();
      //await getClass(response);
      var deleteobjectlist = await _questionDataRepository.getAllQuestions();
      for (int i = 0; i < deleteobjectlist.length; i++) {
        _questionDataRepository.deleteQuestion(deleteobjectlist[i].id);
      }
      //testDownload();

      List<num> indexes = [];
      List<TipsData> tipsList = [];
      List<QuestionData> questionList = [];
      List<String> audioNames = [];
      for (int i = 0; i < response.data.length; i++) {
        Map responseBody = response.data[i]; //Loop through all objects

        ResultModel jsonResponse = ResultModel.fromJson(responseBody);

        //TODO Create exercises check if id already exist and add to DB use above as an idea
        //TODO for the for loop
/*
        final result = await _tipsDataRepository.getAllTips();
        for (int i = 0; i < result.length; i++) {
          await _tipsDataRepository.deleteTips(result[i].id);
        }*/

        for (int i = 0; i < jsonResponse.tips.length; i++) {
          var tipsResponse = jsonResponse.tips[i];
          if (indexes.contains(int.parse(tipsResponse.tipId))) {
            //print("Repetido");
          } else {
            var audioQuestion;
            var audioTips;
            var audioVF;
            if (tipsResponse.audios.isNotEmpty) {
              audioQuestion = tipsResponse.audios[0].link;
              audioTips = tipsResponse.audios[1].link;
              audioVF = tipsResponse.audios[2].link;
            } else {
              audioQuestion = "[]";
              audioTips = "[]";
              audioVF = "[]";
            }

            TipsData tipsData = TipsData(
                audioQuestion: audioQuestion,
                audioTips: audioTips,
                audioVF: audioVF,
                tipsID: int.parse(tipsResponse.tipId),
                documentID: tipsResponse.sId,
                tip: tipsResponse.tip);

            indexes.add(tipsData.tipsID);
            tipsList.add(tipsData);

            print("TIP Amount ${tipsResponse.audios.length}");
            for (int i = 0; i < tipsResponse.audios.length; i++) {
              print("${tipsResponse.audios[i].link}");
              audioNames.add(tipsResponse.audios[i].link);
            }
            print("TIP value of ${tipsData.tip}");
            await _tipsDataRepository.insertTips(tipsData);
            QuestionData questionData = QuestionData(
                tipID: tipsData.tipsID,
                questionVf: tipsResponse.questions.questionVf,
                correctVf: tipsResponse.questions.correctVf,
                questionAl: tipsResponse.questions.questionAl,
                correctAl: tipsResponse.questions.correctAl,
                alternatives: {
                  'a': tipsResponse.questions.alternatives.a,
                  'b': tipsResponse.questions.alternatives.b,
                  'c': tipsResponse.questions.alternatives.c
                });
            questionList.add(questionData);

            //await _questionDataRepository.insertQuestion(questionData);
            // print(questionData.alternatives);
          }
          //Adding tips
          //TODO add tips in a for loop

        }

/*
        for (int i = 0; i < tipsList.length; i++) {
          final result =
              await _tipsDataRepository.getTips(tipsList[i].documentID);
          if (result.isEmpty) {
            //  print("Insert Data");
          }
          //print("Result: ${result}");
          _tipsDataRepository.insertTips(tipsList[i]);
        }*/
      }

      print(audioNames);
      audioDownload(audioNames, "tip");
      //print(indexes);
      var questions = await _questionDataRepository.getAllQuestions();
      print(questions.length);
      print(questionList.length);
      print("Total Tips: ${tipsList.length}");
    } catch (e) {
      print(e);
    }
  }

  getClass(Response response) async {
    List<int> pauses = [];
    List<dynamic> tips = [];
    List<dynamic> exerciseCalentamiento = [];
    List<dynamic> exerciseFlexibilidad = [];
    List<dynamic> exerciseDesarrollo = [];
    List<dynamic> exerciseVCalma = [];
    List questionnaire = [];
    //First Loop through each object
    for (int i = 0; i < response.data.length; i++) {
      //print("Response Data: ${response.data[i]['pauses']}\n\n\n");
      var responseobject = response.data[i];

      try {
        //print("Total Objects: " + responseobject['pauses'].length.toString());
        /**Getting Calentamiento List */
        for (int i = 0;
            i < responseobject['exercisesCalentamiento'].length;
            i++) {
          exerciseCalentamiento
              .add(responseobject['exercisesCalentamiento'][i]['videoName']);
        }

        /**Getting Flexibilidad List */
        for (int i = 0;
            i < responseobject['exercisesFlexibilidad'].length;
            i++) {
          exerciseFlexibilidad
              .add(responseobject['exercisesFlexibilidad'][i]['videoName']);
        }

        /**Getting Desarrollo List */
        for (int i = 0; i < responseobject['exercisesDesarrollo'].length; i++) {
          exerciseDesarrollo
              .add(responseobject['exercisesDesarrollo'][i]['videoName']);
        }

        /**Getting Vuelta Calma List */
        for (int i = 0;
            i < responseobject['exercisesVueltaCalma'].length;
            i++) {
          exerciseVCalma
              .add(responseobject['exercisesVueltaCalma'][i]['videoName']);
        }

        for (int i = 0; i < responseobject['pauses'].length; i++) {
          //print(responseobject['pauses'][i]['tips']);
          tips.add(responseobject['pauses'][i]['tips']);
          if (responseobject['pauses'][i]['micro'] != null) {
            var object = responseobject['pauses'][i]['micro'].toString();
            pauses.add(int.parse(object));
          }
          if (responseobject['pauses'][i]['macro'] != null) {
            pauses.add(
                int.parse(responseobject['pauses'][i]['macro'].toString()));
          }
        }
        var obj = {};
        for (int i = 0; i < responseobject['questionnaire'].length; i++) {
          obj = {
            "id": responseobject['questionnaire'][i]['id'].toString(),
            "type": responseobject['questionnaire'][i]['type'].toString()
          };
          questionnaire.add(obj);
        }
      } catch (e) {
        print("Le Error " + e.toString());
      }

      ClassLevel classLevel = ClassLevel(
          classID: responseobject['_id'],
          level: responseobject['level'],
          macropause: responseobject['macropause'],
          pauses: pauses,
          excerciseCalentamiento: exerciseCalentamiento,
          excerciseFlexibilidad: exerciseFlexibilidad,
          excerciseDesarrollo: exerciseDesarrollo,
          excerciseVueltaCalma: exerciseVCalma,
          timeCalentamiento: responseobject['times']['calentamiento'],
          timeFlexibilidad: responseobject['times']['flexibilidad'],
          timeDesarrollo: responseobject['times']['desarrollo'],
          timeVcalma: responseobject['times']['vcalma'],
          tips: tips,
          questionnaire: questionnaire);
      await _classRepository.insertClass(classLevel);
      print("Questionnaire: ${classLevel.questionnaire}");
      pauses.clear();
      tips.clear();
      exerciseCalentamiento.clear();
      exerciseFlexibilidad.clear();
      exerciseDesarrollo.clear();
      exerciseVCalma.clear();
      questionnaire.clear();
    }
  }

  getExercises() async {
    String token =
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MDFhZDVjNDMxZThmOTQ5M2Q2NDhhOWYiLCJhdWQiOiJtb2JpbGV1c2VyIiwiaWF0IjoxNjEzNTAyNjk3LCJpZCI6IjYwMWFkNWM0MzFlOGY5NDkzZDY0OGE5ZiIsInJ1dCI6IjE5NzY4MzQyMiIsImVtYWlsIjoiamF2aWVyb3JkZW5lczUwQGdtYWlsLmNvbSIsIm5hbWUiOiJqYXZpZXIgb3JkZW5lcyIsInNjb3BlIjoidXNlciIsInRlcm1zQWNjZXB0ZWQiOnRydWV9.sBdRGcbdpqgyBOCTiBwIqLvbSpZoNAi-YTFgxvG33zZXNNpGVFDiueyLMt2DHjHb_KM2Q4tfvgHR-3lmP-U2jA";

    Response response2 = await Dio().get(
        "https://intranet.movitronia.com/api/mobile/exercises?token=$token");

    var responseobject = response2.data;
    List<String> videos = [];
    List<String> audios = [];
    for (int i = 0; i < responseobject.length; i++) {
      // print(responseobject[i]['url']);
      ExcerciseData excercisedata = ExcerciseData(
          exerciseID: int.parse(responseobject[i]['exerciseId']),
          excerciseNameAudioId: responseobject[i]['exerciseNameAudioId'],
          recomendationAudioId: responseobject[i]['recomendationAudioId'],
          videoName: responseobject[i]['videoName'],
          mets: responseobject[i]['metsPerMinute'],
          nameExcercise: responseobject[i]['exerciseName'],
          recommendation: responseobject[i]['recomendation'],
          categories: responseobject[i]['categories'],
          level: responseobject[i]['levels'],
          stages: responseobject[i]['stages']);
      videos.add(excercisedata.videoName);
      if (excercisedata.excerciseNameAudioId.isNotEmpty) {
        audios.add(excercisedata.excerciseNameAudioId);
      }
      if (excercisedata.recomendationAudioId.isNotEmpty) {
        audios.add(excercisedata.recomendationAudioId);
      }

      //This segment Downloads and create objects on the database

      final result = await _excerciseRepository.insertExcercise(excercisedata);
      print(result);
    }

    await videoDownload(videos);
    //await audioDownload(audios, "exercise");
    /** Test Creating Exercise */

    print("Response ${response2.data[0]}");
  }

  videoDownload(List<String> videoList) async {
    var format = "";
    if (Platform.isAndroid) {
      format = ".webm";
      print("${dir.path}/videos/${videoList[0]}$format");
    } else if (Platform.isIOS) {
      format = ".mp4";
      print("${dir.path}/videos/${videoList[0]}$format");
    }
    //TODO LIST of Exercises
    Dio dio = Dio();
    String token =
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MDFhZDVjNDMxZThmOTQ5M2Q2NDhhOWYiLCJhdWQiOiJtb2JpbGV1c2VyIiwiaWF0IjoxNjEzNTAyNjk3LCJpZCI6IjYwMWFkNWM0MzFlOGY5NDkzZDY0OGE5ZiIsInJ1dCI6IjE5NzY4MzQyMiIsImVtYWlsIjoiamF2aWVyb3JkZW5lczUwQGdtYWlsLmNvbSIsIm5hbWUiOiJqYXZpZXIgb3JkZW5lcyIsInNjb3BlIjoidXNlciIsInRlcm1zQWNjZXB0ZWQiOnRydWV9.sBdRGcbdpqgyBOCTiBwIqLvbSpZoNAi-YTFgxvG33zZXNNpGVFDiueyLMt2DHjHb_KM2Q4tfvgHR-3lmP-U2jA";

    Response response2 = await Dio().post(
        "https://intranet.movitronia.com/api/mobile/videos?token=$token",
        data: {"platform": "android", "videoList": videoList});

    print("Response Video List: ${response2.data.length}");

    for (int i = 0; i < response2.data.length; i++) {
      print(response2.data[i]);
      //Try Catch
      try {
        await dio.download(
            response2.data[i], '${dir.path}/videos/${videoList[i]}$format',
            onReceiveProgress: (actualbytes, totalbytes) {
          var percentage = actualbytes / totalbytes * 100;
          _percentage = percentage / 100;
          setState(() {
            downloadMessage = 'Downloading... ${percentage.floor()}%';
          });
        });
      } catch (e) {}
    }
  }

  audioDownload(List<String> audioList, String type) async {
    //TODO LIST of Exercises
    print("Inside Audio Download");
    Dio dio = Dio();
    String token =
        "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2MDFhZDVjNDMxZThmOTQ5M2Q2NDhhOWYiLCJhdWQiOiJtb2JpbGV1c2VyIiwiaWF0IjoxNjEzNTAyNjk3LCJpZCI6IjYwMWFkNWM0MzFlOGY5NDkzZDY0OGE5ZiIsInJ1dCI6IjE5NzY4MzQyMiIsImVtYWlsIjoiamF2aWVyb3JkZW5lczUwQGdtYWlsLmNvbSIsIm5hbWUiOiJqYXZpZXIgb3JkZW5lcyIsInNjb3BlIjoidXNlciIsInRlcm1zQWNjZXB0ZWQiOnRydWV9.sBdRGcbdpqgyBOCTiBwIqLvbSpZoNAi-YTFgxvG33zZXNNpGVFDiueyLMt2DHjHb_KM2Q4tfvgHR-3lmP-U2jA";

    Response response2 = await Dio().post(
        "https://intranet.movitronia.com/api/mobile/audios?token=$token",
        data: {"type": "$type", "audioList": audioList});

    print("Response Audio List: ${response2.data.length}");

    for (int i = 0; i < response2.data.length; i++) {
      print(response2.data[i]);

      try {
        await dio.download(
            response2.data[i], '${dir.path}/audios/${audioList[i]}.mp3',
            onReceiveProgress: (actualbytes, totalbytes) {
          var percentage = actualbytes / totalbytes * 100;
          _percentage = percentage / 100;
          setState(() {
            downloadMessage = 'Downloading... ${percentage.floor()}%';
          });
        });
      } catch (e) {}
    }
  }

  List<String> excerciseCalentamientoList = [];
  List<String> excerciseFlexibilidadList = [];
  List<String> excerciseDesarrolloList = [];
  List<String> excerciseVcalmaList = [];
}

// downloading logic is handled by this method
