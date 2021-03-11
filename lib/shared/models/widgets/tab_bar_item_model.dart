import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/ui/user/user_page.dart';

class TabBarItemModel {
  int index;
  String title;
  IconData icon;
  Widget tab;

  TabBarItemModel({this.index, this.title, this.icon, this.tab});

  static List<TabBarItemModel> generateList() {
    return [
      TabBarItemModel(
        index: 0,
        title: textTab,
        icon: Icons.person,
        tab: UserPage(),
      ),
      TabBarItemModel(
        index: 1,
        title: textTab2,
        icon: Icons.add_to_photos_rounded,
        tab: Container(),
      ),
      TabBarItemModel(
        index: 2,
        title: textTab3,
        icon: Icons.location_city,
        tab: Container(),
      ),
    ];
  }
}
