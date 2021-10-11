import 'package:flutter/material.dart';

import 'model/panel.dart';
import 'model/panels_repository.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>{

  // final List<Item> _data = generateItems(8);
  final List<Panel> _data = PanelsRepository.loadPanels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
        //const Text("Hello World"),
      body: SingleChildScrollView(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel(){
    bool kidCheck = false;
    bool petCheck = false;
    bool breakfastCheck = false;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }


    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Panel panel) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(panel.headerValue),
            );
          },
          body: ListTile(
              title: Text(panel.expandedValue),
              subtitle: Container(
                child: Column(
                  children: [
                    const Text('select filters'),
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: kidCheck,
                              onChanged: (bool? value){
                                setState((){
                                  kidCheck = value!;
                                });
                              },
                            ),
                            const Text('No Kids Zone'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: petCheck,
                              onChanged: (bool? value){
                                setState((){
                                  petCheck = value!;
                                });
                              },
                            ),
                            const Text('Pet-Friendly'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.black,
                              fillColor: MaterialStateProperty.resolveWith(getColor),
                              value: breakfastCheck,
                              onChanged: (bool? value){
                                setState((){
                                  breakfastCheck = value!;
                                });
                              },
                            ),
                            const Text('Free breakfast'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // subtitle:
              // const Text('To delete this panel, tap the trash can icon'),
              // trailing: const Icon(Icons.delete),
              // onTap: () {
              //   setState(() {
              //     _data.removeWhere((Panel currentItem) => panel == currentItem);
              //   });
              // }
          ),
          isExpanded: panel.isExpanded,
        );
      }).toList(),
    );
  }
}