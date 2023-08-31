import 'package:advance_flutter/data/data_source/remote_data_source.dart';
import 'package:advance_flutter/data/repository/repository_impl.dart';
import 'package:advance_flutter/domain/repository/repository.dart';
import 'package:advance_flutter/domain/usecase/login_use_case.dart';
import 'package:advance_flutter/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:advance_flutter/presentation/resources/assests_manager.dart';
import 'package:advance_flutter/presentation/resources/color_manager.dart';
import 'package:advance_flutter/presentation/resources/routes_manager.dart';
import 'package:advance_flutter/presentation/resources/strings_manager.dart';
import 'package:advance_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

import '../../app/di.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  // instead of the below we will do di
  // RemoteDataSource _remoteDataSource = RemoteDataSourceImp(_appServiceClient);
  // Repository _repository = RepositoryImpl(_remoteDataSource, _networkInfo);
  // LoginUseCase _loginUseCase = LoginUseCase(_repository);
  // final LoginViewModel _viewModel = LoginViewModel(_loginUseCase);

   // get the dependencies form the instance
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  _bind() {
    // starting the view model
    _viewModel.start();
    // listen to the user input in login edit text
    // update the view mode with the user name and password
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
        body: Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: AppStrings.username,
                          labelText: AppStrings.username,
                          errorText: (snapshot.data ?? true)? null: AppStrings.usernameError,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          errorText: (snapshot.data ?? true)? null: AppStrings.passwordError,
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(onPressed:

                            (snapshot.data ?? false )
                            ? (){
                          _viewModel.login();
                        } : null
                        , child: const Text(AppStrings.login)),
                      );
                    }),
              ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppPadding.p8,
                left: AppPadding.p28, right: AppPadding.p12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.forgetPasswordRoute);
                  },
                  child: Text(
                    AppStrings.forgetPassword,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, Routes.registerRoute);
                  },
                  child: Text(
                    AppStrings.notMember,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            )),

            ],
          ),
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.dispose();
  }
}
