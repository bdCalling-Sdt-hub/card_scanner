
class AppStrings{

  ///<<<================== OnBoarding Screen Texts ==========================>>>
  static String onBoardTitle1 = "Scanning Solutions for Shopping Success";
  static String onBoardTitle2 = "Simplified E-Commerce via Card Scanner ";
  static String onBoardTitle3 = "Scan and Shop with Ease";
  static String onBoardSubTitle1 = "Pioneering success through seamless scanning solutions for shoppers.";
  static String onBoardSubTitle2 = "Simplify e-commerce with a card scanner for effortless transactions and convenience.";
  static String onBoardSubTitle3 = "Scan products effortlessly and shop conveniently with our user-friendly system.";

  ///<<<=================== Auth Texts ======================================>>>
  static String signUpNOw = "Sign Up Now";
  static String fillTheDetails = "Please  fill the details and create account.";
  static String email = "Email";
  static String newPassword = "New Password";
  static String confirmNewPassword = "Confirm New Password";
  static String rememberMe = "Remember Me";
  static String forgotPassword = "Forgot Password";
  static String signInNow = "Sign In Now";
  static String signForExperience = "Sign in for new experiences";
  static String fullName = "Full Name";
  static String password = "Password";
  static String doNotHaveYouAccount = "Don’t have any account?";
  static String signUp = "Sign Up";
  static String enterYourEmail = "Please enter your email address to reset your password.";
  static String or = "OR";
  static String contactNumber = "Contact Number";
  static String enterMobileNumber = "Enter Mobile Number";
  static String getOtp = "Get OTP";


  ///<<<=================== Buttons Texts ===================================>>>
  static String backToSignInBtn = "Back to Sign In";
  static String skipBtn = "Skip";
  static String signInBtn = "Sign In";
  static String signUpBtn = "Sign UP";

  ///<<<================ Text Field Validation Texts ========================>>>
  static const enterEmail = "Email is required";
  static RegExp emailRegexp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String enterValidEmail = "Enter valid email";
  static const String fieldCantBeEmpty = "Field can't be empty";
  static const name = "Name";
  static const enterFullName = "Name is required";
  static const enterAddress = "Enter your address";
  static const wrongPassword = "Wrong password!!! Please enter your \ncurrent password";
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');
  static const String passMustContainBoth = "Password must be 8 characters long & contain both \nalphabets and numerics";
  static const String passDoesNotMatch = "Password does not match";
}