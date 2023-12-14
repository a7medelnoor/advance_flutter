import 'dart:ffi';

import 'package:advance_flutter/domain/model/model.dart';
import 'package:advance_flutter/domain/usecase/home_use_case.dart';
import 'package:advance_flutter/presentation/base/baseviewmodel.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../common/state_rander/state_randerer.dart';
import '../../../../common/state_rander/state_randerer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInputs, HomeViewModelOutputs {
  HomeUseCase _homeUseCase;

  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  HomeViewModel(this._homeUseCase) {
    _dataStreamController.add(HomeViewObject([], [], []));
  }
  // inputs
  @override
  void start() async{
    _getHome();
  }

  _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULL_SCREEN_LOADING_STATE));

    (await _homeUseCase.execute(Void)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.FULL_SCREEN_ERROR_STATE, failure.message));
      },
          (homeObject) {
        // Handle success
        inputState.add(ContentState());
        inputHomeData.add(HomeViewObject(
            homeObject.data.stores,
            homeObject.data.services,
            homeObject.data.banners));
      },
    );

  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}