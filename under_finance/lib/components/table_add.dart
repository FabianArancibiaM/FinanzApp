import 'package:flutter/material.dart';

class TableAdd extends StatelessWidget {
  const TableAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Descripción')),
          DataColumn(label: Text('Monto')),
        ],
        rows: List<DataRow>.generate(
          10, // Número de filas
          (index) {
            // Alternar colores de fondo
            Color colorFila = index % 2 == 0 ? Colors.red : Colors.blue;

            return DataRow(
              cells: <DataCell>[
                DataCell(Text('Dato ${index + 1}')),
                DataCell(Text('Dato ${index + 2}')),
                DataCell(Text('Dato ${index + 3}')),
              ],
              color: MaterialStateColor.resolveWith((states) => colorFila),
            );
          },
        ),
      ),
    );
  }
}
