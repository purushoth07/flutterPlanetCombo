class APIEndPoints {

  //application api base Url
  static String baseUrl = 'https://dev.planetcombo.com/api/';

  ///Social Login
  static String socialLogin = '${baseUrl}api/Profile/login';

  ///Get horoscopes
  static String getHoroscope = '${baseUrl}api/horoscope/get?userId=';

  ///Get horoscopes
  static String checkRequest = '${baseUrl}api/request/ChekckDuplicateRequest?USERID=';

  ///Get horoscopes
  static String getDailyCharge = '${baseUrl}api/Charge/GetDailyChargeHTMLink?TypeRequest=';

  ///Add offline Money
  static String addOfflineMoney = '${baseUrl}api/Invoice/Pay';

  ///Get terms and conditions
  static String getTermsAndConditions = '${baseUrl}api/termCondition/TCLinkandCharCharges?userId=';

  ///Delete horoscopes
  static String deleteHoroscope = '${baseUrl}api/horoscope/deleteHoroscope?userId=';


  ///get Promise
  static String getPromises = '${baseUrl}api/promise/getPromises?userId=';

  ///get Planet
  static String getPlanetTransit = '${baseUrl}api/transit/getComment?planet=';

  ///View horoscope chart
  static String viewChart = '${baseUrl}api/horoscope/GetPDFChart?userId=';

  ///Add horoscopes
  static String addNewHoroscope = '${baseUrl}api/horoscope/addNew';

  ///update Profile
  static String updateProfile = '${baseUrl}api/profile/updateProfile';

  ///Update horoscopes
  static String updateHoroscope = '${baseUrl}api/horoscope/updateHoroscope';


  ///Email Horoscope Chart
  static String emailChart = '${baseUrl}api/hcom/requestHoroPDF';

  ///View Count Shop
  static String viewShopCount = '${baseUrl}api/User/ViewShop';


  ///View Promotion
  static String viewPromotionCount = '${baseUrl}api/Promotion/ViewPromotion';


  ///Vendor Register
  static String vendorRegister = '${baseUrl}api/User/RegisterUser';
  ///Vendor Login
  static String vendorLogin = '${baseUrl}api/Authentication/CheckAuthentication?';
  ///Get Vendor Profile
  static String vendorProfile = '${baseUrl}api/User/GetUserById?UserId=';
  ///Get Popular Vendor
  static String popularVendors = '${baseUrl}api/User/GetPopularVendor';
  ///Get Popular Vendor
  static String trendingVendors = '${baseUrl}api/User/GetTrendingVendor';
  ///Get Advertisement
  static String getAdvertisement = '${baseUrl}api/Promotion/GetAdvertisement';
  ///Get Vendor Coupons
  static String vendorCoupons = '${baseUrl}api/Coupon/GetCoupon?UserId=';
  ///Get Vendor Social Media
  static String vendorSocialMedia = '${baseUrl}api/SocialMedia/GetSocialMedia?UserId=';
  ///Get Vendor By Location
  static String vendorByLocation = '${baseUrl}api/User/GetVendorByLocation?Location=';
  ///Get Vendor Counts
  static String vendorCounts = '${baseUrl}api/User/GetDashboard?vendorId=';
  ///Get Vendor Promotion
  static String getVendorPromotion = '${baseUrl}api/Promotion/GetPromotion?UserId=';
  ///Delete Vendor Coupons
  static String deleteVendorCoupon = '${baseUrl}api/Coupon/DeleteCoupon?couponId=';
  ///Get Vendor Membership
  static String getVendorMembership = '${baseUrl}api/User/GetMembership';
  ///Update membership
  static String updateMembership = '${baseUrl}api/User/UpdateMembership';
  ///Update Vendor profile
  static String updateVendorProfile = '${baseUrl}api/User/UpdateUser';
  ///Vendor add coupon
  static String vendorAddCoupon = '${baseUrl}api/Coupon/AddCoupon';
  ///Vendor add social Media
  static String vendorAddSocialMedia = '${baseUrl}api/SocialMedia/AddSocialMedia';
  ///Vendor Show all vendors
  static String showVendorsList = '${baseUrl}api/User/ViewShopDashboardVisitor';
  ///Vendor Show ads vendors
  static String showAdsVendorsList = '${baseUrl}api/Promotion/ViewPromotionDashboardVisitor';
  ///Update add social Media
  static String vendorUpdateSocialMedia = '${baseUrl}api/SocialMedia/UpdateSocialMedia';
  ///Vendor add promotion
  static String vendorAddPromotion = '${baseUrl}api/Promotion/AddPromotion';
  ///Vendor update promotion
  static String vendorUpdatePromotion = '${baseUrl}api/Promotion/UpdatePromotion';
}