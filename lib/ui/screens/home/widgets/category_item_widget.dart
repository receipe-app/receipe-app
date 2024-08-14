import 'package:flutter/widgets.dart';
import 'package:receipe_app/core/utils/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CategoryItemWidget extends StatelessWidget {
  final bool isTapped;
  final String categoryName;
  final void Function() onTap;

  const CategoryItemWidget({
    super.key,
    required this.isTapped,
    required this.categoryName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isTapped ? AppColors.primary100 : AppColors.white,
        ),
        child: Center(
          child: Text(
            categoryName,
            style: TextStyle(
              color: isTapped ? AppColors.white : AppColors.primary100,
            ),
          ),
        ),
      ),
    );
  }
}
