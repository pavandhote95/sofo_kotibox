import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sofo/app/custom_widgets/curved_top_container.dart';
import '../../../custom_widgets/app_color.dart';

import '../../../custom_widgets/text_fonts.dart';
import '../controllers/searching_controller.dart';

class SearchingView extends GetView<SearchingController> {
  const SearchingView({super.key});

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [

        CurvedTopRightBackground(),

          Padding(
            padding: EdgeInsets.only(left: 20,right: 20, top: 60,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios, color: Colors.black,size: 20,),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Sofa",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
                SizedBox(height: 20),

                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Sofa....',
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: AppColor.greyFieldBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: AppColor.greyFieldBorder),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: AppColor.orange),
                    ),
                  ),
                ),


                SizedBox(height: 10),

                // Location picker
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                     Image.asset("assets/icons/location_ios.png",height: 20,),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Text('Kensington, SW10 2PL',
                            style: AppTextStyle.manRope(
                              c: AppColor.greyText,
                              fs: 14,
                            )),
                      ),
                      Row(
                        children: [
                          Text('Edit',
                              style: AppTextStyle.manRope(
                                c: AppColor.orange,
                                fs: 14,
                                fw: FontWeight.bold,
                                decoration: TextDecoration.underline,


                              )),
                          SizedBox(width: 5,),
                          Icon(Icons.arrow_forward_ios,color: Colors.black,size: 13,)
                        ],
                      ),
                    ],
                  ),
                ),



                // Product List (you can reuse ListView.builder here)
                Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final size = MediaQuery.of(context).size;
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              // Left side - Product Image
                              Container(
                                height: size.height * 0.15,
                                width: size.width * 0.30,
                                decoration: BoxDecoration(
                                  color: AppColor.grey,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage('https://your-image-url.com/image.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              // Right side - Title, price, delivery, button
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Modern Sofa (fresh Mart)',
                                      style: AppTextStyle.montserrat(
                                          fs: 14, fw: FontWeight.bold, c: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('\$29.99',
                                            style: AppTextStyle.montserrat(
                                              fs: 14, fw: FontWeight.bold, c: AppColor.orange,
                                            )),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: AppColor.yellow, size: 18),
                                            SizedBox(width: 4),
                                            Text('4.5',
                                              style: AppTextStyle.montserrat(
                                                  fs: 13, fw: FontWeight.bold, c: Colors.black),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColor.greyFieldBorder),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text('🚚 Delivered within 2 hours',
                                          style: AppTextStyle.montserrat(
                                              fs: 12, c: AppColor.orange, fw: FontWeight.w600),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(height: 4),
                                    SizedBox(
                                      width: double.infinity, // button puri width lelega
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor: AppColor.orange,
                                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            )
                                        ),
                                        child: Text('Add to Cart',
                                            style: AppTextStyle.montserrat(
                                              fs: 13, fw: FontWeight.bold, c: Colors.white,
                                            )),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )
                ),


  ],
            ),
          )
        ],
      ),
    );
  }
}





