import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/faqs.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/locator.dart';
import 'package:f2_base_project/ui/dialogs/request_failed_dialog.dart';
import 'package:get/get.dart';

class FaqsViewModel extends BaseViewModel {
  List<Faqs> faqs = [];

  bool isSearching = false;

  final _dbService = locator<DatabaseService>();
  bool isLoading = false;

  FaqsViewModel() {
    getFaqs();
  }

  getFaqs() async {
    setState(ViewState.busy);
    faqs = await _dbService.getFaqs();
    print('faqs => ${faqs.length}');
    setState(ViewState.idle);
  }
}
