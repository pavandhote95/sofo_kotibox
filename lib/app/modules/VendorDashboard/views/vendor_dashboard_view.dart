  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  import 'package:get/get.dart';
import 'package:sofo/app/modules/Vendoradditem/views/vendoradditem_view.dart';

import 'package:sofo/app/modules/Vendorresupport/views/vendorresupport_view.dart';
import 'package:sofo/app/modules/Vendorreview/views/vendorreview_view.dart';
import 'package:sofo/app/modules/notification/views/setting_view.dart';

import 'package:sofo/app/modules/vendor_all_shops/views/vendor_all_shops_view.dart';
import 'package:sofo/app/modules/vendor_customers/views/vendor_customers_view.dart';
import 'package:sofo/app/modules/vendor_order_history/views/vendor_order_history_view.dart';
import 'package:sofo/app/modules/vendorearning/views/vendor_earning_view.dart';
import 'package:sofo/app/modules/vendorwallet/views/vendorwallet_view.dart';
  import '../../../custom_widgets/CustomAppBar.dart';
  import '../../../custom_widgets/app_color.dart';
  import '../../../custom_widgets/curved_top_container.dart';
  import '../../../custom_widgets/text_fonts.dart';


  class VendorDashboardView extends StatelessWidget {
    final RxString userid;

    const VendorDashboardView(this.userid, {super.key});

    @override
    Widget build(BuildContext context) {
      print("Vendor UserID: ${userid.value}"); // for debugging/logging

      return Scaffold(
        backgroundColor: AppColor.white,
        body: Stack(
          children: [
            // 🔵 Curved background
            const CurvedTopRightBackground(),

            // 🧾 Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  title: "Vendor Dashboard",
                  onActionTap: null,
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1,
                      children: [


                        _dashboardCard('All Orders', FontAwesomeIcons.shop, () {
                          Get.to(() => VendorOrderHistoryView());
                        }),

                 
             
                    
                        _dashboardCard('Add Item', FontAwesomeIcons.plusSquare,() {
                          Get.to(() => VendoradditemView());

                        }),
        
                        _dashboardCard('All_Shops', FontAwesomeIcons.store,() {
                          Get.to(() => VendorAllShopsView());

                        }),
                
                        _dashboardCard('Earnings', FontAwesomeIcons.dollarSign,() {
                          Get.to(() => VendorEarningView());

                        }),

                        _dashboardCard('Wallet', FontAwesomeIcons.wallet,() {
                          Get.to(() => WalletsPage());

                        }),
                        // _dashboardCard('Customers', FontAwesomeIcons.users,() {
                        //   Get.to(() => CustomersView());

                        // }),
                        // _dashboardCard('Reviews', FontAwesomeIcons.star,() {
                        //   Get.to(() => ReviewsView());

                        // }),
                          _dashboardCard('Support', FontAwesomeIcons.headset,() {
                            Get.to(() => SupportView());

                        }),
                        _dashboardCard('Settings', FontAwesomeIcons.gear,() {
                          Get.to(() => SettingsView());

                        }),
                      ],

                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    // 📦 Reusable Dashboard Card
    Widget _dashboardCard(String title, IconData icon, VoidCallback onTap) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.orange, width: 0.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  blurRadius: 1,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 22, color: Colors.orange),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.montserrat(
                        fs: 12,
                        fw: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
