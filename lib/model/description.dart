import 'package:hive/hive.dart';
part 'description.g.dart';

@HiveType(typeId: 0)
class Description extends HiveObject{
  
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String director;

  @HiveField(2)
  late String imgUrl;

  @HiveField(3)
  late DateTime createdDate;

  @HiveField(4)
  late bool isDesc = true;
}

@HiveType(typeId: 1)
class User {
  late String name;
  
  late DateTime createdDate;
  
}
