import 'dart:async';
import 'dart:developer';
import 'dart:io';

//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/GifData.dart';
import 'package:movitronia/Database/Repository/GifDataRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:quiver/async.dart';
import 'package:video_player/video_player.dart';

class WebmController extends GetxController {
  //Video Controllers
  VideoPlayerController videoPlayerController1;
  VideoPlayerController videoPlayerController2;
  ChewieController chewieController;
  //AUdio Controller
  //final assetsAudioPlayer = AssetsAudioPlayer();
  //Database Variables
  GifDataRepository _gifRepository = GetIt.I.get();
  List<GifData> giflistdb = [];

  //Audio Controller
  //omoi ga omoi omoi-san   / bite marks / sekimen shinaide sekime-san/ 329748 / takane no hana wa usotsuki desu/ dont cry maou chan /
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  //final assetsAudioPlayer = AssetsAudioPlayer.withId("music");

  //Controller CountDown
  CountDownController controllerCountDown = CountDownController();
  CountDownController controllerDemostration = CountDownController();
  var index = 0.obs;
  List<int> gifID = [12, 14, 15, 16];
  // List<String> giflist = ['0.gif', '1.gif', '2.gif', '3.gif'];
  //List<String> giflist = ['0.gif', 'C1.gif', 'C2.gif', 'C3.gif'];
  List<int> giftime = [5, 10, 6, 5, 7, 8, 5, 4, 4, 4, 4, 4];
  List<int> giftimepause = [4, 4, 6, 5, 4, 3, 5, 5, 5, 6, 5, 4];
  List<String> tips = [
    'Tip1',
    'Tip2',
    'Tip3',
    'Tip4',
    'Tip5',
    'Tip6',
    'Tip7',
    'Tip8',
    'Tip9',
    'Tip10',
    ''
  ];
  List<String> audios = ['mario.mp3', 'fanfare.mp3'];

  List<String> tipsData = [
    "LOS CARTÍLAGOS SON MAS BLANDOS QUE LOS HUESOS",
    "SABÍAS QUE LOS HUESOS ESTÁN FORMADO POR CALCIO Y FÓSFORO",
    "SABÍAS QUE EL CUERPO HUMANO DE UN ADULTO ESTA FORMADO POR 206 HUESOS",
    "CON LA ACTIVIDAD FISICA ELEVAS TU AUTOESTIMA",
    "SABÍAS QUE EL SUDOR ESTÁ COMPUESTO POR AGUA Y SAL",
    "LAS CAPACIDADES FÍSICAS BÁSICAS SON LA RESISTENCIA, VELOCIDAD, FUERZA Y FLEXIBILIDAD",
    "SABIAS QUE MAS DE LA MITAD DEL PESO DE TU CUERPO ESTA FORMADO POR AGUA",
    "LAS CUALIDADES COORDINATIVAS SON 4: AGILIDAD, RITMO, ORIENTACIÓN Y EQUILIBRIO",
    "LA ACTIVIDAD FÍSICA COMBATE EL SEDENTARISMO, ENEMIGO DE UNA BUENA SALUD",
    "TEN UNA BOTELLA CON AGUA CERCA PARA HIDRATARTE",
    "LOS CARTÍLAGOS SON MAS BLANDOS QUE LOS HUESOS"
  ];
  int precacheindex = 0;
  double amountofLoops = 0;
  //List<double> gifframes = [0, 22, 42, 33];
  // List<double> gifframes = [0, 14, 45, 54];
  /* List<Duration> gifduration = [
    Duration(milliseconds: 200),
    Duration(milliseconds: 600),
    Duration(milliseconds: 2200),
    Duration(milliseconds: 2230)
  ]; */
  String webpName = "Assets/images/C12.gif";
  var isPause = false.obs;
  var location = false;
  var startgif = false;
  //This micropause determines any kind of pause in the application be a normal pause, or preparing for the next excercise
  var microPause = false.obs;
  var macroPause = false.obs;
  //  GifController controller4
  Timer _timer;
  var startcounter = 5.obs;
  var gif = false.obs;
  bool change = false;
  var start = false;
  var demonstration = true.obs;
  bool almostFinish = false;

  Future<void> initializePlayer() async {
    videoPlayerController1 = VideoPlayerController.asset(
        'Assets/videos/${giflistdb[index.value].name}.webm');

    await videoPlayerController1.initialize();

    videoPlayerController1.obs;

    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController1,
      autoPlay: true,
      looping: true,
    );
  }

  togglepause() {
    isPause.value = !isPause.value;
  }

  toggleGifbool() {
    gif.value = !gif.value;
  }

  void startTimer() {
    log('Start Timer Started');
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer _timer) => () {
              log('Inside Timer');
              if (startcounter.value.toInt() < 1) {
                _timer.cancel();
                start = true;
                startgif = true;
              } else {
                log(startcounter.toString());
                startcounter.value = -1;
              }
            });
  }

  void startTimer2() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: 5),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen((null));
    sub.onData((duration) {
      startcounter.value = 5 - duration.elapsed.inSeconds;
      if (startcounter.value == 0) {
        log('finished');
        start = true;
        startgif = true;
      }
    });
  }

  playAudio() async {
    print("Play Audio");
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
    }
    //Testing Out a List with audio Names
    audioPlayer = await audioCache.play('audio/${audios[index.value]}');
  }

  //Database Controller Actions
  getData() async {
    log('getting data');
    // playAudio();
    await _loadGifs();
    amountofLoops = giflistdb.length / 3;

    initializePlayer();
  }

  _loadGifs() async {
    final gifs = await _gifRepository.loopSearch([
      12,
      7,
      9,
      6,
      8,
      5,
      4,
      8,
      13,
      11
    ]); //1-2  calentamiento 3-8 desarrollo 9-10 vuelta a la calma
    //print(gifs[0].name);
    giflistdb = gifs;
    //print(giflistdb[0].name);
  }

  controllTimer() {
    //Check Precache TESTING

    if (microPause.value == true) {
      print('micropause off');
      microPause.value = false;
      //MacroPause Must be under here deactivated
      macroPause.value = false;
    } else {
      print('microspause on');

      if (almostFinish == true) {
        print('finished');
        gif.value = true;
        goToShowCalories();
      } else {
        microPause.value = true;
        //Under some index value activate the macropause  boolean
        if (index.value == 1 || index.value == 7) {
          macroPause.value = true;
        }
        print('MicroPause State ' + microPause.value.toString());
        index++;
        if (index.value == giflistdb.length - 1) {
          print('almost finished');
          almostFinish = true;
        }
        if (index > giflistdb.length) {
          //Move this garbage inside micropause on when index is changing

        } else {
          //webpName = "Assets/${giflistdb[index.value].name}.webm'}";
          // videoPlayerController1 = VideoPlayerController.asset(webpName);
          updateController();
        }
      }
    }

    if (gif.value != true) {
      controllerCountDown.restart(duration: returnTimer());
    }

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController1,
      autoPlay: true,
      looping: true,
      showControls: false,
    );
    //controller3.stop();
  }

  updatenextController() {
    videoPlayerController2 = VideoPlayerController.asset(
        'Assets/videos/${giflistdb[index.value + 1].name}.webm');
  }

  updateController() {
    videoPlayerController1 = VideoPlayerController.asset(
        'Assets/videos/${giflistdb[index.value].name}.webm');

    /*
    if (microPause.value == true) {
      print("Update controller 1 on micropause");
      videoPlayerController1 = VideoPlayerController.asset(
          'Assets/${giflistdb[index.value].name}.webm');
    } else {
      print("Update controller 2 on micropause");
      videoPlayerController2 = VideoPlayerController.asset(
          'Assets/${giflistdb[index.value].name}.webm');
    }*/

    //await videoPlayerController1.initialize();

    update();
  }

  pauseController() {
    if (isPause.value) {
      controllerCountDown.resume();
      togglepause();
    } else {
      controllerCountDown.pause();
      togglepause();
    }
  }

  int returnTimer() {
    List<int> returned;
    if (microPause.value == true) {
      returned = giftimepause;
    } else {
      returned = giftime;
    }
    print('Value of Returned ' + returned[index.value].toString());
    return returned[index.value].toInt();
  }
}
