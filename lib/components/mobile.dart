import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<String> saveFile(List<int> bytes, String fileName) async{
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  return '$path/$fileName';
}
