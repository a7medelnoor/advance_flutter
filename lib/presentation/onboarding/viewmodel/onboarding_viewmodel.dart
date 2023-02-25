import 'dart:async';

import 'package:advance_flutter/domain/model.dart';
import 'package:advance_flutter/presentation/base/baseviewmodel.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutput{
  // stream controller outputs
StreamController streamController = StreamController<SliderViewObject>();
  // OnBoarding view model inputs
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => throw UnimplementedError();


  // on boarding view mode outputs
  @override
  // TODO: implement outputSliderViewObject
  Stream get outputSliderViewObject => throw UnimplementedError();
}

// inputs mean (orders) that our view model receive from the view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user click on right arrow or swipe left
  void goPrevious(); // when user click on left arrow or swipe right
  void onPageChanged(int index);
  // stream controller input
Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  // stream controller outputs
  Stream get outputSliderViewObject;
}

