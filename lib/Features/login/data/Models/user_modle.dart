import 'package:hive/hive.dart';

part 'user_modle.g.dart';

@HiveType(typeId: 0)
class UserModle extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? image;

  UserModle({this.name, this.image});
}

