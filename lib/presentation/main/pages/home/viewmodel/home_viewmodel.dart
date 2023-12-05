import 'dart:async';
import 'dart:ffi';

import 'package:advance_flutter/domain/model/model.dart';
import 'package:advance_flutter/domain/usecase/home_use_case.dart';
import 'package:advance_flutter/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_rander/state_randerer.dart';
import '../../../../common/state_rander/state_randerer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutPut {
  final  _homeViewStreamController =
      BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // inputs
  @override
  void start() {
    _getHomeData();
  }

   _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message))
            }, (homeObject) {
      // right -> success (data)
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.stores,
          homeObject.data.services, homeObject.data.banners));
    });
  }

  @override
  void dispose() {
    _homeViewStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _homeViewStreamController.sink;

  // outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _homeViewStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutPut {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
