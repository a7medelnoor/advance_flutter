class LoginRequest{
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class RegisterRequest{
  String userName;
  String password;
  String countryMobileCode;
  String mobileNumber;
  String profilePicture;
  String email;

  RegisterRequest(this.userName, this.password, this.countryMobileCode,
      this.mobileNumber, this.profilePicture, this.email);
}

