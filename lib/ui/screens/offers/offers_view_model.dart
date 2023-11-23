import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import '../../../locator.dart';

class OffersViewModel extends BaseViewModel {
  bool isLoading = false;
  final authService = locator<AuthService>();
}
