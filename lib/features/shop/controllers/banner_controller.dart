
import 'package:e_commerce/data/repositories/banners/banner_respository.dart';
import 'package:e_commerce/features/shop/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRespository());

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index) => carouselCurrentIndex.value = index;

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final banners = await _bannerRepository.fetchBanners();
      this.banners.assignAll(banners);
    } catch (e) {
      throw e;
    } finally {
      isLoading.value = false;
    }
  }
}
