import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../../constance.dart';
import '../../../controlers/banner_controler/cubit/banner_controler_cubit.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final constants = Constans(context);

    return BlocProvider(
      create: (BuildContext context) {
        return BannerCubit()..fetchBanner();
      },
      child: BlocBuilder<BannerCubit, BannerState>(
        builder: (context, state) {
          if (state is BannerInitial) {
            return const CircularProgressIndicator();
          } else if (state is BannerLoaded) {
            return Column(
              children: [
                Container(
                  height: constants.height * 0.2,
                  width: constants.width * 0.96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: PageView.builder(
                      controller: context.read<BannerCubit>().pageController,
                      onPageChanged: (index) {
                        context.read<BannerCubit>().updateCurrentPage(index);
                      },
                      itemCount: state.banners.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          state.banners[index].imageurl,
                          fit: BoxFit.cover,
                          height: constants.height * 0.3,
                        );
                      },
                    ),
                  ),
                ),
                constants.samllmediumSizedBoxHeight,
                state.banners.isNotEmpty
                    ? DotsIndicator(
                        dotsCount: state.banners.length,
                        position: state.currentPage,
                        decorator: const DotsDecorator(
                          color: Colors.grey,
                          activeColor: Colors.brown,
                        ),
                      )
                    : const SizedBox(),
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
