import 'package:flutter/material.dart';
import 'package:painel_cunsulta/constants/colors.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  final bool selected;

  DrawerTile({
    @required this.title,
    @required this.icon,
    @required this.onTap,
    @required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8),
      color: selected ? colorPrimary : Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: selected
                    ? Colors.white
                    : Theme.of(context).tabBarTheme.unselectedLabelColor,
                size: 24,
              ),
              SizedBox(width: 16),
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: selected
                          ? Colors.white
                          : Theme.of(context).tabBarTheme.unselectedLabelColor,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
