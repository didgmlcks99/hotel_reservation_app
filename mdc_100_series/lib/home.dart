// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/hotel.dart';
import 'model/hotels_repository.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final isSelected = <bool>[false, true, ];
  Set<Hotel> isFavorite = <Hotel>{};
  static const _url = "https://handong.edu/";

  List<Card> _buildGridCards(BuildContext context) {
    List<Hotel> hotels = HotelsRepository.loadHotels(Category.all);

    if (hotels.isEmpty) {
      return const <Card>[];
    }

    // final ThemeData theme = Theme.of(context);
    // final NumberFormat formatter = NumberFormat.simpleCurrency(
    //     locale: Localizations.localeOf(context).toString());

    return hotels.map((hotel) {
      return Card(
        clipBehavior: Clip.antiAlias,
        // TODO: Adjust card heights (103)
        child: Hero(
          tag: hotel.assetName,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onDoubleTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(hotel: hotel,),
                  ),
                );
              },
              child: Column(
                // TODO: Center items on the card (103)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 18 / 11,
                    child: Image.asset(
                      hotel.assetName,
                      // package: hotel.assetPackage,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 5.0),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.hotel,
                                color: Colors.lightBlue,
                                size: 15,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: List.generate(hotel.star, (index){
                                    return const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 10,
                                    );
                                  }),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 80,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      hotel.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                    ),Text(
                                      hotel.location,
                                      style: const TextStyle(
                                        fontSize: 8,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 30.0),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(hotel: hotel,),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'more',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  // padding: const EdgeInsets.all(0.0),
                                  minimumSize: const Size(5, 3),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  void _launchURL() async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  AppBar myAppBar(GlobalKey<ScaffoldState> _scaffoldKey){
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          semanticLabel: 'menu',
        ),
        onPressed: () {
          print('Menu button');
          _openDrawer(_scaffoldKey);
        },
      ),
      title: const Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: Text('Main'),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            print('Search button');
            Navigator.pushNamed(context, '/search');
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.language,
            semanticLabel: 'language',
          ),
          onPressed: () {
            print('Language button');
            _launchURL();
          },
        ),
      ],
    );
  }

  Drawer myDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
                child: Text(
                  'Pages',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Icon(
                Icons.home,
                color: Colors.lightBlue,
              ),
            ),
            title: const Text('Home'),
            onTap: (){
              _closeDrawer();
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Icon(
                Icons.search,
                color: Colors.lightBlue,
              ),
            ),
            title: const Text('Search'),
            onTap: (){
              _closeDrawer();
              Navigator.pushNamed(context, '/search');
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Icon(
                Icons.location_city,
                color: Colors.lightBlue,
              ),
            ),
            title: const Text('Favorite Hotel'),
            onTap: (){
              _closeDrawer();
              Navigator.pushNamed(context, '/hotel');
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Icon(
                Icons.person,
                color: Colors.lightBlue,
              ),
            ),
            title: const Text('My Page'),
            onTap: (){
              _closeDrawer();
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Icon(
                Icons.logout,
                color: Colors.lightBlue,
              ),
            ),
            title: const Text('Log Out'),
            onTap: (){
              _closeDrawer();
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  void _openDrawer(GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawerEnableOpenDragGesture: false,
      drawer: myDrawer(),
      appBar: myAppBar(_scaffoldKey),
      body:
        Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                child: ToggleButtons(
                  isSelected: isSelected,
                  onPressed: (index) {
                    // Respond to button selection
                    setState(() {
                      isSelected[index] = !isSelected[index];
                      if(index == 0){
                        isSelected[1] = !isSelected[1];
                      }else{
                        isSelected[0] = !isSelected[0];
                      }
                    });
                  },
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.list),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.grid_view),
                    ),
                  ],
                  color: Colors.black.withOpacity(0.60),
                  selectedColor: Colors.lightBlue,
                  selectedBorderColor: Colors.lightBlue,
                  fillColor: Colors.lightBlue.withOpacity(0.08),
                  splashColor: Colors.lightBlue.withOpacity(0.12),
                  hoverColor: Colors.lightBlue.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(4.0),
                  constraints: const BoxConstraints(minHeight: 36.0),
                ),
              ),
            ),
            Expanded(
              child: whichView(isSelected),
            ),
          ],
        ),
      // Center(
      resizeToAvoidBottomInset: false,
    );
  }

  List<Card> _buildListCards(BuildContext context) {
    List<Hotel> hotels = HotelsRepository.loadHotels(Category.all);

    if (hotels.isEmpty) {
      return const <Card>[];
    }

    return hotels.map((hotel) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
              child: ClipRRect(
                borderRadius:
                  BorderRadius.circular(10.0),
                clipBehavior: Clip.hardEdge,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    minHeight: 80,
                    maxWidth: 100,
                    maxHeight: 80,
                  ),
                  child: Image.asset(
                    hotel.assetName,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: List.generate(hotel.star, (index){
                              return const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 10,
                              );
                            }),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 80,
                          ),
                          child: Column(
                            children: [
                              Text(
                                hotel.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                              ),Text(
                                hotel.location,
                                style: const TextStyle(
                                  fontSize: 8,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
            ),
            Column(
              children: [
                const SizedBox(height: 60.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(hotel: hotel,),
                      ),
                    );
                  },
                  child: const Text(
                    'more',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    // padding: const EdgeInsets.all(0.0),
                    minimumSize: const Size(5, 5),
                  ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();

  }

  whichView(List<bool> isSelected) {
    if(isSelected[0] == true){
      return ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: _buildListCards(context),
      );
    }else{
      return OrientationBuilder(
        builder: (context, orientation){
          return GridView.count(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            childAspectRatio: 8.0 / 9.0,
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            children: _buildGridCards(context),
          );
        },
      );
    }
  }
}