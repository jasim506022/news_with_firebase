class AppString {
// Onboarding text
// Text variables for each onboarding screen
  static const String pageOneTitle = "Diverse News Sources";
  static const String pageOneDescription =
      "Discover a wide range of news sources, from reputable publications to local sources, all in one place.";

  static const String pageTwoTitle = "Bookmark and Save";
  static const String pageTwoDescription =
      "Easily bookmark articles and save them for later. Never lose track of an important story.";

  static const String pageThreeTitle = "Breaking News Alerts";
  static const String pageThreeDescription =
      "Stay ahead of the curve with real-time notifications for breaking stories.";

  // Button
  static const btnSkip = "Skip";
  static const btnNext = "Next";
  static const btnFinish = "Finish";
  static const btnLogin = "Login";
  static const btnSignUp = 'Sign Up';
  static const btnNo = 'No';
  static const btnYes = 'Yes';

  static const noInternet = 'No Internet';
  static const noInternetMessage =
      'Please check your internet settings and try again.';

// Validation
  // Email
  static const String emptyEmail = "Please enter your email address.";
  static const String invalidEmailFormat =
      "Invalid email format! Please enter a valid email.";
  static const String emailTooLong =
      "Email address is too long. Please enter a valid email.";
  // Password
  static const String emptyPassword = "Please enter your password.";
  static const String passwordTooShort =
      "Password must be at least 6 characters long.";
  static const String passwordTooLong = "Password cannot exceed 20 characters.";
  static const String passwordUppercase =
      "Password must contain at least one uppercase letter.";
  static const String passwordLowercase =
      "Password must contain at least one lowercase letter.";
  static const String passwordNumber =
      "Password must contain at least one number.";
  // Confirm Password
  static const String confirmPasswordRequired = "Please confirm your password.";
  static const String passwordMismatch =
      "Passwords do not match. Please re-enter.";
  // Name
  static const String emptyName = "Please enter your name.";
  static const String nameTooShort = "Name must be at least 2 characters long.";
  static const String nameTooLong = "Name cannot exceed 50 characters.";
  static const String nameInvalid = "Name can only contain letters and spaces.";

  static String doYouwantSignout = "Do you want to sign out?";

  // 📌 Hint Texts (For Input Fields)
  static const String emailHint = "Enter your email address";
  static const String passwordHint = "Enter your password";
  static const String confirmPasswordHint = "Re-enter your password";
  static const String nameHint = "Enter your full name";
  static const String phoneHint = "Phone Number";
  static const String searchHint = "Search...........";

  // 📌 Form Field Labels

  static const String emailLabel = "Email";
  static const String passwordLabel = "Password";
  static const String nameLabel = "Name";
  static const String passwordConfirmLabel = "Confirm Password";
  static const String phoneLabel = "Phone";
  static String darkLabel = "Dark";
  static String lightLabel = "Light";
  static const String signOutLabel = "Sign Out";

  // 📌 Success & Toast Messages
  static const String successSignUpMessage = "Sign up successful!";
  static const String successSignInMessage = "Sign in successful!";

  // Auth
  static const alreadHaveAAcount = "Already Have a Account?";

  // Other
  static const String news = "News";
  static const String ju = "JU";
  static const String topNews = "Top News";
  static const String seeAll = "See All";
  static const String allNews = "All News";

  // Dialog
  static const String exitDialogTitle = "Exit Application";
  static const String confirmExitMessage = "Are you sure  want to exit?";
}
