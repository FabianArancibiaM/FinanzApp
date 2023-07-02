import 'package:flutter/material.dart';

class CategoryFormScreen extends StatelessWidget {
  const CategoryFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = OutlineInputBorder(borderRadius: BorderRadius.circular(40));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir categoria'),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: Column(children: [
            TextFormField(
              // obscureText: true, // Ofusca texto
              onChanged: (value) {},
              decoration: InputDecoration(
                enabledBorder: border,
                focusedBorder: border.copyWith(
                    borderSide: BorderSide(color: colors.primary)),
                isDense: true,
                label: const Text('Descripcion'),
                prefixIcon: Icon(Icons.edit_document, color: colors.primary),
                // icon: Icon(Icons.wordpress_sharp, color: colors.primary)
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: ElevatedButton(
                child: Row(children: [
                  Icon(Icons.save_as_rounded),
                  SizedBox(width: 15),
                  Text('Guardar')
                ]),
                onPressed: () {},
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Columna 1')),
                        DataColumn(label: Text('Columna 2')),
                      ],
                      rows: const [
                        DataRow(
                          cells: [
                            DataCell(Text('Valor 1')),
                            DataCell(Text('Valor 2')),
                          ],
                        ),
                      ],
                    )))
          ])),
    );
  }
}
