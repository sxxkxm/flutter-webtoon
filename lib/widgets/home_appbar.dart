import 'package:flutter/material.dart';
import 'package:webtoon/screens/cookie_page.dart';
import 'package:webtoon/screens/search_page.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Hero(
          tag: "home_appbar_cookie_icon",
          child: IconButton(
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
        ),
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
    );
  }
}
