part of 'banner_controler_cubit.dart';

@immutable
abstract class BannerState {}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {}

class BannerLoaded extends BannerState {
  final List<BannerMoudule> banners;
  final int currentPage;

  BannerLoaded(this.banners, this.currentPage);
}

class BannerError extends BannerState {
  final String message;

  BannerError(this.message);
}

