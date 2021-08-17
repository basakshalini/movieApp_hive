import 'package:hive/hive.dart';
import 'package:movie_app_hivedb/model/description.dart';
import 'package:movie_app_hivedb/pages/home_page.dart';

class Boxes {
  static Box<Description> getDescriptions() =>
      Hive.box<Description>('descriptions');
}