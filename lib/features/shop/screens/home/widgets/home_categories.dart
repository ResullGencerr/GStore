import 'package:e_commerce/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:e_commerce/common/widgets/shimmer/category_shimmer.dart';
import 'package:e_commerce/features/shop/controllers/category_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(() {
      return categoryController.isLoading.value
          ? TCategoryShimmer(itemCount: 6)
          : SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categoryController.featuredCategories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categoryController.featuredCategories[index];
                  return TVerticalImageText(
                    image: category.image,
                    title: category.name,
                    onTap: () => categoryController.fetchSubCategories(
                        category.id, category.name),
                  );
                },
              ),
            );
    });
  }
}
