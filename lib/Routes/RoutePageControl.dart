import 'package:get/get.dart';
import 'AppRoutes.dart';

goToLogin() {
  Get.toNamed(AppRoutes.login.name);
}

goToHome(String role) {
  if (role == "user") {
    Get.toNamed(AppRoutes.homeUser.name, arguments: role);
  } else {
    Get.toNamed(AppRoutes.homeTeacher.name, arguments: role);
  }
}

goToBasal(String role) {
  if (role == "user") {
    Get.toNamed(AppRoutes.basalUser.name, arguments: role);
  } else {
    Get.toNamed(AppRoutes.basalTeacher.name, arguments: role);
  }
}

goToTerms(String role) {
  Get.toNamed(AppRoutes.terms.name, arguments: role);
}

goToWelcome(String role) {
  Get.toNamed(AppRoutes.welcome.name, arguments: role);
}

goToPlanification() {
  Get.toNamed(AppRoutes.planification.name);
}

goToExcercisesPage(String name) {
  Get.toNamed(AppRoutes.excercisesPage.name, arguments: name);
}

goToSessionPage() {
  Get.toNamed(AppRoutes.sessionPage.name);
}

goToShowCalories() {
  Get.offAllNamed(AppRoutes.showCalories.name);
}

goToEvidencesSession() {
  Get.toNamed(AppRoutes.evidencesSession.name);
}

goToUploadData() {
  Get.toNamed(AppRoutes.uploadData.name);
}

goToVideosToRecord(Function func) {
  Get.toNamed(AppRoutes.videosToRecord.name).then(func);
}

goToQuestionary(String nameClass, Function func) {
  Get.toNamed(AppRoutes.questionary.name, arguments: nameClass).then(func);
}

goToFinalPage() {
  Get.toNamed(AppRoutes.finalPage.name);
}

goToCaloricExpenditure() {
  Get.toNamed(AppRoutes.caloricExpenditure.name);
}

goToApplicationUse() {
  Get.toNamed(AppRoutes.applicationUse.name);
}

goToAllEvidences() {
  Get.toNamed(AppRoutes.allEvidences.name);
}

goToReports(bool drawer) {
  Get.toNamed(AppRoutes.reports.name, arguments: drawer);
}

goToEvidencesVideos() {
  Get.toNamed(AppRoutes.evidencesVideos.name);
}

goToEvidencesQuestionary() {
  Get.toNamed(AppRoutes.evidencesQuestionary.name);
}

goToHomeReplacement() {
  Get.offAndToNamed(AppRoutes.homeUser.name, arguments: "user");
}

goToshowCycle(String nameCourse, int cycle) {
  Get.toNamed(AppRoutes.showCycle.name,
      arguments: {"nameCourse": nameCourse, "cycle": cycle});
}

goToShowPhases(int cycle, String title, bool isEvidence) {
  Get.toNamed(AppRoutes.showPhases.name,
      arguments: {"cycle": cycle, "title": title, "isEvidence": isEvidence});
}

goToCreateClass() {
  Get.toNamed(AppRoutes.createClass.name);
}

goToExcercisesClass(String title) {
  Get.toNamed(AppRoutes.excercisesClass.name, arguments: title);
}

goToFilterExcercises(String title) {
  Get.toNamed(AppRoutes.filterExcercises.name, arguments: title);
}

goToAddExcercises(String title) {
  Get.toNamed(AppRoutes.addExcercises.name, arguments: title);
}

goToFinishCreateClass() {
  Get.toNamed(AppRoutes.finishCreateClass.name);
}

goToAssignCreatedClass() {
  Get.toNamed(AppRoutes.assignCreatedClass.name);
}

goToMessageUploadData() {
  Get.toNamed(AppRoutes.messageUploadData.name);
}

goToSearchEvidences(bool isFull) {
  Get.toNamed(AppRoutes.searchEvidences.name, arguments: isFull);
}

goToMenuEvidences() {
  Get.toNamed(AppRoutes.menuEvidences.name);
}

goToSupport(bool isFull) {
  Get.toNamed(AppRoutes.support.name, arguments: isFull);
}

goToManuals(bool isFull) {
  Get.toNamed(AppRoutes.manuals.name, arguments: isFull);
}

closeSession() {
  Get.offAllNamed(AppRoutes.login.name);
}

goToDetailsExcercises(
    String name, String asset, String kcal, String duration, String desc) {
  Get.toNamed(AppRoutes.detailsExcercises.name, arguments: {
    "name": name,
    "desc": desc,
    "kcal": kcal,
    "asset": asset,
    "duration": duration
  });
}

goToHomeTeacher() {
  Get.offAllNamed(AppRoutes.homeTeacher.name);
}

goToTest() {
  Get.toNamed(AppRoutes.test.name);
}

goToRecoverPass() {
  Get.toNamed(AppRoutes.recoverPass.name);
}

goToSettingsPage(String role) {
  Get.toNamed(AppRoutes.settingsPage.name, arguments: role);
}
