
import 'package:card_scanner/views/widgets/CustomBackButton/custom_back_button.dart';
import 'package:card_scanner/views/widgets/customText/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AllCardsScreen extends StatelessWidget {
  AllCardsScreen({super.key});

  List cardDetailsList = [
    {"image": "https://img.freepik.com/free-photo/bohemian-man-with-his-arms-crossed_1368-3542.jpg?t=st=1711008338~exp=1711011938~hmac=3a05225c2a75c0c003c9f09d51c3fbb6cda1d0189f31e94c8f72555a28854f63&w=826", "name" : "Michael Chen", "companyName" : "XYZ Tech Solutions", "designation" : "Senior Software Engineer" },
    {"image": "https://img.freepik.com/free-photo/portrait-young-businesswoman-holding-eyeglasses-hand-against-gray-backdrop_23-2148029483.jpg?t=st=1711008375~exp=1711011975~hmac=511516ca747144f164ba632e645a5e64ec5b83132241f31a387017b30764cff6&w=826", "name" : "Emily Rodriguez", "companyName" : "Global Finance Group", "designation" : "Financial Analyst" },
    {"image": "https://img.freepik.com/free-photo/portrait-beautiful-young-woman-standing-grey-wall_231208-10760.jpg?t=st=1711008418~exp=1711012018~hmac=0e5c69783af897de4032dee9e55d26366c4a747abe603bbdf93c1d64cd208b47&w=1380", "name" : "Lisa Nguyen", "companyName" : "Stellar Designs LLC", "designation" : "Creative Director" },
    {"image": "https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1711008542~exp=1711012142~hmac=afea31d365b7fa53a9d58b0ec23eea74c9345bd7f5f47a3dccb3d3da3875d1cc&w=1380", "name" : "Jason Patel", "companyName" : "Dynamic Innovations", "designation" : "Product Manager" },
    {"image": "https://img.freepik.com/free-photo/smiling-young-man-with-crossed-arms-outdoors_1140-255.jpg?t=st=1711008499~exp=1711012099~hmac=c12dca7e167d885c574847a9de6a9207f4733664cef37d5780e582715b6340ad&w=826", "name" : "Kevin Miller", "companyName" : "Sparkle Marketing Agency", "designation" : "Sales Manager" },
    {"image": "https://img.freepik.com/premium-psd/woman-with-pink-jacket-her-chest-stands-front-grid-with-words-brand-it_176841-37276.jpg?w=826", "name" : "Jessica Martinez", "companyName" : "Elite Ventures Group", "designation" : "Financial Controller" },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                  child:CustomBackButton(
                    onTap: (){
                      Get.back();
                    },
                    icon: Icons.arrow_back,
                  ),
              ),
              SizedBox(height: 20.h),

              ///<<<================== Digital Card List ===================>>>

              Expanded(
                child: ListView.builder(
                  itemCount: cardDetailsList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: Get.width,
                        height: 100.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r)
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 90.h,
                              width: 90.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                image: DecorationImage(fit: BoxFit.cover,image: NetworkImage(cardDetailsList[index]["image"])),
                              ),
                            ),
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 16.w),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 SizedBox(height: 8.h,),
                                 CustomText(
                                   text: cardDetailsList[index]["name"],
                                   fontSize: 24,
                                   fontWeight: FontWeight.w500,
                                 ),
                                 SizedBox(height: 4.h,),
                                 CustomText(
                                   text: cardDetailsList[index]["companyName"],
                                 ),
                                 CustomText(
                                   text: cardDetailsList[index]["designation"],
                                 ),
                               ],
                             ),
                           )
                          ],
                        ),
                      );
                    },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
