import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/banner.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final CarouselController _infoCarouselController = CarouselController();
  // dummy data
  List<Map<String, dynamic>> jsonData = [
    {
      'type': 10,
      'thumbnail': 'assets/banner_1.jpg',
      'tag': '신작',
      'color': '#A62B1F',
      'webtoon': {
        'title': '화산귀환',
        'id': 'w0n230do23m',
        'artist': '화산광견',
      },
    },
    {
      'type': 10,
      'thumbnail': 'assets/banner_2.jpg',
      'tag': '신작',
      'color': '#D96941',
      'webtoon': {
        'title': '청춘만개',
        'id': 'w0n230do33m',
        'artist': 'ALTO',
      },
    },
    {
      'type': 20,
      'thumbnail': 'assets/banner_3.jpg',
      'tag': 'EVENT',
      'color': '#193C40',
      'title': '첫번째 이벤트! 두꺼비집 허만강',
      'content': 'assets/banner_3.jpg',
    },
    {
      'type': 20,
      'thumbnail': 'assets/banner_4.jpg',
      'tag': '매일+',
      'color': '#F2668B',
      'title': '두번째 이벤트! 킬러경찰 이제환 / 이문균',
      'content': 'assets/banner_4.jpg',
    },
  ];

  late List<BannerModel> banners;

  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    banners = jsonData
        .map((jsonItem) => BannerModel.fromTypedJson(jsonItem))
        .toList();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      periodicSwitch();
    });
  }
  // @override
  // void initState() {
  //   super.initState();

  //   banners = jsonData
  //       .map((jsonItem) => BannerModel.fromTypedJson(jsonItem))
  //       .toList();

  //   Future.delayed(Duration.zero, () {
  //     periodicSwitch();
  //   });
  // }

  void periodicSwitch() async {
    while (mounted) {
      await Future.delayed(const Duration(seconds: 5));
      if (!mounted) return;
      if (_currentIndex < jsonData.length - 1) {
        setState(() {
          _currentIndex++;
        });
      } else {
        setState(() {
          _currentIndex = 0;
        });
      }

      setState(() {
        _infoCarouselController.animateToPage(_currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.linearToEaseOut);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: ShaderMask(
            key: ValueKey<int>(_currentIndex),
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment(0.0, 0.8),
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
                stops: [0.0, 1],
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(banners[_currentIndex].thumbnail),
                  fit: BoxFit.cover,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: 260,
            ),
          ),
        ),
        // Positioned(
        //   top: 50,
        //   left: MediaQuery.of(context).size.width * 0.03,
        //   child: Image.asset(
        //     'assets/icon_cookie.png',
        //     width: 25,
        //   ),
        // ),
        Positioned(
          bottom: 50,
          right: MediaQuery.of(context).size.width * 0.03,
          child: Container(
            height: 20,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 8,
            ),
            child: Row(
              children: [
                Text(
                  (_currentIndex + 1).toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const RotationTransition(
                  turns: AlwaysStoppedAnimation(20 / 360),
                  child: Text(
                    "/",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                // Transform.rotate(
                //   angle: ,
                //   child: const Text(
                //     '/',
                //     style: TextStyle(
                //       color: Colors.white70,
                //       fontSize: 12,
                //       fontWeight: FontWeight.w800,
                //     ),
                //   ),
                // ),
                Text(
                  banners.length.toString(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          // top: 215,
          bottom: 0,
          left: 0,
          right: 0,
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) => true,
            child: CarouselSlider(
              carouselController: _infoCarouselController,
              options: CarouselOptions(
                height: 45,
                viewportFraction: 0.95,
                enableInfiniteScroll: true,
                scrollPhysics: const NeverScrollableScrollPhysics(),
              ),
              items: banners.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      margin: const EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: banner.color,
                        //color: Colors.white,
                        //color: boxColors[],
                        boxShadow: const [],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(2)),
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                banner.tag,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              banner is EventBannerModel
                                  ? banner.title
                                  : banner is WebtoonBannerModel
                                      ? banner.webtoon.title
                                      : '',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              banner is EventBannerModel
                                  ? ''
                                  : banner is WebtoonBannerModel
                                      ? banner.webtoon.artist
                                      : '',
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.3,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
