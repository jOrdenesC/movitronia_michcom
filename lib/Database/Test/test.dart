import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/GifData.dart';
import 'package:movitronia/Database/Repository/GifDataRepository.dart';

class HomePageTest extends StatefulWidget {
  @override
  _HomePageTestState createState() => _HomePageTestState();
}

class _HomePageTestState extends State<HomePageTest> {
  GifDataRepository _gifRepository = GetIt.I.get();
  List<GifData> _gif = [];

  @override
  void initState() {
    super.initState();
    _loadGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorite Gif"),
      ),
      body: ListView.builder(
        itemCount: _gif.length,
        itemBuilder: (context, index) {
          final gif = _gif[index];
          return ListTile(
            title: Text(gif.nameExcercise),
            subtitle: Text("LimitLoop: ${gif.name}"),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteCake(gif),
            ),
            leading: IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => _editCake(gif),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addGif,
      ),
    );
  }

  _loadGifs() async {
    final gifs = await _gifRepository.getAllGif();
    setState(() => _gif = gifs);
  }

  _addGif() async {
    // final list = ["apple", "orange", "chocolate"]..shuffle();
    // final name = "My amazing ${list.first} gif";
    // final nameexercise = 'Some Name';
    // final duration = Duration(milliseconds: 600);
    final newGif = GifData(
        name: 'C1.gif',
        gifduration: 600,
        hasAnim: false,
        maxFrames: 14,
        kiloCalories: 12,
        nameExcercise: 'SKIPPING',
        recommendation: 'NO Explotes');
    final response = await _gifRepository.insertGif(newGif);
    print(response);
    _loadGifs();
  }

  _deleteCake(GifData gifData) async {
    await _gifRepository.deleteGif(gifData.id);
    _loadGifs();
  }

  _editCake(GifData gifData) async {
    final updatedCake =
        gifData.copyWith(nameExcercise: gifData.nameExcercise + ' something');
    await _gifRepository.updateGif(updatedCake);
    _loadGifs();
  }
}
