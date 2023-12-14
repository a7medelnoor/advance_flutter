import 'package:flutter/cupertino.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({Key? key}) : super(key: key);

  @override
  _SettingsScreenViewState createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  final SettingsScreenViewModel _viewModel = instance<SettingsScreenViewModel>();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  void _bind(){
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapchot){
            return Container(
              child: snapchot.data?.getScreenWidget(context, _getContentWidget(), (){
                _viewModel.start();
              }) ??
                  Container(),
            );
          },
        ),
      ),
    );
  }
  Widget _getContentWidget(){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(AppStrings.storeDetails),
        elevation: AppSize.s0,
        iconTheme: IconThemeData(
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        centerTitle: true,
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        color:ColorManager.white,
        child: SingleChildScrollView(
          child: StreamBuilder<StoreDetailsModel>(
            stream: _viewModel.outputStoreDetails,
            builder: (context, snapshot){
              return _getItems(snapshot.data);
            },
          ),
        ),
      ),
    );
  }

  Widget _getItems(StoreDetailsModel? storeDetailsModel){
    if(storeDetailsModel != null){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              storeDetailsModel.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
          ),
          _getSection(AppStrings.details),
          _getInfoToText(storeDetailsModel.details),
          _getSection(AppStrings.services),
          _getInfoToText(storeDetailsModel.services),
          _getSection(AppStrings.about),
          _getInfoToText(storeDetailsModel.about),


        ],
      );
    }else {
      return Container();
    }
  }

  Widget _getSection(String title) {
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

  Widget _getInfoToText(String  info) {
    return Padding(padding: const EdgeInsets.all(AppSize.s12),
      child: Text(info, style: Theme.of(context).textTheme.bodySmall,),
    );
  }






}
