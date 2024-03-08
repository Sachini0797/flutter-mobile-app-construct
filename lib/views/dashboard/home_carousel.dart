import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {

  late final PageController pageController;
  int currenIndex = 0;
  List<String> images = [
    "https://cdn.pixabay.com/photo/2019/02/06/16/32/architect-3979490_960_720.jpg",
    "https://cdn.pixabay.com/photo/2015/07/28/20/55/tools-864983_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/02/01/21/15/excavator-1174428_960_720.jpg",
  ];
  List<String> bannerLinks = ["https://www.w3schools.com/", "https://pub.dev/packages/flutter_floating_bottom_bar/example" ,"https://dribbble.com/shots/13945993-Devent-Login"];

  late final Timer carouselTimer;


  bool showControl = true;
  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (currenIndex == images.length) {
        currenIndex = 0;
      }
      try{
        pageController.animateToPage(currenIndex,
            duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
        currenIndex++;
      }catch(e){

      }

    });
  }
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    if(images.length != 1){
      carouselTimer = getTimer();
    } else {
      // pageController;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
    child: Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 150,
              width: double.infinity,
              child: (images.length ==1)?
              Container(child: Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  // height: 100,
                  width: double.infinity,
                  clipBehavior: Clip.hardEdge,

                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child:
                  GestureDetector(
                    onTap: () async {
                      _launched = _launchInBrowser(
                          Uri.parse(bannerLinks[0]));
                    },
                    child: CachedNetworkImage(
                      imageUrl: images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),):PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currenIndex = index % images.length;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      // height: 100,
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,

                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child:
                      GestureDetector(
                        onTap: () async {
                          _launched = _launchInBrowser(
                              Uri.parse(bannerLinks[index]));
                        },
                        child: CachedNetworkImage(
                          imageUrl: images[index]!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              )



                // )

            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < images.length; i++)
                    buildIndicator(currenIndex == i)
                ],
              ),
            ),


          ],
        )
      ],
    ),);
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}
