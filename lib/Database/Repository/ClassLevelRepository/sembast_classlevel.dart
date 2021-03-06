import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Models/ResponseModels/ResultClassModel.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:sembast/sembast.dart';

class SembastClassDataRepository extends ClassDataRepository {
  final Database _database = GetIt.I.get();
  final StoreRef _store = intMapStoreFactory.store("classData_store");

  @override
  Future<int> insertClass(ClassLevel classData) async {
    print('inside insertGif');
    print(classData.toMap());
    return await _store.add(_database, classData.toMap());
  }

  @override
  Future updateClass(ClassLevel classData) async {
    await _store.record(classData.id).update(_database, classData.toMap());
  }

  @override
  Future deleteClass(int classDataId) async {
    await _store.record(classDataId).delete(_database);
  }

  @override
  Future<List<ClassLevel>> getAllClassLevel() async {
    final snapshots = await _store.find(_database);
    return snapshots
        .map((snapshot) => ClassLevel.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<List<ClassLevel>> getClassID(String id) async {
    //final finder = Finder(filter: Filter.byKey(id)); //TODO FILTER BY CLASSID
    final finder = Finder(filter: Filter.equals('classID', id));
    final snapshots = await _store.find(_database, finder: finder);
    //print("Snapshot: " + snapshots.toString());
    // var records = await _store.records([12, 14]).get(_database);
    //final snapshots = await _store.find(_database, finder: finder);
    return snapshots
        .map((snapshot) => ClassLevel.fromMap(snapshot.key, snapshot.value))
        .toList(growable: false);
  }

  @override
  Future<int> insertClassJSON(ResultModel resultModel) async {
    ClassLevel classData = ClassLevel(
        tips: _parseInt(resultModel.tips),
        // micropause: resultModel.micropause,
        //macropause: resultModel.macropause,
        excerciseCalentamiento: _parseInt(resultModel.exercisesCalentamiento),
        excerciseFlexibilidad: _parseInt(resultModel.exercisesFlexibilidad),
        excerciseDesarrollo: _parseInt(resultModel.exercisesDesarrollo),
        excerciseVueltaCalma: _parseInt(resultModel.exercisesVueltaCalma),
        level: resultModel.level,
        timeCalentamiento: resultModel.times.calentamiento,
        timeFlexibilidad: resultModel.times.flexibilidad,
        timeDesarrollo: resultModel.times.desarrollo,
        timeVcalma: resultModel.times.vcalma,
        classID: resultModel.sId);

    print('inside insertGif');
    print(classData.toMap());
    return await _store.add(_database, classData.toMap());
  }

  @override
  Future deleteAll() async {
    await _store.delete(_database);
  }

  _parseString(List<dynamic> data) {
    List<String> results = new List<String>();
    data.forEach((item) {
      results.add(item);
    });
    return results;
  }

  _parseInt(List<dynamic> data) {
    List<int> results = new List<int>();
    data.forEach((item) {
      results.add(item);
    });
    return results;
  }
}

/*
{
    "firstName": "Rack",
    "lastName": "jackson",
    "gender": "man",
    "age": 24,
    "address": {
        "streetAddress": "126 Udhna",
        "city": "san jone",
        "state": "CA",
        "postalCode": "394221"
    },
    "phoneNumbers": [
        { "type": "home", "number": "7383627627" }
    ]
}

*/
