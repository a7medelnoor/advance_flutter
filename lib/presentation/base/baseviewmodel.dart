abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // Shared variables and functions that will be used in any view model

}
abstract class BaseViewModelInputs{
void start(); // start view model job

void dispose(); // when the view model dies this will be called
}

abstract class BaseViewModelOutputs {

}