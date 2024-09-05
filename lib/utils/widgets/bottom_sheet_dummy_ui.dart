import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odc_mobile_project/utils/size_config.dart';
import 'package:odc_mobile_project/utils/common.dart';

class BottomSheetDummyUI extends ConsumerStatefulWidget {
  BottomSheetDummyUI({
    super.key,
    required this.leftLayout,
    required this.firstWidget,
    this.secondWidget = null,
    this.thirdWidget = null,
    this.fourthWidget = null,
  });
  Widget leftLayout;
  Widget firstWidget;
  Widget? secondWidget;
  Widget? thirdWidget;
  Widget? fourthWidget;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomSheetDummyUIState();
}

class _BottomSheetDummyUIState extends ConsumerState<BottomSheetDummyUI> {
  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    var block = AppSizes.screenWidth;
    var leftLayout = AppSizes.screenWidth / 3.5;
    var rightLayout = AppSizes.screenWidth / 1.5;

    return Container(
      color: Colors.white,
      width: block,
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
                    child: widget.leftLayout,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: Container(
                  width: rightLayout,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Container(
                          color: Colors.black12,
                          height: 20,
                          width: 240,
                          child: widget.firstWidget,
                        ),
                      ),
                      if (widget.secondWidget != null)
                        Column(
                          children: [
                            SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                color: Colors.black12,
                                height: 20,
                                width: 240,
                                child: widget.secondWidget,
                              ),
                            ),
                          ],
                        ),
                      if (widget.thirdWidget != null)
                        Column(
                          children: [
                            SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                color: Colors.black12,
                                height: 20,
                                width: 240,
                                child: widget.thirdWidget,
                              ),
                            ),
                          ],
                        ),
                      if (widget.fourthWidget != null)
                        Column(
                          children: [
                            SizedBox(height: 5),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                color: Colors.black12,
                                height: 20,
                                width: AppSizes.screenWidth / 4,
                                child: widget.fourthWidget,
                              ),
                            ),
                          ],
                        ),
                      // SizedBox(height: 50),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
