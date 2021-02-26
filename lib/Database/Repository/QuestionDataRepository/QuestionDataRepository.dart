import 'package:movitronia/Database/Models/QuestionData.dart';

abstract class QuestionDataRepository {
  Future<int> insertQuestion(QuestionData gifdata);

  Future updateQuestion(QuestionData gifdata);

  Future deleteQuestion(int gifDataId);

  Future<List<QuestionData>> getAllQuestions();

  Future<List<QuestionData>> getQuestion(int id);

  //Future<List<ExcerciseData>> loopSearch(List<int> listId);
}
