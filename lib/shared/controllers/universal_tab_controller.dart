import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'universal_tab_controller.g.dart';

class UniversalTabController = UniversalTabControllerBase with _$UniversalTabController;

abstract class UniversalTabControllerBase with Store {

  @observable
  TabController tabController;
}