import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:f2_base_project/ui/custom_widgets/sliding_indication_dots.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AppBannersSlider extends StatefulWidget {
  final List<String>? image;
  final double? height;
  final bool? isCover;
  final bool? isArrowBack;
  final String? title;
  final bool? isReviewScreen;
  final bool? isRecentlyJoined;
  AppBannersSlider(
      {this.image,
      this.height,
      this.isArrowBack = false,
      this.isRecentlyJoined = false,
      this.isCover,
      this.title,
      this.isReviewScreen = false});
  @override
  _AppBannersSliderState createState() => _AppBannersSliderState();
}

class _AppBannersSliderState extends State<AppBannersSlider>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        child: CarouselSlider.builder(
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            itemCount: widget.image!.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) =>
                Container(
                  height: widget.height,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Container(
                            height: widget.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(24.0),
                              // image: DecorationImage(
                              //     image: AssetImage('${widget.image![index]}'),
                              //     fit: BoxFit.cover)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24),
                                  topLeft: Radius.circular(24)),
                              child: widget.image!.isEmpty
                                  ? Image.asset('$productPlaceHolder')
                                  : FadeInImage.assetNetwork(
                                      height: widget.height,
                                      width: double.infinity,
                                      placeholder: '$productPlaceHolder',
                                      image: '${widget.image![index]}',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )),

                      ///
                      /// Back, Share and Cart Icons
                      ///

                      // ///
                      // /// Indication Dots
                      // ///
                      // Container(
                      //     alignment: FractionalOffset(0.5, 0.83),
                      //     child: SlidingIndicationDots(
                      //         fillColor: Colors.white,
                      //         borderColor: Colors.white,
                      //         index: index,
                      //         currentImage: index)),
                    ],
                  ),
                ))

        /////////
        // CarouselSlider(
        // options: CarouselOptions(
        //   height: widget.height,
        //   viewportFraction: 1,
        //   initialPage: 0,
        //   enableInfiniteScroll: true,
        //   reverse: false,
        //   autoPlay: true,
        //   autoPlayInterval: Duration(seconds: 5),
        //   autoPlayAnimationDuration: Duration(milliseconds: 800),
        //   autoPlayCurve: Curves.fastOutSlowIn,
        //   scrollDirection: Axis.horizontal,
        // ),
        //   items: widget.image!.map((i) {
        //     return Builder(
        //       builder: (BuildContext context) {
        //         return Container(
        //           height: widget.height,
        //           width: MediaQuery.of(context).size.width,
        //           decoration: BoxDecoration(
        //             // border: Border.all(color: primaryColor),
        //             borderRadius: BorderRadius.circular(24.0),
        //             // image: DecorationImage(
        //             //     image: AssetImage('${widget.image![index]}'),
        //             //     fit: BoxFit.cover)),
        //           ),
        //           child: ClipRRect(
        //               borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(24),
        //                   topLeft: Radius.circular(24)),
        //               child: Image.asset('$i', fit: BoxFit.cover)
        //               // FadeInImage.assetNetwork(
        //               //   height: widget.height,
        //               //   width: double.infinity,
        //               //   placeholder: '$productPlaceHolder',
        //               //   image: '${widget.image![index]}',
        //               //   fit: BoxFit.cover,
        //               // ),
        //               ),
        //         );
        //       },
        //     );
        //   }).toList(),
        // )

        // DefaultTabController(
        //   length: 2,
        //   child:
        // Stack(
        //     children: <Widget>[
        //       Padding(
        //         padding: EdgeInsets.only(bottom: 12.h),
        //         child: TabBarView(
        //             controller: imagesController,
        //             children: List.generate(
        //                 widget.image!.length,
        // (index) => Container(
        //       height: widget.height,
        //       width: MediaQuery.of(context).size.width,
        //       decoration: BoxDecoration(
        //         // border: Border.all(color: primaryColor),
        //         borderRadius: BorderRadius.circular(24.0),
        //         // image: DecorationImage(
        //         //     image: AssetImage('${widget.image![index]}'),
        //         //     fit: BoxFit.cover)),
        //       ),
        //       child: ClipRRect(
        //           borderRadius: BorderRadius.only(
        //               topRight: Radius.circular(24),
        //               topLeft: Radius.circular(24)),
        //           child: Image.asset('${widget.image![index]}',
        //               fit: BoxFit.cover)
        //           // FadeInImage.assetNetwork(
        //           //   height: widget.height,
        //           //   width: double.infinity,
        //           //   placeholder: '$productPlaceHolder',
        //           //   image: '${widget.image![index]}',
        //           //   fit: BoxFit.cover,
        //           // ),
        //           ),
        //                     ))),
        //       ),

        //       ///
        //       /// Back, Share and Cart Icons
        //       ///

        //       ///
        //       /// Indication Dots
        //       ///
        //       Container(
        //         alignment: FractionalOffset(0.5, 0.84),
        //         child: TabPageSelector(
        //           controller: imagesController,
        //           selectedColor: Colors.white,
        //           color: Colors.transparent,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
