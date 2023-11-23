import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/notifications.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import '../../../locator.dart';

class NotificationViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _authService = locator<AuthService>();
  bool isLoading = false;
  List<Notifications> notificaitons = [];

  NotificationViewModel() {
    getNotifications();
  }

  getNotifications() async {
    isLoading = true;
    setState(ViewState.busy);
    notificaitons = await _dbService.getNotifications(_authService.appUser.id!);
    print('notificaitons => ${notificaitons.length}');
    isLoading = false;
    setState(ViewState.idle);
  }
}
