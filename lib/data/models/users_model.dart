class UsersModelResponse {
  String? code;
  String? message;
  List<UsersModel?>? data;

  UsersModelResponse({
    this.code,
    this.message,
    this.data
  });
}

class UsersModel {
    int? id;
    String? fullname;
    String? username;
    String? password;
    String? salt;
    DateTime? createdAt;
    DateTime? updatedAt;

    UsersModel({
        this.id,
        this.fullname,
        this.username,
        this.password,
        this.salt,
        this.createdAt,
        this.updatedAt,
    });
}
