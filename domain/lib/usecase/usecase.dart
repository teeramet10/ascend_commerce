abstract class UseCase<UserCaseRequest , UserCaseResponse>{
  Future<UserCaseResponse> call(UserCaseRequest params);
}

class UserCaseRequest {

}

class UserCaseResponse {

}