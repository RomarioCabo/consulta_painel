import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:painel_cunsulta/constants/strings.dart';
import 'package:painel_cunsulta/shared/controllers/universal_tab_controller.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/repositories/local_storage_shared_preferences/local_storage_shared_preferences.dart';
import 'package:painel_cunsulta/ui/login/login_page.dart';
import 'package:painel_cunsulta/ui/tiles/drawer_tile.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  UniversalTabController _tabController;

  LocalStorageSharedPreferences _localStorageSharedPreferences;

  UserDto _user;

  @override
  void initState() {
    super.initState();

    _tabController = GetIt.I<UniversalTabController>();
    _localStorageSharedPreferences = GetIt.I<LocalStorageSharedPreferences>();

    _user = _localStorageSharedPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).cardColor,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.30,
        child: Drawer(
          child: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildMainOptions(context),
                  _buildLogout(context)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(context) {
    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            Container(
              height: 50,
              alignment: Alignment.bottomLeft,
              child: Image.asset(asset_image_logo),
            ),
            SizedBox(height: 30),
            Text(
              _getName(_user.name),
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 4),
            Text(
              _getEmail(_user.email),
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMainOptions(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTitle(context, title_session_options_drawer),
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: DrawerTile(
              title: textTab,
              icon: Icons.person,
              onTap: () {
                Navigator.pop(context);
                _tabController.tabController.animateTo(0);
              },
              selected: _tabController.tabController.index == 0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: DrawerTile(
              title: textTab2,
              icon: Icons.add_to_photos_rounded,
              onTap: () {
                Navigator.pop(context);
                _tabController.tabController.animateTo(1);
              },
              selected: _tabController.tabController.index == 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: DrawerTile(
              title: textTab3,
              icon: Icons.location_city,
              onTap: () {
                Navigator.pop(context);
                _tabController.tabController.animateTo(2);
              },
              selected: _tabController.tabController.index == 2,
            ),
          ),
          SizedBox(height: 12),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildLogout(context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 20),
          _buildTitle(context, title_session_account_drawer),
          SizedBox(height: 12),
          DrawerTile(
            title: drawer_log_out,
            icon: Icons.logout,
            onTap: () {
              Navigator.pop(context);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            selected: false,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
            color: Theme.of(context).textTheme.caption.color,
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  String _getName(String name) {
    return name.isEmpty ? default_user : name;
  }

  String _getEmail(String email) {
    return email.isEmpty ? default_email : email;
  }
}
