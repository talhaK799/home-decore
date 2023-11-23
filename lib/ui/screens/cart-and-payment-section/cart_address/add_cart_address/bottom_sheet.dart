import 'package:f2_base_project/core/constants/colors.dart';
import 'package:f2_base_project/core/constants/lists.dart';
import 'package:f2_base_project/core/constants/strings.dart';
import 'package:f2_base_project/core/constants/styles.dart';
import 'package:f2_base_project/core/others/screen_uitls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'add_cart_address_viewmodel.dart';

class CitiesBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddCartAddressViewModel(),
      child: Consumer<AddCartAddressViewModel>(
        builder: (context, model, child) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    child: Container(
                      height: 49.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xFFCFCFCF))),
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          model.searchByName(value);
                        },
                        decoration: InputDecoration(
                            prefixIcon: UnconstrainedBox(
                              child: Padding(
                                padding: EdgeInsets.only(left: 7.0, right: 3),
                                child: Image(
                                  image: AssetImage(
                                    '$staticAssets/search_black.png',
                                  ),
                                  height: 19.h,
                                  width: 19.w,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                            hintText: 'search_city'.tr,
                            hintStyle: normalTextStyleLato.copyWith(
                                color: Color(0xFFCFCFCF))),
                      ),
                    ),
                  ),
                  model.isSearching
                      ? citiesList(model.searchedCities, model)
                      : citiesList(cities, model)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  citiesList(List<String> cities, AddCartAddressViewModel model) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: cities.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    Get.back(result: '${cities[index]}');
                  },
                  leading: Text('${cities[index]}',
                      style: bodyTextStyleLato.copyWith(
                          fontSize: 18.sp, color: primaryColor)),
                ),
                Divider(color: greyColor.withOpacity(0.5))
              ],
            );
          }),
    );
  }
}
