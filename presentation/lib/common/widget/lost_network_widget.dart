import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:presentation/common/app_colors.dart';
import 'package:presentation/common/app_images.dart';

class LostNetworkWidget extends StatelessWidget {
  LostNetworkWidget({this.onTap});

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.asset(
              AppImages.ic_wifi,
              package: AppImages.package,
            ),
          ),
          Text(
            "Poor network connection detected\nPlease check your connectivity",
            style: TextStyle(color: AppColors.text_gray),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: Container(
              alignment: Alignment.center,
              height: 48,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary),
              child: Text(
                "Try Again",
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.w700),
              ),
            ),
            onTap: onTap,
          )
        ],
      ),
    );
  }
}
