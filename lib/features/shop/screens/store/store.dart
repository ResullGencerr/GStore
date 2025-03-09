import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/appbar/tabbar.dart';
import 'package:e_commerce/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:e_commerce/common/widgets/layout/t_grid_layout.dart';
import 'package:e_commerce/common/widgets/products/TBrandCard/t_brand_cart.dart';
import 'package:e_commerce/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:e_commerce/common/widgets/shimmer/t_shimmer_effect.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/features/shop/controllers/brand_controller.dart';
import 'package:e_commerce/features/shop/controllers/category_controller.dart';
import 'package:e_commerce/features/shop/screens/brand/all_brands.dart';
import 'package:e_commerce/features/shop/screens/store/widgets/category_tab.dart';
import 'package:e_commerce/utils/constants/colors.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesController = CategoryController.instance;
    final brandsController = Get.put(BrandController());
    return DefaultTabController(
      length: categoriesController.featuredCategories.length,
      child: Scaffold(
        appBar: TAppBar(
          title: Text(
            "Mağazalar",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: THelperFunctions.isDarkMode(context)
                    ? TColors.black
                    : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Search Bar
                      SizedBox(height: TSizes.spaceBtwItems),
                      TSearchContainer(
                          text: "Mağazada Arayın",
                          showBackground: false,
                          padding: EdgeInsets.zero),
                      SizedBox(height: TSizes.spaceBtwSections),

                      // Featured Brands
                      TSectionHeading(
                        title: "Öne Çıkan Markalar",
                        onPressed: () => Get.to(() => AllBrandsScreen(
                              brand: brandsController.getAllBrands,
                            )),
                      ),
                      
                      TGridLayout(
                        itemCount:brandsController.isLoading.value 
                        ? 4 
                        : brandsController.getAllBrands.isNotEmpty
                        ? 4 
                        : 0,
                        mainAxisExtent: 80,
                        itemBuilder: (context, index) {
                          return Obx((){
                            if(brandsController.isLoading.value){
                              return TShimmerEffect(width: 30, height: 30);
                          }
                          else{
                            return TBrandCard(
                                showBorder: true,
                                onPressed: () => brandsController
                                    .goBrandProduct(brandsController
                                        .getAllBrands[index].id),
                                brand: brandsController.getAllBrands[index],
                              );
                          }
                          
                          });
                        },
                      ),
                    ],
                  ),
                ),
                bottom: TTabBar(
                  tabs: categoriesController.featuredCategories
                      .map((category) => Tab(child: Text(category.name)))
                      .toList(),
                ),
              ),
            ];
          },
          body: TabBarView(
              children: categoriesController.featuredCategories
                  .map((category) => TCategoryTab(category: category))
                  .toList()),
        ),
      ),
    );
  }
}
