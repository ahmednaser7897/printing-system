import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:print_system/view/components/app_colors.dart';
import 'package:print_system/view/components/app_theme.dart';
import 'package:print_system/view/components/default_button.dart';
import 'package:print_system/view/login/login_screen.dart';

import '../../model/shared_preferences/shared_preferences.dart';
import '../components/app_text_styles.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Map<String, String>> introContent = [
    {
      "imgPath": "assets/images/balance.png",
      "text": "Load Balancing, printing job is divided between printers"
    },
    {
      "imgPath": "assets/images/secure.png",
      "text": "Authenticate Users, enables secure printing"
    },
    {
      "imgPath": "assets/images/download.png",
      "text": "Easy To Install and Use , Optimizing Printing workflow"
    },
    {
      "imgPath": "assets/images/credit.png",
      "text": "User can recharge his wallet"
    },
  ];
  CarouselController buttonCarouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              items: List.generate(
                  introContent.length,
                  (index) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            introContent[index]["imgPath"]!,
                            fit: BoxFit.cover,
                            height: 150,
                            width: 150,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            introContent[index]["text"]!,
                            overflow: TextOverflow.fade,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title()
                                .copyWith(color: Colors.grey.shade700),
                          ),
                        ],
                      )),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                  initialPage: 0,
                  enlargeCenterPage: true,
                  aspectRatio: 1,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: DotsIndicator(
                dotsCount: introContent.length,
                position: currentIndex.toDouble(),
                decorator: DotsDecorator(
                    color: const Color(0xffCCCCCC),
                    activeColor: AppColors.primaryColor,
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DefaultButton(
                    textColor: Colors.white,
                    buttonColor: AppColors.primaryColor,
                    borderRadius: 50,
                    buttonHeight: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Get Started",
                          style: AppTextStyles.bodyText()
                              .copyWith(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white)
                      ],
                    ),
                    buttonMinWidth: 0,
                    onPress: () {
                      CachHelper.setData(key: 'boarding', value: true)
                          .then((value) {
                        if (value) {
                          navigatorAndEnd(context, LoginScreen());
                        }
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
