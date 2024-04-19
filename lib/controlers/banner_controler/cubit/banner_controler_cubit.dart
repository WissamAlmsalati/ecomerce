import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../moudels/banner/banner_module.dart';
import '../../../moudels/banner/banner_repostry.dart';

part 'banner_controler_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannerRepostry _bannerRepostry = BannerRepostry();
  int _currentPage = 0;
  Timer? _timer;
  final PageController _pageController = PageController();
  List<BannerMoudule> _banners = []; // Add this line

  BannerCubit() : super(BannerInitial()) {
    fetchBanner();
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
      if (state is BannerLoaded) {
        _currentPage =
            (_currentPage + 1) % (state as BannerLoaded).banners.length;
        emit(BannerLoaded(_banners, _currentPage));
        updatePageController();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  Future<void> fetchBanner() async {
    try {
      emit(BannerLoading());
      _banners = await _bannerRepostry.fetchData(); // Store banners in _banners
      emit(BannerLoaded(_banners, _currentPage));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }

  void addBanner(BannerMoudule banner) async {
    try {
      emit(BannerLoading());
      await _bannerRepostry.addBanner(banner);
      _banners.add(banner); // Add the new banner to _banners
      emit(BannerLoaded(_banners, _currentPage));
    } catch (e) {
      emit(BannerError(e.toString()));
    }
  }

  void updateCurrentPage(int index) {
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}
