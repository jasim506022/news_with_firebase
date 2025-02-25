import '../model/onboard_model.dart';
import '../res/app_colors.dart';
import '../res/app_images.dart';
import '../res/app_string.dart';

class OnbaordingDataList {
  static List<OnboardModel> onboardModeList = [
    OnboardModel(
        image: AppImages.pageOneImage,
        title: AppString.pageOneTitle,
        description: AppString.pageOneDescription,
        backgroundColor: AppColors.white,
        buttonBackgroundColor: AppColors.black),
    OnboardModel(
        image: AppImages.pageTwoImage,
        title: AppString.pageTwoTitle,
        description: AppString.pageTwoDescription,
        backgroundColor: AppColors.black,
        buttonBackgroundColor: AppColors.white),
    OnboardModel(
        image: AppImages.pageThreeImage,
        title: AppString.pageThreeTitle,
        description: AppString.pageThreeDescription,
        backgroundColor: AppColors.black,
        buttonBackgroundColor: AppColors.black)
  ];
}
