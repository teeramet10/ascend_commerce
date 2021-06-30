import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/app_colors.dart';

class LoadingIndicator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(AppColors.primary),),
    );
  }
}