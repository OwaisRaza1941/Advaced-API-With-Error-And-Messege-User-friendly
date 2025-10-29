import 'package:demo_api_crud/services/students_services.dart';
import 'package:get/get.dart';
import '../models/students_model.dart';

class StudentController extends GetxController {
  // Observable list for students
  RxList<StudentsModel> studentData = <StudentsModel>[].obs;

  // Loading state
  RxBool isLoading = false.obs;

  // Show loader
  void showLoader() => isLoading.value = true;
  void hideLoader() => isLoading.value = false;

  // Get all students
  Future<void> getStudents() async {
    showLoader();
    studentData.clear();

    var responseData = await StudentService.getStudents();
    for (var item in responseData) {
      studentData.add(StudentsModel.fromJson(item));
    }

    hideLoader();
  }

  // Add new student
  Future<void> addStudents(Map<String, dynamic> data) async {
    showLoader();
    await StudentService.addStudent(data);
    await getStudents(); // Refresh data
    hideLoader();
  }

  // Update student
  Future<void> updateStudents({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    showLoader();
    await StudentService.updateStudent(id, data);
    await getStudents(); // Refresh data
    hideLoader();
  }

  // Delete student
  Future<void> deleteStudents(String id) async {
    showLoader();
    await StudentService.deleteStudent(id);
    await getStudents(); // Refresh data
    hideLoader();
  }

  @override
  void onInit() {
    super.onInit();
    getStudents(); // Load data when screen opens
  }
}
