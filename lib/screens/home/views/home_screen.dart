import 'package:apps/screens/home/views/main_screen.dart';
import 'package:apps/screens/stats/stats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Color unselectedItem = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          onTap: (p) {
            setState(() {
              index = p;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
                color: index == 0
                    ? Theme.of(context).colorScheme.primary
                    : unselectedItem,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.graph_square_fill,
                color: index == 1
                    ? Theme.of(context).colorScheme.primary
                    : unselectedItem,
              ),
              label: "Stats",
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(3.14 / 4),
            ),
          ),
          child: const Icon(CupertinoIcons.add, color: Colors.white, size: 30),
        ),
      ),
      body: index == 0 ? MainScreen(user: widget.user) : StatsScreen(),
    );
  }
}