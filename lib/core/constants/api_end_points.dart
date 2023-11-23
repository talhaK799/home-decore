class EndPoints {
  static const baseUrl = 'http://sporttalent.me/public';
  static const login = '/api/login';
  static const createAccount = '/api/register';
  static const getBlogs = '/api/blogs';
  static const getBlogsComments = '/api/comments/';
  static const addBlogComment = '/api/comments/store';
  static const getSingleBlogDetails = '/api/blogs/';
  static const getFaqs = '/api/faqs';
  static const toggleBlogLike = '/api/like/store';
  static const storeFeedback = '/api/feedback/store';
  static const googleSignin = '/api/login/google/callback';
  static const facebookLogin = '/api/login/facebook/callback';
  static const appleLogin = '/api/login/apple/callback';
  static const getOffers = '/api/services/offers';
  static const getOrders = '/api/orders/getMyOrders';
  static const updateFcm = '/api/fcm/store';
  static const removeFcm = '/api/fcm/remove';
  static const getPrivacyPolicies = '/api/privacy-policy';
  static const getAboutUs = '/api/aboutus';
  static const notifications = '/api/notifications';
  static const blogSearch = '/api/blog/search';
  static const getAppBanners = '/api/banners';
  static const applyCoupons = '/api/coupon';

  ///
  /// Shop Section apis end points
  ///
  static const getAllProducts = '/api/products';
  static const getProdByShopId = '/api/products/shop/';
  static const getLatestProducts = '/api/latestProducts';
  static const addProductToCart = '/api/cart/store';
  static const getCartProductList = '/api/cart';
  static const updateCartProduct = '/api/cart/';
  static const getUserAddress = '/api/address';
  static const addUserAddress = '/api/address/store';
  static const deleteUserAddress = '/api/address/delete/';
  static const getAllProdFilters = '/api/filter';
  static const searchProdByFilters = '/api/filter/search';
  static const productLikeToggle = '/api/like/store';
  static const addProdReview = '/api/reviews/store';
  static const getProdReviews = '/api/reviews/';
  static const searchProducts = '/api/products/search';
  static const editUserAddress = '/api/address/update/';
  static const deleteCartProduct = '/api/cart/';
  static const wishlistedProducts = '/api/like/products';
  static const getProdOffers = '/api/shop/offers';
  static const relatedProducts = '/api/products/';
  static const searchedProdOffers = '/api/ShopOffers/search';
  static const updateReview = '/api/reviews/';
  static const deleteReview = '/api/reviews/';
  static const getRecentlyJoinies = '/api/brand';
  static const notificationReadStatus = '/api/read-notifications';
  static const setBookingNotification =
      '/api/services/service-booking/set-notifications/';

  ///
  /// User Profile apis end points
  ///
  static const changePassword = '/api/user/change-password';
  static const updateUserAvatar = '/api/user/change-profile';
  static const updateUserData = '/api/user/update/';
  static const getUser = '/api/user';
  static const userProfile = '/api/user';
  static const resetPassword = "/api/password/email";

  ///
  /// Services Section apis end points
  ///
  static const getAllService = '/api/services/categories';
  static const getServicesSubCategories = '/api/services/sub-categories/';
  static const getServicesInSubCategories = '/api/services/';
  static const bookaPitch = '/api/services/fields/';
  static const getBookingPrice = '/api/services/select-fields';
  static const getBookings = '/api/services/service-booking/getBookings';
  static const cancelBooking = '/api/services/service-booking/cancel-booking/';
  static const getServicesReviews = '/api/reviews/services/';
  static const rescheduleBooking =
      "/api/services/service-booking/reschedule-booking/";
  static const searchSubCategories = "/api/ServiceSubCategories/search";
  static const searchServiceBySubCategory = "/api/ServiceBySubCategory/search";
  static const searchedServiceOffers = "/api/ServiceOffers/search";
  static const checkBooking = '/api/service-booking/checkBooking';
  static const bookedDates =
      '/api/services/service-booking/getUserBookingDates';

  ////
  /// Talent Section apis end points
  ///
  static const getAllTalentTypes = '/api/talents/getTalentTypes';
  static const addTalent = '/api/talents/storeTalents';
  static const getTalents = '/api/talents/getTalents';
  static const contactTalent = '/api/talents/storeTalentContact';
  static const getTalentReviews = '/api/reviews/talents/';
}
