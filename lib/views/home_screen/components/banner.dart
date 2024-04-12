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
  int _currentPage = 0;
  int _pageCount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Start timer for automatic page transitions
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (_currentPage < _pageCount - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  void dispose() {
    // Cancel timer to prevent memory leaks
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final constans = Constans(context);

    return BlocProvider(
      create: (BuildContext context) {
        return BannerCubit()..fetchBanner();
      },
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerInitial) {
            return const CircularProgressIndicator();
          } else if (state is BannerLoaded) {
            _pageCount = state.banners.length; // Update the page count
            return Column(
              children: [
          Container(
  height: constans.height * 0.2,
  width: constans.width * 0.96,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
      itemCount: _pageCount,
      itemBuilder: (context, index) {
        return  Image.network(
          state.banners[index].imageurl,
          fit: BoxFit.cover,
          height: constans.height * 0.3,
        );
      },
    ),
  ),
),
                constans.samllmediumSizedBoxHeight,
                _pageCount > 0 ? DotsIndicator(
                  dotsCount: _pageCount,
                  position: _currentPage,
                  decorator: const DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.brown,
                  ),
                ): const SizedBox(),
              ],
            );
          } else {
            return const Text('Error');
          }
        },
      ),
    );
  }
}
