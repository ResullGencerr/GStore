import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/device/device_utility.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({
    super.key,
    required this.tabs,
  });

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        indicatorColor: TColors.primary,
        tabAlignment: TabAlignment.center,
        unselectedLabelColor: TColors.darkerGrey,
        labelColor: THelperFunctions.isDarkMode(context)
            ? TColors.white
            : TColors.primary,
        tabs: tabs);
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(TDeviceUtility.getAppBarHeight());
}
