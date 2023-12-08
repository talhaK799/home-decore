// ignore: must_be_immutable
import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/ui/custom_widgets/sliding_indication_dots.dart';
import 'package:f2_base_project/ui/screens/home/category_products/category_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersSlider extends StatefulWidget {
  final List<Offers> offers;
  final List<String> images;
  final model;
  OffersSlider({required this.offers, required this.images, this.model});

  @override
  _OffersSliderState createState() => _OffersSliderState();
}

class _OffersSliderState extends State<OffersSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      child: Stack(
        children: [
          Container(
            height: 250.h,
            child: PageView.builder(
                controller: widget.model.pageController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.images.length,
                onPageChanged: (int index) {
                  setState(() {
                    widget.model.currentImage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategProdScreen(
                                    '${widget.offers[index].category}',widget.offers[index].id,
                                    isFromOffers: true,
                                    offer: widget.offers[index])));
                      },
                      child: FadeInImage.assetNetwork(
                        placeholder: '$productPlaceHolder',
                        image: '${widget.images[index]}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          ),

          ///
          /// Indication Dots
          ///
          Positioned(
            top: 260,
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Container(
                      height: 20.h,
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.images.length,
                          itemBuilder: (context, index) {
                            return SlidingIndicationDots(
                              index: index,
                              currentImage: widget.model.currentImage,
                              height: 12.03,
                              width: 12.03,
                              fillColor: primaryColor,
                              borderColor: primaryColor,
                            );
                          })),
                  SizedBox(width: 15 * (widget.images.length).toDouble()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
