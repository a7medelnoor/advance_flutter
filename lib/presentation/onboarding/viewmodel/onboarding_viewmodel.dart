import 'dart:async';
import 'dart:ffi';

import 'package:advance_flutter/domain/model.dart';
import 'package:advance_flutter/presentation/base/baseviewmodel.dart';

import '../../resources/assests_manager.dart';
import '../../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInputs, OnBoardingViewModelOutput{
  // stream controller outputs
final StreamController _streamController = StreamController<SliderViewObject>();
late final List<SliderObject> _list;
int _currentPageIndex = 0;

  // OnBoarding view model inputs
  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
  // view model start your job
    // initialize the list
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentPageIndex;
    if(nextIndex == _list.length){
      nextIndex =0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentPageIndex;
    if(previousIndex == -1){
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    // update the current index
    _currentPageIndex = index;
    // post the new data to the view
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;


  // on boarding view mode outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);
  // On boarding private function
   void _postDataToView(){
     inputSliderViewObject.add(SliderViewObject(_list[_currentPageIndex], _list.length,_currentPageIndex));
   }
List<SliderObject> _getSliderData() => [
  SliderObject(AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubTitle1, ImageAssets.onboardingImage1),
  SliderObject(AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubTitle2, ImageAssets.onboardingImage2),
  SliderObject(AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubTitle3, ImageAssets.onboardingImage3),
  SliderObject(AppStrings.onBoardingTitle4,
      AppStrings.onBoardingSubTitle4, ImageAssets.onboardingImage4)
];

}



// inputs mean (orders) that our view model receive from the view
abstract class OnBoardingViewModelInputs {
  int goNext(); // when user click on right arrow or swipe left
  int goPrevious(); // when user click on left arrow or swipe right
  void onPageChanged(int index);
  // stream controller input
Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutput {
  // stream controller outputs
  Stream<SliderViewObject> get outputSliderViewObject;

}

