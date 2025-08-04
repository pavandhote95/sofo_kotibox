import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/app_color.dart';
import '../../../custom_widgets/text_fonts.dart';
import '../../../data/store_item.dart'; // Import StoreDetails model

class StoreInformationView extends StatelessWidget {
  final StoreDetails? storeDetails; // Accept StoreDetails as a parameter

  const StoreInformationView({super.key, this.storeDetails});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        centerTitle: true,
        title: Text(
          storeDetails?.shopName ?? 'Store Information',
          style: AppTextStyle.montserrat(
            fs: 18,
            fw: FontWeight.bold,
            c: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Get.back(),
        ),
        actions: [
          Row(
            children: [
              Icon(Icons.star, color: AppColor.yellow),
              Text(
                ' ${storeDetails?.rating?.toStringAsFixed(1) ?? "N/A"}',
                style: AppTextStyle.montserrat(fs: 14, fw: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(width: 16),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: storeDetails?.shopImage != null
                      ? CachedNetworkImage(
                    imageUrl: storeDetails!.shopImage!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text(
                        'Image Load Failed',
                        style: AppTextStyle.montserrat(
                          fs: 14,
                          c: AppColor.greyText,
                        ),
                      ),
                    ),
                  )
                      : Center(
                    child: Text(
                      'No Image',
                      style: AppTextStyle.montserrat(
                        fs: 14,
                        c: AppColor.greyText,
                      ),
                    ),
                  ),
                ),
              )
,
              SizedBox(height: 5),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(CupertinoIcons.location, color: AppColor.orange),
                title: Text(
                  storeDetails?.address ?? 'N/A',
                  style: AppTextStyle.montserrat(
                      fs: 14,
                      fw: FontWeight.w400,
                      c: Colors.black.withOpacity(0.8)),
                ),
              ),
              Divider(color: AppColor.greyFieldBorder, height: 0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(CupertinoIcons.phone, color: AppColor.orange),
                title: Text(
                  'Contact: ${storeDetails?.contact ?? "N/A"}',
                  style: AppTextStyle.montserrat(
                      fs: 14,
                      fw: FontWeight.w400,
                      c: Colors.black.withOpacity(0.8)),
                ),
              ),
              Divider(color: AppColor.greyFieldBorder, height: 0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(CupertinoIcons.mail, color: AppColor.orange),
                title: Text(
                  'Email: ${storeDetails?.email ?? "N/A"}',
                  style: AppTextStyle.montserrat(
                      fs: 14,
                      fw: FontWeight.w400,
                      c: Colors.black.withOpacity(0.8)),
                ),
              ),
              Divider(color: AppColor.greyFieldBorder, height: 0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(CupertinoIcons.globe, color: AppColor.orange),
                title: Text(
                  'Website: ${storeDetails?.website ?? "N/A"}',
                  style: AppTextStyle.montserrat(
                      fs: 14,
                      fw: FontWeight.w400,
                      c: Colors.black.withOpacity(0.8)),
                ),
              ),
              Divider(color: AppColor.greyFieldBorder, height: 0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'About',
                  style: AppTextStyle.montserrat(
                      fs: 16, fw: FontWeight.bold, c: Colors.black),
                ),
              ),
              Text(
                storeDetails?.about ?? 'N/A',
                style: AppTextStyle.montserrat(
                    fs: 14,
                    fw: FontWeight.normal,
                    c: Colors.black.withOpacity(0.7)),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Delivery',
                  style: AppTextStyle.montserrat(
                      fs: 16, fw: FontWeight.bold, c: Colors.black),
                ),
              ),
              Text(
                storeDetails?.delivery ?? 'N/A',
                style: AppTextStyle.montserrat(
                    fs: 14,
                    fw: FontWeight.normal,
                    c: Colors.black.withOpacity(0.7)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}