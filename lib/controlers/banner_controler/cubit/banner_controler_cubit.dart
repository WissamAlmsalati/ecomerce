import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipes/moudels/banner/banner_repostry.dart';
import 'package:banner_carousel/banner_carousel.dart';

part 'banner_controler_state.dart';giffwfwepkfk
class BannerCubit extends Cubit<BannerState> {
  final BannerRepostry _bannerRepostry = BannerRepostry();

  BannerCubit() : super(BannerInitial());

  void fetchBanner() async { // Update method name to fetchBanner
    try {
      emit(BannerLoading());
      List<BannerMoudule> bannerMoudules = await _bannerRepostry.fetchData();
      emit(BannerLoaded(bannerMoudules));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }

  void addBanner(BannerMoudule banner) async {
    try {
      emit(BannerLoading());
      await _bannerRepostry.addBanner(banner);
      fetchBanner(); // Update method call to fetchBanner
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }
}
