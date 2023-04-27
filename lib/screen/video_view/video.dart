import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'content.dart';

class VIDEO extends StatefulWidget {
  @override
  State<VIDEO> createState() => _VIDEOState();
}

class _VIDEOState extends State<VIDEO>{
  final List<String> videos = [
    'https://assets.mixkit.co/videos/preview/mixkit-capsule-packing-machine-in-a-factory-4750-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-futuristic-diagrams-of-dna-scans-in-modern-lab-5579-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-nurse-talks-with-woman-laying-in-hospital-bed-5568-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-couple-meditating-on-the-sand-on-a-beach-44517-large.mp4',
    'https://assets.mixkit.co/videos/preview/mixkit-scientist-in-a-laboratory-preparing-a-sample-4767-large.mp4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              //We need swiper for every content
              Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ContentScreen(
                    src: videos[index],
                  );
                },
                itemCount: videos.length,
                scrollDirection: Axis.vertical,
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: Get.width*0.05,vertical: Get.height*0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Video',
                      style: TextStyle(
                        fontSize: Get.width*0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

class LikeIcon extends StatefulWidget {

  @override
  State<LikeIcon> createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {


  @override
  Widget build(BuildContext context) {

    bool _isFavorite = false;
    return Center(
      child: InkWell(
        onTap: () {
         setState(() {
           _isFavorite=!_isFavorite;
         });
        },
        child: _isFavorite==true?Icon(Icons.favorite):Icon(Icons.favorite_border),
      )
    );
  }
}
