import 'package:flutter/material.dart';
import 'package:shoping/models/on_board_model.dart';
import 'package:shoping/modules/login/login.dart';
import 'package:shoping/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    List<OnBoardModel> onboard = const [
      OnBoardModel(
        image: 'assets/images/onboard1.png',
        subTitle: "page 1",
        title: "sub page 1",
      ),
      OnBoardModel(
        image: 'assets/images/onboard1.png',
        subTitle: "page 2",
        title: "sub page 2",
      ),
      OnBoardModel(
        image: 'assets/images/onboard1.png',
        subTitle: "page 3",
        title: "sub page 3",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                  );
                  CashHelper.putData(
                    key: 'onBoard',
                    value: true,
                  );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 16),
                )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage(onboard[index].image),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        onboard[index].title,
                        style: const TextStyle(
                          fontSize: 26,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        onboard[index].subTitle,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  );
                },
                itemCount: onboard.length,
              ),
            ),
            const SizedBox(
              height: 75,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).primaryColor,
                      dotColor: Colors.grey,
                      dotHeight: 12,
                      dotWidth: 12,
                      expansionFactor: 4,
                      spacing: 5),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (pageController.page == 2) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext ctx) => const LoginScreen()));
                      CashHelper.putData(
                        key: 'onBoard',
                        value: true,
                      );
                    }
                    pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn);
                  },
                  shape: const CircleBorder(),
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
