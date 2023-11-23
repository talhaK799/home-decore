import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/image-container.dart';
import 'package:f2_base_project/ui/screens/cart-and-payment-section/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageSlider extends StatefulWidget {
  final String? image;
  final double? height;
  final bool? isCover;
  final bool? isArrowBack;
  final String? title;
  final bool? isReviewScreen;
  final bool? isRecentlyJoined;
  ImageSlider(
      {this.image,
      this.height,
      this.isArrowBack = false,
      this.isRecentlyJoined = false,
      this.isCover,
      this.title,
      this.isReviewScreen = false});
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController imagesController = TabController(length: 4, vsync: this);
    return Container(
      height: widget.height,
      child: DefaultTabController(
        length: 2,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: TabBarView(
                controller: imagesController,
                children: widget.isRecentlyJoined!
                    ? List.generate(
                        4,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 28.0),
                              child: Container(
                                // height: 140.h,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    // border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(24.0),
                                    image: DecorationImage(
                                        image: AssetImage('${widget.image}'),
                                        fit: BoxFit.fill)),
                              ),
                            ))
                    : <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset('${widget.image}',
                                fit: widget.isCover!
                                    ? BoxFit.cover
                                    : BoxFit.contain)),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset('${widget.image}',
                              fit: widget.isCover!
                                  ? BoxFit.cover
                                  : BoxFit.contain),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset('${widget.image}',
                              fit: widget.isCover!
                                  ? BoxFit.cover
                                  : BoxFit.contain),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset('${widget.image}',
                              fit: widget.isCover!
                                  ? BoxFit.cover
                                  : BoxFit.contain),
                        ),
                      ],
              ),
            ),

            ///
            /// Back, Share and Cart Icons
            ///
            widget.isArrowBack!
                ? Container(
                    height: 114.h,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.keyboard_arrow_left,
                                    color: primaryColor, size: 30.h),
                                onPressed: () => Get.back()),
                            Text('${widget.title}',
                                style: bodyTextStyleLato.copyWith(fontSize: 20.sp)),
                          ],
                        ),
                        Row(
                          children: [
                            widget.isReviewScreen!
                                ? Container()
                                : IconButton(
                                    icon: Icon(Icons.shopping_cart,
                                        color: Colors.black, size: 22.h),
                                    onPressed: () {
                                      Get.to(() => CartScreen());
                                    }),
                            IconButton(
                                icon: Icon(
                                  Icons.share,
                                  color: Colors.black,
                                  size: 22.h,
                                ),
                                onPressed: null),
                          ],
                        )
                      ],
                    ),
                  )
                : Container(),

            ///
            /// Indication Dots
            ///
            Container(
              alignment: widget.isCover!
                  ? FractionalOffset(0.5, 0.78)
                  : widget.isArrowBack!
                      ? FractionalOffset(0.5, 0.78)
                      : FractionalOffset(0.5, 1.2),
              child: TabPageSelector(
                controller: imagesController,
                selectedColor: widget.isCover!
                    ? Colors.white
                    : widget.isArrowBack!
                        ? Colors.white
                        : primaryColor,
                color: Colors.transparent,
              ),
            ),

            ///
            /// FUll Screen Icon
            ///
            widget.isArrowBack!
                ? Container(
                    alignment: FractionalOffset(0.93, 0.78),
                    child: GestureDetector(
                        onTap: () {
                          Get.to(
                              () => FullImageScreen(
                                    image: widget.image,
                                  ),
                              transition: Transition.zoom);
                        },
                        child: Icon(Icons.fullscreen,
                            size: 28.h, color: Colors.white)),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String? image;
  const FullImageScreen({Key? key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Color(0xFFE3E3E3),
          image:
              DecorationImage(image: AssetImage("$image"), fit: BoxFit.cover)),
    );
  }
}
