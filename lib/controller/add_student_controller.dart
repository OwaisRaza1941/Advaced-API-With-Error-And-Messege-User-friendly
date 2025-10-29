import 'dart:async';
import 'dart:io';

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

    try {
      final responseData = await StudentService.getStudents().timeout(
        Duration(seconds: 10),
      );

      // Success: parse and add data
      for (var item in responseData) {
        studentData.add(StudentsModel.fromJson(item));
      }
    } on SocketException {
      // No internet
      Get.snackbar(
        'No Internet',
        'Please check your network connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TimeoutException {
      // Request timed out
      Get.defaultDialog(
        title: 'Request Timeout',
        middleText: 'Server is taking too long to respond.',
        textConfirm: 'Retry',
        onConfirm: () {
          Get.back();
          getStudents();
        },
        textCancel: 'Cancel',
      );
    } catch (e, st) {
      // Unexpected error
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      print('getStudents error: $e');
      print(st);
    } finally {
      hideLoader();
    }
  }

  // Add new student
  Future<void> addStudents(Map<String, dynamic> data) async {
    showLoader();
    try {
      await StudentService.addStudent(data).timeout(Duration(seconds: 10));
      await getStudents(); // Refresh data
    } on SocketException {
      Get.snackbar(
        'No Internet',
        'Please check your network connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TimeoutException {
      Get.defaultDialog(
        title: 'Request Timeout',
        middleText: 'Server is taking too long to respond.',
        textConfirm: 'Retry',
        onConfirm: () {
          Get.back();
          getStudents();
        },
        textCancel: 'Cancel',
      );
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      hideLoader();
    }
  }

  // Update student
  Future<void> updateStudents({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    showLoader();
    try {
      await StudentService.updateStudent(id, data);
      await getStudents(); // Refresh data
    } on SocketException {
      Get.snackbar(
        'No Internet',
        'Please check your network connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on TimeoutException {
      Get.defaultDialog(
        title: 'Request Timeout',
        middleText: 'Server is taking too long to respond.',
        textConfirm: 'Retry',
        onConfirm: () {
          Get.back();
          getStudents();
        },
        textCancel: 'Cancel',
      );
    } catch (e) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      hideLoader();
    }
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
