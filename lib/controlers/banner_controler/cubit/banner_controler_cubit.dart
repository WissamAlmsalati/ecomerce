import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../moudels/banner/bannerModule.dart';
import '../../../moudels/banner/banner_repostry.dart';

part 'banner_controler_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerRepostry _bannerRepostry = BannerRepostry();
  int _currentPage = 0;
  Timer? _timer;
  final PageController _pageController = PageController();

  BannerCubit() : super(BannerInitial()) {
    _startTimer();
  }

  // other methods...

  void updatePageController() {
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  PageController get pageController => _pageController;



void _startTimer() {
  _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    _currentPage = (_currentPage + 1) % (state as BannerLoaded).banners.length;
    emit(BannerLoaded((state as BannerLoaded).banners, _currentPage));
    updatePageController();
  });
}

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  void fetchBanner() async {
    try {
      emit(BannerLoading());
      List<BannerMoudule> bannerMoudules = await _bannerRepostry.fetchData();
      emit(BannerLoaded(bannerMoudules, _currentPage));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }

  void addBanner(BannerMoudule banner) async {
    try {
      emit(BannerLoading());
      await _bannerRepostry.addBanner(banner);
      fetchBanner();
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }

  void updateCurrentPage(int page) {
    _currentPage = page;
    if (state is BannerLoaded) {
      emit(BannerLoaded((state as BannerLoaded).banners, _currentPage));
    }
  }
}