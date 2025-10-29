class StudentsModel {
  String? id;
  String? name;
  String? email;
  String? course;

  StudentsModel({this.id, this.name, this.email, this.course});

  /// JSON Convert --->> To Dart Model
  factory StudentsModel.fromJson(Map<String, dynamic> json) {
    return StudentsModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      course: json['course'],
    );
  }

  /// Covert Dart Molde In ----->>> JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) {
      id = data['_id'];
    }
    name = data['name'];
    email = data['email'];
    course = data['course'];

    return data;
  }
}
