import 'dart:async';

import 'package:advance_flutter/presentation/common/state_rander/state_randerer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // Shared variables and functions that will be used in any view model
      StreamController _inputStreamController = BehaviorSubject<FlowState>();
      @override
  Sink get inputState => _inputStreamController.sink;
      @override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
      @override
  void dispose() {
    _inputStreamController.close();
  }
}
abstract class BaseViewModelInputs{
void start(); // start view model job

void dispose(); // when the view model dies this will be called

Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}