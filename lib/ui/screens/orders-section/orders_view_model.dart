import 'package:f2_base_project/core/enums/view_state.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/others/base_view_model.dart';
import 'package:f2_base_project/core/services/auth_service.dart';
import 'package:f2_base_project/core/services/database_service.dart';
import 'package:f2_base_project/locator.dart';

class OrdersViewModel extends BaseViewModel {
  final _dbService = locator<DatabaseService>();
  final _authService = locator<AuthService>();
  List<Orders> pendingOrders = [];
  List<Orders> deliveredOrders = [];
  List<Orders> canceledOrders = [];
  List<Orders> shippedOrders = [];
  List<Orders> allOrders = [];
  bool isLoading = false;

  OrdersViewModel() {
    getMyOrders();
  }

  getMyOrders() async {
    isLoading = true;
    setState(ViewState.busy);
    allOrders = await _dbService.getOrders(_authService.appUser.id!);
    print('ordersLength => ${allOrders.length}');
    isLoading = false;
    setState(ViewState.idle);
  }
}
