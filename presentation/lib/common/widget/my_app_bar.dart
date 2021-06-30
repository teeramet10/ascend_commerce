import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/common/navigation/screen_navigation_service.dart';

import '../app_colors.dart';
import '../app_images.dart';
class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  MyAppBar({required this.title, this.canBack = false,  this.bottom ,this.onBackPress})
      : super();

  final String title;
  VoidCallback? onBackPress;
  PreferredSizeWidget? bottom;
  bool canBack;

  @override
  MyAppBarState createState() => MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(48);
}

class MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        bottom: widget.bottom,
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        leading: widget.canBack ? InkWell(
          child: Image.asset(AppImages.ic_back, package: AppImages.package,),
          onTap: () {

            if(widget.canBack){
              if(widget.onBackPress != null){
                widget.onBackPress!();
                return;
              }
              GetIt.I<ScreenNavigationService>().navigateBack();
              return;
            }
          },
        ):Container(),
        title: Text(
            widget.title,
            style: TextStyle(fontSize: 23 , color: AppColors.white) // medium,
        ));
  }
}
