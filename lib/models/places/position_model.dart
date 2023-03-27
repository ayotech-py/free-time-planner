import 'package:hive/hive.dart';
part 'position_model.g.dart';

@HiveType(typeId: 11)
class UserPosition {
  @HiveField(0)
  double long;
  @HiveField(1)
  double lat;

  UserPosition({
    required this.long,
    required this.lat,
  });
}
