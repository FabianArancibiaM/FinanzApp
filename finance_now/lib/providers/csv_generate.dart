import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class CsvGenerate {
  void generarCSV(List<List<dynamic>> datos) async {
    final directory = await getApplicationDocumentsDirectory();
    final initialDirectory = directory.path;

    final outputFile = await FilePicker.platform.getDirectoryPath(
      initialDirectory: initialDirectory,
    );

    if (outputFile != null) {
      final csvContent = 'Columna 1, Columna 2, Columna 3\n'
          'Dato 1, Dato 2, Dato 3\n'
          'Dato 4, Dato 5, Dato 6\n'
          'Dato 7, Dato 8, Dato 9';

      final filePath = '$outputFile/archivo.csv';
      await File(filePath).writeAsString(csvContent);

      print('Archivo guardado en: $filePath');
    } else {
      print('Directorio de guardado no seleccionado');
    }
  }

  void main() async {
    // Datos de ejemplo
    List<List<dynamic>> datos = [
      ['Dato 1', 'Dato 2', 'Dato 3'],
      ['Dato 4', 'Dato 5', 'Dato 6'],
      ['Dato 7', 'Dato 8', 'Dato 9'],
    ];

    generarCSV(datos);
  }
}
