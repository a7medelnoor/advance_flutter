
import 'package:advance_flutter/domain/model/model.dart';
import 'package:advance_flutter/presentation/common/state_rander/state_randerer_impl.dart';
import 'package:advance_flutter/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:advance_flutter/presentation/resources/color_manager.dart';
import 'package:advance_flutter/presentation/resources/routes_manager.dart';
import 'package:advance_flutter/presentation/resources/strings_manager.dart';
import 'package:advance_flutter/presentation/resources/values_manager.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../app/di.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();

    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            if (snapshot.data is LoadingState) {
              print("HOMEISSUE LoadingState snapchot data${snapshot.data}");

            }
            else if (snapshot.data is ErrorState) {
              print("HOMEISSUE ErrorState snapchot data${snapshot.data}");

            }
            print("HOMEISSUE SingleChildScrollView snapchot data${snapshot.data}");
            return snapshot.data?.getScreenWidget(context, _getContentWidgets(),
                    () {
                  _viewModel.start();
                }) ??
                Container();
          },
        ),
      ),
    );
  }
  Widget _buildErrorWidget(String errorMessage) {
    return Center(
      child: Text('Error: $errorMessage'),
    );
  }
  Widget _buildLoadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _getContentWidgets() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBanner(snapshot.data?.banners),
              _getSection(AppStrings.services.tr()),
              _getServicesWidget(snapshot.data?.services),
              _getSection(AppStrings.stores.tr()),
              _getStoresWidget(snapshot.data?.stores),
            ],
          );

        });
  }

  Widget _getSection(String title) {
    print("HOMEISSUE   _getSection"+title.toString());

    return Padding(
      padding: EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _getBanner(List<BannerAd>? banners) {
    print("HOMEISSUE"+banners.toString());
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
            width: double.infinity,
            child: Card(
              elevation: AppSize.s1_5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  side: BorderSide(
                      color: ColorManager.white, width: AppSize.s1_5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: Image.network(
                  banner.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s190,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }

  Widget _getServicesWidget(List<Service>? services) {
    print("HOMEISSUE"+services.toString());

    if (services != null) {
      return Padding(
        padding: EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
              elevation: AppSize.s4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  side: BorderSide(
                      color: ColorManager.white, width: AppSize.s1_5)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(
                      service.image,
                      fit: BoxFit.cover,
                      width: AppSize.s120,
                      height: AppSize.s100,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppPadding.p8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        service.title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoresWidget(List<Store>? stores) {
    print("HOMEISSUE"+stores.toString());

    if (stores != null) {
      return Padding(
        padding: EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}