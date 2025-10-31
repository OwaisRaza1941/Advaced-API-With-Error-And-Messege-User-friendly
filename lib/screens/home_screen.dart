import 'package:demo_api_crud/components/add_students_model.dart';
import 'package:demo_api_crud/constants/styles.dart';
import 'package:demo_api_crud/controller/student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentController controller = Get.put(StudentController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text("Demo API Paractice"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var stdData = await showStudentDailoge(
            context: context,
            isUpdated: false,
          );
          if (stdData != null) {
            controller.addStudents(stdData);
          }
        },
        child: Icon(Icons.add),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SpinKitFadingCircle(color: Colors.purple, size: 50),
          );
        }
        return controller.studentData.isNotEmpty
            ? ListView.builder(
                itemCount: controller.studentData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        controller.studentData[index].name ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(controller.studentData[index].email ?? ''),
                      trailing: Wrap(
                        children: [
                          IconButton(
                            style: Styles.textButtonStyle,
                            onPressed: () async {
                              var result = await showStudentDailoge(
                                context: context,
                                isUpdated: true,
                                std: controller.studentData[index],
                              );

                              if (result != null) {
                                await controller.updateStudents(
                                  data: result,
                                  id: controller.studentData[index].id ?? '',
                                );
                              }
                            },
                            icon: Icon(Icons.edit),
                          ),

                          IconButton(
                            style: Styles.textButtonStyle,
                            onPressed: () async {
                              await controller.deleteStudents(
                                controller.studentData[index].id!,
                              );
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(child: Text("No Students Yets"));
      }),
    );
  }
}
