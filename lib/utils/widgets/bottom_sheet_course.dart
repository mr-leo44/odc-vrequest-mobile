import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:odc_mobile_project/m_chat/ui/pages/ChatDetail/ChatDetailCtrl.dart';
import 'package:odc_mobile_project/m_course/business/Course.dart';
import 'package:odc_mobile_project/shared/ui/pages/shared/SharedCtrl.dart';
import 'package:odc_mobile_project/utils/size_config.dart';

class BottomSheetCourse extends ConsumerStatefulWidget {
  BottomSheetCourse({super.key, required this.course});
  Course course;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetCourseState();
}

class _BottomSheetCourseState extends ConsumerState<BottomSheetCourse> {
  Future<void> startCourse() async {
    var ctrl = ref.read(chatDetailCtrlProvider.notifier);
    var started = await ctrl.startCourse(widget.course);
    Widget display;
    if (started) {
      display = Text('Le debut de la course a ete signale avec succes');
    } else {
      display = Text('La course a deja commence');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: display,
      ),
    );
  }

  Future<void> closeCourse() async {
    var ctrl = ref.read(chatDetailCtrlProvider.notifier);
    var started = await ctrl.closeCourse(widget.course);
    Widget display;
    if (started) {
      display = Text('La fin de la course a ete signale avec succes');
    } else {
      display = Text('La course est deja termine');
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: display,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    var block = AppSizes.screenWidth;
    var leftLayout = AppSizes.screenWidth / 3.5;
    var rightLayout = AppSizes.screenWidth / 1.5;
    var ctrlState = ref.watch(chatDetailCtrlProvider);
    var animation = "assets/animations/animation1.json";

    if (ctrlState.courseStarted && !ctrlState.courseClosed) {
      animation = "assets/animations/animation2.json";
    } else if (ctrlState.courseStarted && ctrlState.courseClosed) {
      animation = "assets/animations/animation3.json";
    }

    var sharedState = ref.watch(sharedCtrlProvider);
    print(sharedState.location);
    var auth = sharedState.auth?.role;

    return Container(
      color: Colors.white,
      width: AppSizes.screenWidth,
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: 100,
                    width: 100,
                    child: Center(
                      child: LottieBuilder.asset(animation),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Debuter',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        CupertinoSwitch(
                            activeColor: Colors.green.shade400,
                            value: ctrlState.courseStarted,
                            onChanged: (val) {
                              HapticFeedback.selectionClick();
                              if (auth != null &&
                                  auth.any((e) => e.contains('chauffeur'))) {
                                _startCourseDialog(context, ref, startCourse);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Vous n'etes pas autorise"),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.black12,
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Terminer',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        CupertinoSwitch(
                            activeColor: Colors.red.shade400,
                            value: ctrlState.courseClosed,
                            onChanged: (val) {
                              HapticFeedback.selectionClick();
                              if (auth != null &&
                                  auth.any((e) => e.contains('chauffeur'))) {
                                _closeCourseDialog(context, ref, closeCourse);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Vous n'etes pas autorise"),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _startCourseDialog(
    BuildContext context, WidgetRef ref, startCourse) {
  var ctrlState = ref.watch(chatDetailCtrlProvider);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Debuter la course'),
        content: const Text(
          'Etes-vous sur de vouloir debuter la course maintenant ?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Oui'),
            onPressed: () {
              if ((!ctrlState.courseStarted) && (!ctrlState.courseClosed)) {
                startCourse();
              } else if (ctrlState.courseStarted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("La course a deja commence"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "On peut pas recommencer une course qui a deja ete termine"),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _closeCourseDialog(
    BuildContext context, WidgetRef ref, closeCourse) {
  var ctrlState = ref.watch(chatDetailCtrlProvider);

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Terminer la course'),
        content: const Text(
          'Etes-vous sur de vouloir terminer la course maintenant ?',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Oui'),
            onPressed: () {
              if ((ctrlState.courseStarted) && (!ctrlState.courseClosed)) {
                closeCourse();
              } else if (ctrlState.courseClosed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("La course est deja termine"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "On peut pas terminer une course qui n'a pas encore commence"),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
