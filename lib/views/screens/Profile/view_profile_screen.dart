
import 'package:card_scanner/utils/app_colors.dart';
import 'package:card_scanner/utils/app_icons.dart';
import 'package:card_scanner/utils/app_strings.dart';
import 'package:card_scanner/views/screens/Profile/IneerWidget/custom_container_button.dart';
import 'package:card_scanner/views/screens/Profile/edit_profile_screen.dart';
import 'package:card_scanner/views/screens/Profile/share_profile_card_screen.dart';
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customButton/custom_elevated_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomBackButton(onTap: (){
                    Get.back();
                  }),
                  CustomText(
                    text: AppStrings.eCard,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 30.w)
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: Get.width,
              color: AppColors.black_300,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 20.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            CustomText(
                              text: "Mostain Billah",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.green_50,
                            ),
                            CustomText(
                              text: "Ui-Ux Designer",
                              color: AppColors.green_50,
                            ),
                            CustomText(
                              text: "Sparktech.agency",
                              fontSize: 18,
                              color: AppColors.green_50,
                            ),
                          ],
                        ),
                        Spacer(),

                        ///<<<================= Company Logo ================>>>

                        Container(
                          height: 52.h,
                          width: 52.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/sparkTech.png"),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///<<<================= Profile Picture ================>>>

                    Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage("https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1711008338~exp=1711011938~hmac=3a05225c2a75c0c003c9f09d51c3fbb6cda1d0189f31e94c8f72555a28854f63&w=826"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              height: 92.h,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColors.green_200,
                borderRadius: BorderRadius.circular(12.r)
              ),

              ///<<<================= Mobile Number & Email =================>>>

              child: Column(
                children: [
                  Row(
                    children: [
                      CustomBackButton(
                        onTap: (){},
                        icon: Icons.phone_iphone_outlined,
                        radius: 100,
                        color: AppColors.black_500,
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(width: 8.w,),
                      CustomText(
                        text: "01956742586",
                        fontSize: 16,
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      CustomBackButton(
                        onTap: (){},
                        icon: Icons.attach_email_outlined,
                        radius: 100,
                        color: AppColors.black_500,
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(width: 8.w,),
                      CustomText(
                        text: "sparktechagency@gmail.com",
                        fontSize: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: Row(
                children: [

                  ///<<<=================== Edit Button ===================>>>

                  CustomContainerButton(
                    onTap: (){
                      Get.to(EditProfileScreen());
                    },
                    text: AppStrings.edit,
                    height: 48,
                    width: 110,
                    iconSize: 20,
                    fontSize: 16,
                    ifBorder: true,
                    backgroundColor: AppColors.black_500,
                    textColor: AppColors.black_500,
                    iconColor: AppColors.black_500,
                    farWidth: 8,
                    radius: 25,
                  ),
                  Spacer(),

                  ///<<<================= Share Card Button ================>>>

                  CustomContainerButton(
                    onTap: (){
                      Get.to(ShareProfileCardScreen());
                    },
                    text: AppStrings.shareCard,
                    ifImage: true,
                    svgIcon: AppIcons.sendIcon,
                    height: 48,
                    width: 180,
                    imageHeight: 20,
                    imageWidth: 20,
                    radius: 25,
                    fontSize: 16,
                    iconColor: AppColors.whiteColor,
                    textColor: AppColors.whiteColor,
                    farWidth: 8,
                    backgroundColor: AppColors.black_500,
                  )
                ],
              ),
            ),
            SizedBox(height: 48.h)
          ],
        ),
      ),
    );
  }
}
