import '../../data/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class StoreDetailsUseCase implements BaseUseCase<StoreDetailsUseCaseInput, Authentication>{

  final Repository _repository;
  StoreDetailsUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(StoreDetailsUseCaseInput input)  async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}
class StoreDetailsUseCaseInput {
  String email;
  String password;

  StoreDetailsUseCaseInput(this.email, this.password);
}