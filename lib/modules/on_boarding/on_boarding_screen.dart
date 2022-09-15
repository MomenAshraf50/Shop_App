import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/modules/log_in/log_in_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Screen One',
        image: 'assets/images/shopping.png',
        body: 'body one'),
    BoardingModel(
        title: 'Screen Two',
        image: 'assets/images/online_groceries.png',
        body: 'body two'),
    BoardingModel(
        title: 'Screen Three',
        image: 'assets/images/order_confirmed.png',
        body: 'body three'),
  ];

  PageController boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: (){
              onBoardingSkipped();
            }, child:const Text('Skip'))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  onPageChanged: (int index){
                    if(index == boarding.length-1){
                      setState((){
                        isLast = true;
                      });
                    }else{
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) => buildOnBoardingItem(index),
                  itemCount: 3,
                ),
              ),
              SmoothPageIndicator(
                controller: boardingController,
                count: boarding.length,
                effect:const WormEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 12.0,
                  dotWidth: 12.0,
                  spacing: 5,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast){
                        onBoardingSkipped();
                      }else{
                        boardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildOnBoardingItem(int index) => Column(
        children: [
          Expanded(child: Image(image: AssetImage(boarding[index].image))),
          Text(
            boarding[index].title,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            boarding[index].body,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      );

  void onBoardingSkipped(){
    CacheHelper.saveData(key: 'onBoardingSkipped', value: true).then((value){
      if(value){
        navigateToAndFinish(context, LogInScreen());
      }
    });
  }
}
