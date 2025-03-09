import 'package:e_commerce/common/widgets/appbar/appbar.dart';
import 'package:e_commerce/common/widgets/loaders/animation_loader.dart';
import 'package:e_commerce/common/widgets/loaders/loaders.dart';
import 'package:e_commerce/features/personalization/controllers/cupon_controller.dart';
import 'package:e_commerce/features/personalization/screens/cupon/widgets/cupon_card_widgets.dart';
import 'package:e_commerce/utils/constants/image_string.dart';
import 'package:e_commerce/utils/constants/sizes.dart';
import 'package:e_commerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class CuponScreen extends StatelessWidget {
  const CuponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CuponController.instance;
    return Scaffold(
      appBar: TAppBar(
        title: Text("Kuponlarım",
            style: Theme.of(context).textTheme.headlineSmall),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
      child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
      child: FutureBuilder(future: controller.fetchCupons(), builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return SizedBox(
            height: THelperFunctions.screenHeight()/2,
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }
        if(snapshot.hasError){
           print("🔥 Hata: ${snapshot.error}"); // Hata detayını görmek için
          TLoaders.warningSnacbar(title: "Kupon Yükleme Başarısız Oldu", message: snapshot.error.toString());
            return Center(child: Text("Bir hata oluştu"));
        }
      
        if(snapshot.data!.isEmpty){
          return TAnimationLoaderWidget(
            text: "Size Özel Kupon Bulunmamaktadır.",
            animation: TImages.orderCompletedAnimation,
          );
        }else{
          final cupons = snapshot.data!;
         return ListView.separated(
          itemCount: cupons.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: TSizes.spaceBtwItems,),
          itemBuilder: (context, index) => TCuponCardWidget(cupon: cupons[index],),
      );
           }
      },
      ),
      )
    ),
    );
  }
}

