import 'package:eventhub/views/event_screen.dart';
import 'package:eventhub/views/home_screen.dart';
import 'package:eventhub/views/map_screen.dart';
import 'package:eventhub/views/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List<Widget> widgetList = [
    HomeScreen(),
    EventScreen(),
    MapScreen(),
    ProfileScreen(),
  ];
  void isSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
