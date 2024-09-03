import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odc_mobile_project/m_user/business/model/OnboardingPageModel.dart';
import 'package:odc_mobile_project/m_user/ui/pages/onboarding/OnboardingCtrl.dart';
import 'package:odc_mobile_project/navigation/routers.dart';
import 'package:odc_mobile_project/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends ConsumerStatefulWidget {

  OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var ctrl = ref.read(onboardingCtrlProvider.notifier);
      await ctrl.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    var ctrl = ref.read(onboardingCtrlProvider.notifier);
    List<OnboardingPageModel> onboards = ctrl.getListOnboard();
    print(onboards);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: onboards[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: onboards.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final _item = onboards[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Image.asset(
                              _item.image,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(_item.title,
                                    style: TextStyle(color: _item.textColor, fontSize: 35, fontWeight: FontWeight.bold) ),
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(_item.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: _item.textColor, fontSize: 15, fontWeight: FontWeight.w400)),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: onboards
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == onboards.indexOf(item)
                              ? 20
                              : 4,
                          height: 4,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () async {
                          HapticFeedback.selectionClick();
                          var ctrl = ref.read(onboardingCtrlProvider.notifier);
                          await ctrl.terminateOnboard();

                          context.goNamed(Urls.auth.name);
                        },
                        child: Text(
                          "Passer",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                      onPressed: () async {
                        if (_currentPage == onboards.length - 1) {
                          HapticFeedback.selectionClick();
                          var ctrl = ref.read(onboardingCtrlProvider.notifier);
                          await ctrl.terminateOnboard();

                          context.goNamed(Urls.auth.name);


                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Text(
                        _currentPage == onboards.length - 1
                            ? "Terminer"
                            : "Suivant",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
