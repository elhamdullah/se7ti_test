import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_123/core/constants/navigation.dart';
import 'package:se7ety_123/core/services/local_storage.dart';
import 'package:se7ety_123/core/utils/colors.dart';
import 'package:se7ety_123/core/utils/text_style.dart';
import 'package:se7ety_123/core/widgets/custom_button.dart';
import 'package:se7ety_123/feature/intro/onboarding/model/onboarding_model.dart';
import 'package:se7ety_123/feature/intro/welcome/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var pagrController = PageController();
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          //if (pageIndex != onboardingPage.length - 1)
          TextButton(
              onPressed: () {
                AppLocalStorage.cacheData(
                    key: AppLocalStorage.kOnboarding, value: true);
                pushReplacement(context, const WelcomeScreen());
              },
              child: Text(
                "تخطي",
                style: getBodyStyle(
                    color: AppColors.color1, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pagrController,
                onPageChanged: (value) {
                  pageIndex = value;
                },
                itemCount: onboardingPage.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Spacer(),
                      SvgPicture.asset(
                        onboardingPage[index].image,
                        height: 300,
                      ),
                      const Spacer(),
                      Text(onboardingPage[index].title,
                          style: getTitleStyle(color: AppColors.color1)),
                      const Gap(20),
                      Text(
                        onboardingPage[index].description,
                        textAlign: TextAlign.center,
                        style: getBodyStyle(),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: pagrController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      spacing: 5,
                      dotColor: Colors.grey,
                      activeDotColor: AppColors.color1,
                    ),
                  ),
                  const Spacer(),
                  //if (pageIndex == onboardingPage.length - 1)
                  CustomButton(
                      height: 40,
                      width: 100,
                      radius: 10,
                      text: "هيا بنا",
                      onPressed: () {
                         AppLocalStorage.cacheData(
                    key: AppLocalStorage.kOnboarding, value: true);
                pushReplacement(context, const WelcomeScreen());
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
