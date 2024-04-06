import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../constance.dart';
import '../../../firebase/banner_controler_cubit.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() { // Trigger a rebuild
        _currentIndex = (_currentIndex + 1) % _pageController.positions.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return BannerCubit()..fetchBanner();
      },
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerInitial) {
            return CircularProgressIndicator();
          } else if (state is BannerLoaded) {
            return Column(
              children: [
                Container(
                  height: Constans.height(context) * 0.3,
                  width: Constans.width(context) * 0.96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.red,
                  ),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: state.banners.length,
                    itemBuilder: (context, index) {
                      return Image.memory(
                        base64Decode(state.banners[index].imageurl.split(',').last),
                        fit: BoxFit.cover,
                        height: Constans.height(context) * 0.3,
                      );
                    },
                  ),
                ),
                DotsIndicator(
                  dotsCount: state.banners.length,
                  position: _currentIndex,
                  decorator: DotsDecorator(
                    activeColor: Colors.red,
                  ),
                ),
              ],
            );
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }
}