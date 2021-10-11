import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'model/hotel.dart';
import 'globals.dart' as globals;

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.hotel, }) : super(key: key);

  final Hotel hotel;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  bool isHeart = false;

  final overlays = <OverlayEntry>[];

  Future<void> addOverlay() async {
    overlays.add(overlayEntry);
    Overlay.of(context)!.insert(overlays.last);

    await Future.delayed(const Duration(seconds: 1));

    overlays.removeLast().remove();
  }

  void removeOverlay(){
    if(overlays.isNotEmpty) overlays.removeLast().remove();
  }

  OverlayEntry get overlayEntry{
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 7.95,
        width: MediaQuery.of(context).size.width / 0.54,
        child: const Icon(
          Icons.favorite,
          color: Colors.red,
          size: 40.0,
          semanticLabel: 'Text to announce in accessibility modes',
        ),
      ),
    );
  }

  checkFavorite() {
    if(globals.isFavorite.contains(widget.hotel) == true){
      addOverlay();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.hotel.assetName,
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Detail'),
          ),
          body: ListView(
            children: [
              InkWell(
                onDoubleTap: (){
                  if(globals.isFavorite.contains(widget.hotel) == false){
                    // addOverlay();
                    globals.isFavorite.add(widget.hotel);
                  }else if(globals.isFavorite.contains(widget.hotel) == true){
                    // removeOverlay();
                    globals.isFavorite.remove(widget.hotel);
                  }

                  setState(() {
                    isHeart = !isHeart;
                  });
                },
                child: Stack(
                  children: [
                    Image.asset(
                      widget.hotel.assetName,
                      width: 600,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 10,
                      left: 340,
                      child: Icon(
                        globals.isFavorite.contains(widget.hotel) ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    InfoSection(hotel: widget.hotel,),
                    const Divider(
                      height: 1.0,
                      color: Colors.black,
                    ),
                    DiscSection(hotel: widget.hotel,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoSection extends StatefulWidget {
  const InfoSection({Key? key, required this.hotel}) : super(key: key);

  final Hotel hotel;

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection>{
  bool selected = false;
  int count = 41;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(widget.hotel.star, (index){
              return const Icon(
                Icons.star,
                color: Colors.yellow,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  widget.hotel.name,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
              repeatForever: true,
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(
                        Icons.map,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Text(
                      widget.hotel.location,
                      style: const TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Icon(
                        Icons.phone,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Text(
                      widget.hotel.number,
                      style: const TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DiscSection extends StatefulWidget {
  const DiscSection({Key? key, required this.hotel}) : super(key: key);

  final Hotel hotel;

  @override
  State<DiscSection> createState() => _DiscSectionState();
}

class _DiscSectionState extends State<DiscSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: Text(
        widget.hotel.description,
        style: const TextStyle(
          color: Colors.lightBlue,
        ),
      ),
    );
  }
}