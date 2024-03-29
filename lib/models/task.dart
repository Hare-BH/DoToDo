import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late bool isDone = false;

  Task(this.name);

  void isCheck() => isDone = !isDone;
}
