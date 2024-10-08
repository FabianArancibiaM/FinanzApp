import 'package:finance_v3/models/movement_model.dart';
import 'package:finance_v3/providers/parametric_data_provider.dart';
import 'package:finance_v3/providers/provider.dart';
import 'package:finance_v3/widget/design/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  late List<Widget> items = [];

  @override
  void initState() {
    super.initState();

    final movementProvider =
        Provider.of<MovementProvider>(context, listen: false);
    setState(() {
      items = [];
    });
    getList(movementProvider);
  }

  Future getList(MovementProvider movementProvider) async {
    List<MovementModel> list = await movementProvider.getListMovement();
    for (var element in list) {
      items.add(_buildItem(element.description));
    }
    setState(() {
      items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<ParametricDataProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Visibility(
            visible: items.isEmpty,
            child: Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 250),
                    child: const Text('12312312'))),
          ),
          if (items.isNotEmpty)
            ListView.builder(
              itemCount: items.length,
              // prototypeItem: ListTile(
              //   title: Text(items.first),
              // ),
              itemBuilder: (context, index) {
                return ListTile(
                  title: items[index],
                );
              },
            ),
        ],
      ),
    );
  }
}

Widget _buildItem(String textTitle) {
  return new ListTile(
    title: new Text(textTitle),
    subtitle: new Text('Subtitulo ejemplo'),
    leading: new Icon(Icons.map),
    onTap: () {
      print(textTitle);
    },
  );
}
