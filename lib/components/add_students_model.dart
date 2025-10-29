import 'package:demo_api_crud/components/students_feilds.dart';
import 'package:demo_api_crud/constants/styles.dart';
import 'package:demo_api_crud/models/students_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showStudentDailoge({
  required BuildContext context,
  StudentsModel? std,
  required bool isUpdated,
}) {
  TextEditingController namecontroller = TextEditingController(
    text: std?.name ?? '',
  );
  TextEditingController emailController = TextEditingController(
    text: std?.email ?? '',
  );
  TextEditingController courseController = TextEditingController(
    text: std?.course ?? '',
  );

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            isUpdated ? 'Updated Student' : "Add Student",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              textFields(hintText: 'Name', controller: namecontroller),
              SizedBox(height: 15),
              textFields(hintText: 'Email', controller: emailController),
              SizedBox(height: 15),
              textFields(hintText: 'Course', controller: courseController),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: Styles.textButtonStyle,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                  ),

                  SizedBox(width: 10),
                  TextButton(
                    style: Styles.textButtonStyle,
                    onPressed: () {
                      if (namecontroller.text.isEmpty) {
                        Get.snackbar('Messege', 'Please name field required!');
                        return;
                      }
                      Get.back(
                        result: {
                          'name': namecontroller.text,
                          'email': emailController.text,
                          'course': courseController.text,
                        },
                      );
                    },
                    child: Text(isUpdated ? 'Updated' : "Add "),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );
}
