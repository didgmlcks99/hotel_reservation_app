import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'detail.dart';
import 'globals.dart' as globals;
import 'model/hotel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{

  List<InkWell> _buildFavorites(BuildContext context) {
    List<Hotel> hotels = globals.isFavorite.toList();

    if(hotels.isEmpty){
      return const <InkWell>[];
    }

    return hotels.map((hotel){
      return InkWell(
        onTap : (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(hotel: hotel,),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(15.0),
                clipBehavior: Clip.hardEdge,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 500,
                    minWidth: 500,
                    maxHeight: 180,
                    minHeight: 180,
                  ),
                  child: Image.asset(
                    hotel.assetName,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: -140,
              width: 500,
              height: 200,
              child: Column(
                children: [
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    hotel.location,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Padding(
              // padding: const EdgeInsets.all(30),
               ClipOval(
                clipper: MyClipper(),
                child:  Lottie.asset(
                  'images/ghost.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            // ),
            Column(
              children: const [
                Text(
                  "Heechan Yang",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "21800436",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(25,20,0,10),
                child: Text(
                  "My Favorite Hotel List",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: _buildFavorites(context),
              )
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size){
    return const Rect.fromLTWH(50,50,110,110);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return false;
  }
}
