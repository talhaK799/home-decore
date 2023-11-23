const String name = 'Test';
const String staticAssets = 'assets/static_assets';

const String assets = 'assets/static_assets';
const String assetsPath = 'assets/static_assets/';
const String productPlaceHolder = '$staticAssets/placeholder.png';
const String profilePlaceHolder = "$staticAssets/avater.png";

const String discountGranted = 'discountGranted';
const String codeInvalid = 'invalid';
const String codeExpired = 'expired';
const String latoFont = 'lato';
const String hacenFontHd = 'hacen-beirut-hd';
const String hacenFont = 'hacen-beirut';
const String segoeFont = "Segoe-UI";
const String empty = 'empty';

const String reviewForProduct = 'product';
const String reviewForService = 'service';
const String reviewForTalent = "talent";

const String pendingOrder = 'pending';
const String canceledOrder = 'canceled';
const String deliveredOrder = 'delivered';
const String shippedOrder = 'shipped';

const String shareLink = 'Testing link for share';

const processing = 'Processing';
const hold = 'Hold';
const shipped = 'Shipped';
const done = 'Done';
const placed = 'Order Placed';
const canceled = 'Canceled ';

extension StringCasingExtension on String {
  String toCapitalized() =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';
}
