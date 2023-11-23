import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/terms.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import '../../../../locator.dart';

class PrivacyPolicyViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  Terms terms = Terms();

  PrivacyPolicyViewModel() {
    getTerms();
  }

  getTerms() async {
    setState(ViewState.busy);
    terms = await _dbService.getTerms();
    setState(ViewState.idle);
  }
}
