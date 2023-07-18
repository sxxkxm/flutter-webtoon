import 'package:flutter/material.dart';
import 'package:webtoon/screens/search_page.dart';
import 'package:webtoon/widgets/home_banner.dart';
import 'package:webtoon/widgets/home_navbar.dart';
import '../models/webtoon.dart';
import '../services/api_service.dart';
import '../widgets/webtoon_widget.dart';
import 'cookie_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showTitle = false; // 타이틀 보이기 여부를 나타내는 변수
  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              if (scrollNotification.metrics.pixels > 145) {
                _showTitle = true;
              } else {
                _showTitle = false;
              }
              print(scrollNotification.metrics.pixels);
            });
          }
          return false;
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: const FlexibleSpaceBar(
                background: Stack(
                  children: [
                    HomeBanner(),
                  ],
                ),
              ),
              leading: IconButton(
                icon: Image.asset(
                  'assets/icon_cookie.png',
                  width: 26,
                  height: 26,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CookiePage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              title: _showTitle
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_left,
                            size: 28,
                          ),
                        ),
                        const Text("인기순"),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right,
                            size: 28,
                          ),
                        ),
                      ],
                    )
                  : null,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                minHeight: 45.0,
                maxHeight: 45.0,
                child: const HomeNavBar(),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 0.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return FutureBuilder(
                    future: webtoons,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var webtoon = snapshot.data![index];
                        return Webtoon(
                          title: webtoon.title,
                          thumb: webtoon.thumb,
                          id: webtoon.id,
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                },
                childCount:
                    100, // This should be replaced with the count of items you are expecting from the API.
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

// import 'package:flutter/material.dart';
// import 'package:webtoon/screens/search_page.dart';
// import 'package:webtoon/widgets/home_banner.dart';
// import 'package:webtoon/widgets/home_navbar.dart';
// import '../models/webtoon.dart';
// import '../services/api_service.dart';
// import '../widgets/webtoon_widget.dart';
// import 'cookie_page.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool _showTitle = false; // 타이틀 보이기 여부를 나타내는 변수
//   // double titleOpacity = 0.0;
//   final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: NotificationListener<ScrollNotification>(
//         onNotification: (scrollNotification) {
//           if (scrollNotification is ScrollUpdateNotification) {
//             setState(() {
//               if (scrollNotification.metrics.pixels > 145) {
//                 _showTitle = true;
//               } else {
//                 _showTitle = false;
//               }
//               // if (scrollNotification.metrics.pixels > 0.0) {
//               //   titleOpacity = 1.0;
//               // } else {
//               //   titleOpacity = 0.0;
//               // }
//               // print('titleOpacity: $titleOpacity');
//               print(scrollNotification.metrics.pixels);
//             });
//           }
//           return false;
//         },
//         child: CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               pinned: true,
//               floating: true,
//               // snap: true,
//               expandedHeight: 200.0,
//               flexibleSpace: const FlexibleSpaceBar(
//                 background: Stack(
//                   children: [
//                     HomeBanner(),
//                     //  HomeAppBar(),
//                   ],
//                 ),
//               ),
//               leading: IconButton(
//                 icon: Image.asset(
//                   'assets/icon_cookie.png',
//                   width: 26,
//                   height: 26,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CookiePage(),
//                       fullscreenDialog: true,
//                     ),
//                   );
//                 },
//               ),
//               title: _showTitle
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.arrow_left,
//                             size: 28,
//                           ),
//                         ),
//                         const Text("인기순"),
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.arrow_right,
//                             size: 28,
//                           ),
//                         ),
//                       ],
//                     )
//                   : null,
//               // title: Row(
//               //   mainAxisAlignment: MainAxisAlignment.center,
//               //   children: [
//               //     IconButton(
//               //       onPressed: () {},
//               //       icon: const Icon(
//               //         Icons.arrow_left,
//               //         size: 28,
//               //       ),
//               //     ),
//               //     const Text("인기순"),
//               //     IconButton(
//               //       onPressed: () {},
//               //       icon: const Icon(
//               //         Icons.arrow_right,
//               //         size: 28,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               actions: <Widget>[
//                 IconButton(
//                   icon: const Icon(
//                     Icons.search,
//                     size: 28,
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SearchPage(),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//             SliverPersistentHeader(
//               pinned: true,
//               delegate: _SliverAppBarDelegate(
//                 minHeight: 45.0,
//                 maxHeight: 45.0,
//                 child: Column(
//                   children: [
//                     const HomeNavBar(),
//                     Expanded(
//                       child: Container(
//                         decoration: const BoxDecoration(color: Colors.red),
//                         height: 2000,
//                         child: FutureBuilder(
//                           future: webtoons,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return NotificationListener<ScrollNotification>(
//                                 // onNotification: (scrollNotification) => true,
//                                 child: GridView.builder(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 10,
//                                     horizontal: 20,
//                                   ),
//                                   scrollDirection: Axis.vertical,
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 3,
//                                     crossAxisSpacing: 8.0,
//                                     mainAxisSpacing: 4.0,
//                                     childAspectRatio: 0.6,
//                                   ),
//                                   itemCount: snapshot.data!.length,
//                                   itemBuilder: (context, index) {
//                                     var webtoon = snapshot.data![index];
//                                     return Webtoon(
//                                       title: webtoon.title,
//                                       thumb: webtoon.thumb,
//                                       id: webtoon.id,
//                                     );
//                                   },
//                                 ),
//                               );
//                             } else {
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // SliverFillRemaining(
//             //   child: Container(
//             //     // decoration: const BoxDecoration(color: Colors.red),
//             //     // height: 2000,
//             //     child: FutureBuilder(
//             //       future: webtoons,
//             //       builder: (context, snapshot) {
//             //         if (snapshot.hasData) {
//             //           return NotificationListener<ScrollNotification>(
//             //             // onNotification: (scrollNotification) => true,
//             //             child: GridView.builder(
//             //               padding: const EdgeInsets.symmetric(
//             //                 vertical: 10,
//             //                 horizontal: 20,
//             //               ),
//             //               scrollDirection: Axis.vertical,
//             //               gridDelegate:
//             //                   const SliverGridDelegateWithFixedCrossAxisCount(
//             //                 crossAxisCount: 3,
//             //                 crossAxisSpacing: 8.0,
//             //                 mainAxisSpacing: 4.0,
//             //                 childAspectRatio: 0.6,
//             //               ),
//             //               itemCount: snapshot.data!.length,
//             //               itemBuilder: (context, index) {
//             //                 var webtoon = snapshot.data![index];
//             //                 return Webtoon(
//             //                   title: webtoon.title,
//             //                   thumb: webtoon.thumb,
//             //                   id: webtoon.id,
//             //                 );
//             //               },
//             //             ),
//             //           );
//             //         } else {
//             //           return const Center(
//             //             child: CircularProgressIndicator(),
//             //           );
//             //         }
//             //       },
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   _SliverAppBarDelegate(
//       {required this.minHeight, required this.maxHeight, required this.child});

//   final double minHeight;
//   final double maxHeight;
//   final Widget child;

//   @override
//   double get minExtent => minHeight;

//   @override
//   double get maxExtent => maxHeight;

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return SizedBox.expand(child: child);
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return maxHeight != oldDelegate.maxHeight ||
//         minHeight != oldDelegate.minHeight ||
//         child != oldDelegate.child;
//   }
// }
