import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import '../../../../locator.dart';

class SubCategoryViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final authService = locator<AuthService>();
  
  List<SubCategory> subCategory = [];

  SubCategoryViewModel(
      String category, String CategoryId) {
    getSubCategories(category,  CategoryId);
  }



  getSubCategories(String category, 
      String categoryId) async {
    print('object');
    setState(ViewState.busy);
    subCategory = await _dbService.getSubCategories(categoryId);
    print('........${subCategory.length}');

   
    setState(ViewState.idle);
  }

 

}
