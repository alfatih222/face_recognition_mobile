import 'dart:io';
import 'package:facerecognition/utils/colors.dart';
import 'package:facerecognition/views/dashboard/dashboard.dart';
import 'package:facerecognition/views/history/history.dart';
import 'package:facerecognition/views/profile/profile.dart';
import 'package:flutter/material.dart';

class HomeNavbarButton extends StatefulWidget {
  const HomeNavbarButton({Key? key}) : super(key: key);

  @override
  State<HomeNavbarButton> createState() => _HomeNavbarButtonState();
}

class _HomeNavbarButtonState extends State<HomeNavbarButton> {
  int _currentIndex = 0;

  File? fileIdCard;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: 0,
            ),
            content: const Text('Yakin ingin keluar aplikasi ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Ya'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      DashboardView(),
      HistoryView(),
      ProfileView(),
    ];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: OprimaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff5C739F),
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xff5C739F)),
              label: 'Home',
              activeIcon: Icon(Icons.home, color: Colors.white),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history, color: Color(0xff5C739F)),
              label: 'History',
              activeIcon: Icon(Icons.history, color: Colors.white),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Color(0xff5C739F)),
              label: 'Akun',
              activeIcon: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
