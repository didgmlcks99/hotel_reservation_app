import 'package:flutter/material.dart';

import 'globals.dart' as globals;
import 'model/hotel.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({Key? key}) : super(key: key);

  @override
  _HotelPageState createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage>{

  final List<Hotel> favorites = globals.isFavorite.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Hotels'),
      ),
      body: ListView.separated(
        itemCount: favorites.length,
        itemBuilder: (context, index){
          final tile = favorites[index].name;
          return Dismissible(
            key: Key(tile),
            onDismissed: (direction){
              setState((){
                globals.isFavorite.remove(favorites[index]);
                favorites.removeAt(index);
              });

              // ScaffoldMessenger.of(context)
              //     .showSnackBar(SnackBar(content: Text('$tile dismissed')));
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(tile),
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) {
          return const Divider();
      },
      ),
    );
  }
}
