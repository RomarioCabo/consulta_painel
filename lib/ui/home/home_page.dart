import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/controllers/universal_tab_controller.dart';
import 'package:painel_cunsulta/shared/models/widgets/tab_bar_item_model.dart';
import 'package:painel_cunsulta/ui/widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  UniversalTabController _tabController;

  List<TabBarItemModel> items = TabBarItemModel.generateList();

  @override
  void initState() {
    super.initState();
    _tabController = GetIt.I<UniversalTabController>();

    _tabController.tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            label_title_appbar,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).appBarTheme.textTheme.subtitle1.color,
              fontWeight: FontWeight.w900,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: _buildTabBarView(),
        drawer: CustomDrawer(),
      ),
    );
  }

  /// TabBarView
  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController.tabController,
      physics: NeverScrollableScrollPhysics(),
      children: items.map((TabBarItemModel item) {
        return item.tab;
      }).toList(),
    );
  }
}
