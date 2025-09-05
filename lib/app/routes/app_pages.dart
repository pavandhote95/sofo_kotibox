import 'package:get/get.dart';

import '../modules/Dashboard/bindings/dashboard_binding.dart';
import '../modules/Dashboard/views/dashboard_view.dart';
import '../modules/Earnings/bindings/earnings_binding.dart';
import '../modules/Earnings/views/earnings_view.dart';
import '../modules/VendorCategories/bindings/vendor_categories_binding.dart';
import '../modules/VendorCategories/views/vendor_categories_view.dart';
import '../modules/VendorProductList/bindings/vendor_product_list_binding.dart';
import '../modules/VendorProductList/views/vendor_product_list_view.dart';
import '../modules/VendorShop/bindings/vendor_shop_binding.dart';
import '../modules/VendorShop/views/vendor_shop_view.dart';
import '../modules/Vendoradditem/bindings/vendoradditem_binding.dart';
import '../modules/Vendoradditem/views/vendoradditem_view.dart';
import '../modules/Vendorallorders/bindings/vendorallorders_binding.dart';
import '../modules/Vendorallorders/views/vendorallorders_view.dart';
import '../modules/Vendorpendingorders/bindings/vendorpendingorders_binding.dart';
import '../modules/Vendorpendingorders/views/vendorpendingorders_view.dart';
import '../modules/Vendorresettings/bindings/vendorresettings_binding.dart';
import '../modules/Vendorresettings/views/vendorresettings_view.dart';
import '../modules/Vendorresupport/bindings/vendorresupport_binding.dart';
import '../modules/Vendorresupport/views/vendorresupport_view.dart';
import '../modules/Vendorreview/bindings/vendorreview_binding.dart';
import '../modules/Vendorreview/views/vendorreview_view.dart';
import '../modules/account/bindings/account_binding.dart';
import '../modules/account/views/account_view.dart';
import '../modules/add_address/bindings/add_address_binding.dart';
import '../modules/add_address/views/add_address_view.dart';
import '../modules/all_address_list/bindings/all_address_list_binding.dart';
import '../modules/all_address_list/views/all_address_list_view.dart';
import '../modules/edit_address/bindings/edit_address_binding.dart';
import '../modules/edit_address/views/edit_address_view.dart';
import '../modules/getstarted/bindings/getstarted_binding.dart';
import '../modules/getstarted/views/getstarted_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/searching/bindings/searching_binding.dart';
import '../modules/searching/views/searching_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/venderlogin/bindings/venderlogin_binding.dart';
import '../modules/venderlogin/views/venderRegister_view.dart';
import '../modules/vendor_customers/bindings/vendor_customers_binding.dart';
import '../modules/vendor_customers/views/vendor_customers_view.dart';
import '../modules/vendor_registration_success/bindings/vendor_registration_success_binding.dart';
import '../modules/vendor_registration_success/views/vendor_registration_success_view.dart';
import '../modules/vendorwallet/bindings/vendorwallet_binding.dart';
import '../modules/vendorwallet/views/vendorwallet_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';
import '../modules/your_page_name/bindings/your_page_name_binding.dart';
import '../modules/your_page_name/views/your_page_name_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.GETSTARTED,
      page: () => GetstartedView(),
      binding: GetstartedBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),

    GetPage(
      name: _Paths.PAYMENT,
      page: () {
        // Expect arguments to be passed when navigating to PaymentView
        final args = Get.arguments ?? {};
        return PaymentView(
          deliveryType: args['deliveryType'] ?? '',
          selectedDate: args['selectedDate'] ?? '',
          selectedTime: args['selectedTime'] ?? '',
          selectedAddress: args['selectedAddress'] ?? '',
          selectedPayment: args['selectedPayment'] ?? '',
          totalPrice: args['totalPrice']?.toDouble() ?? 0.0,
          productIds: args['productIds']?.cast<int>() ?? [],
        );
      },
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.SEARCHING,
      page: () => SearchingView(),
      binding: SearchingBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.VENDERLOGIN,
      page: () => VendorRegisterView(),
      binding: VenderRegisterBinding(),
    ),
    // GetPage(
    //   name: _Paths.VENDOR_DASHBOARD,
    //   page: () => const VendorDashboardView(),
    //   binding: VendorDashboardBinding(),
    // ),
    GetPage(
      name: _Paths.VENDORALLORDERS,
      page: () => VendorOrdersView(),
      binding: VendorallordersBinding(),
    ),
    GetPage(
      name: _Paths.VENDORPENDINGORDERS,
      page: () => VendorPendingOrdersView(),
      binding: VendorpendingordersBinding(),
    ),
    GetPage(
      name: _Paths.VENDORADDITEM,
      page: () => VendoradditemView(),
      binding: VendoradditemBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_PRODUCT_LIST,
      page: () => VendorProductListView(),
      binding: VendorProductListBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_SHOP,
      page: () => VendorShopView(),
      binding: VendorShopBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_CATEGORIES,
      page: () => VendorCategoriesView(),
      binding: VendorCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.EARNINGS,
      page: () => const EarningsView(),
      binding: EarningsBinding(),
    ),
    GetPage(
      name: _Paths.VENDORWALLET,
      page: () => WalletsPage(),
      binding: VendorwalletBinding(),
    ),
    GetPage(
      name: _Paths.YOUR_PAGE_NAME,
      page: () => const YourPageNameView(),
      binding: YourPageNameBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_CUSTOMERS,
      page: () => CustomersView(),
      binding: VendorCustomersBinding(),
    ),
    GetPage(
      name: _Paths.VENDORREVIEW,
      page: () => ReviewsView(),
      binding: VendorreviewBinding(),
    ),
    GetPage(
      name: _Paths.VENDORRESUPPORT,
      page: () => SupportView(),
      binding: VendorresupportBinding(),
    ),
    GetPage(
      name: _Paths.VENDORRESETTINGS,
      page: () => SettingsView(),
      binding: VendorresettingsBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_ADDRESS,
      page: () => EditAddressView(
        initialData: Get.arguments ?? {},
      ),
      binding: EditAddressBinding(),
    ),
    GetPage(
      name: _Paths.ALL_ADDRESS_LIST,
      page: () => AllAddressListView(),
      binding: AllAddressListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ADDRESS,
      page: () => AddAddressView(),
      binding: AddAddressBinding(),
    ),
    GetPage(
      name: _Paths.VENDOR_REGISTRATION_SUCCESS,
      page: () => const VendorRegistrationSuccessView(),
      binding: VendorRegistrationSuccessBinding(),
    ),
  ];
}
