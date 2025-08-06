import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:sofo/app/modules/checkout/views/address_model.dart';

class CheckoutController extends GetxController {
  final Rxn<AddressModel> homeAddress = Rxn<AddressModel>();
  final Rxn<AddressModel> officeAddress = Rxn<AddressModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  Future<void> fetchAddresses() async {
    isLoading.value = true;
    final token = GetStorage().read("token");

    try {
      final response = await http.get(
        Uri.parse('https://kotiboxglobaltech.com/sofo_app/api/auth/addresses-list'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List list = data['data'];
        final addresses = list.map((e) => AddressModel.fromJson(e)).toList();

        homeAddress.value = _firstWhereOrNull(addresses, (e) => e.type == "Home");
        officeAddress.value = _firstWhereOrNull(addresses, (e) => e.type == "Office");
      }
    } catch (e) {
      print("Error fetching address list: $e");
    } finally {
      isLoading.value = false;
    }
  }

  AddressModel? _firstWhereOrNull(List<AddressModel> list, bool Function(AddressModel) test) {
    for (var e in list) {
      if (test(e)) return e;
    }
    return null;
  }

Future<void> callShippingEditApi(AddressModel address) async {
  final token = GetStorage().read("token");

  final url = Uri.parse('https://kotiboxglobaltech.com/sofo_app/api/auth/checkout/shipping/edit');

  final body = {
    "shipping": {
      "shipping_id": address.id,
      "type": address.type,
      "phone": address.phone,
      "city": address.city,
      "state": address.state,
      "pincode": address.pincode,
    }
  };

  print('📦 Shipping Edit API Body: ${jsonEncode(body)}');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('✅ Shipping edit API success: ${response.body}');
    } else {
      print('❌ Shipping edit API failed: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('❌ Error in shipping edit API: $e');
  }
}

}
