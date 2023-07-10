import 'package:flutter/material.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  int _selectedIndex = 0;
  final navItems = ['신작', '월', '화', '수', '목', '금', '토', '일', '완결'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      // color: Colors.transparent,
      // color: Theme.of(context).primaryColor,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white10,
              width: 1.5,
            ),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          scrollDirection: Axis.horizontal,
          children: [
            for (var i = 0; i < navItems.length; i++)
              NavBarText(
                text: navItems[i],
                isSelected: i == _selectedIndex,
                onTap: () => setState(() => _selectedIndex = i),
              ),
          ],
        ),
      ),
    );
  }
}

class NavBarText extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const NavBarText({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: Colors.green, width: 2.5))
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? Colors.green
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ),
    );
  }
}
