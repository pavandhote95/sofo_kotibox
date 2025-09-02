import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sofo/app/modules/account/controllers/account_controller.dart';
import '../../../custom_widgets/api_url.dart';
import '../../../custom_widgets/auth_helper.dart';
import '../../../custom_widgets/snacbar.dart';
import '../../../data/store_category.dart';
import '../../../data/store_list.dart';
import '../../../services/api_service.dart';
import '../../../services/location_services.dart';


class HomeController extends GetxController with GetTickerProviderStateMixin {

  // location base work
  Rx<Position?> currentPosition = Rx<Position?>(null);
  RxString currentAddress = ''.obs;
 var isLoadingAddress = false.obs;
  StreamSubscription<ServiceStatus>? _serviceStatusStream;
  final mapCenter = const LatLng(26.9124, 75.7873).obs;
  final currentLocality = ''.obs;
  GoogleMapController? mapController;
  @override
  void onInit() {
    super.onInit();
    getCategoryName();
    fetchLocationAndAddress();
    fetchCurrentLocation();
    AccountController().fetchUserProfile();
    // ✅ Only start the service status stream if not running on Web
    if (!kIsWeb) {
      _serviceStatusStream =
          Geolocator.getServiceStatusStream().listen((status) {
            if (status == ServiceStatus.enabled &&
                currentPosition.value == null) {
              fetchLocationAndAddress(); // Retry if location gets enabled
            }
          });
    } else {
      print("⚠️ getServiceStatusStream not supported on Web");
    }
  }
  @override
  void onClose() {
    if (!kIsWeb) {
      _serviceStatusStream?.cancel();
    }
    super.onClose();
  }
  Future<void> fetchLocationAndAddress() async {
    try {
      isLoadingAddress.value = true;
      Position? position = await LocationService.getCurrentLocation();
      if (position != null) {
        currentPosition.value = position;
        final addressData = await LocationService.getAddressFromLatLng(position);
        if (addressData != null) {
          currentAddress.value = addressData['fullAddress'] ?? "Address not found";
        } else {
          currentAddress.value = "Address not found";
        }
      } else {
        currentAddress.value = "Location not available. Please enable it.";
        Get.snackbar(
          "Location Disabled",
          "Please enable GPS/location service to continue.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      currentAddress.value = "Error fetching location";
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingAddress.value = false;
    }
  }



Future<void> fetchCurrentLocation() async {
  isLoadingAddress.value = true;
  final position = await LocationService.getCurrentLocation();
  if (position != null) {
    print('📍 Current Location: ${position.latitude}, ${position.longitude}'); // ← Ye line add karo

    mapCenter.value = LatLng(position.latitude, position.longitude);
    updateAddress(position);
    mapController?.animateCamera(CameraUpdate.newLatLng(mapCenter.value));
  } else {
    print('⚠️ Could not fetch current location.');
  }
  isLoadingAddress.value = false;
}
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    mapCenter.value = position.target;
  }

  void onCameraIdle() async {
    final pos = Position(
      latitude: mapCenter.value.latitude,
      longitude: mapCenter.value.longitude,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0, altitudeAccuracy: 0.0, headingAccuracy: 0.0,
    );
    updateAddress(pos);
  }

Future<void> updateAddress(Position position) async {
  final addressData = await LocationService.getAddressFromLatLng(position);
  if (addressData != null) {
    currentAddress.value = addressData['fullAddress']!;
 //   currentLocality.value = addressData['locality']!;

    print('📫 Current Address: ${currentAddress.value}');
   // print('🏘️ Locality: ${currentLocality.value}');
  } else {
    print('❌ Address not found for current coordinates.');
  }
}


// api base work
  var isLoading = false.obs;
  var storeCategory = <StoreCategory>[].obs;
  var storeList = StoreList().obs;
  var selectedCategoryId = ''.obs;
  late TabController tabController;






  Future<void> getCategoryName() async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      var response = await restApi.getApi(getCategoryNameUrl);
      var responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
          // storeCategory.value = storeCategoryFromJson(response.body);
        storeCategory.value = storeCategoryFromJson(response.body).data!;

        // // Initialize TabController after data is loaded
        tabController = TabController(length: storeCategory.length, vsync: this);
        // Set default selected category
        selectedCategoryId.value = storeCategory[0].id.toString();
        // Listen to tab change

        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            selectedCategoryId.value = storeCategory[tabController.index].id.toString();
            getStoreList(selectedCategoryId.value);
          }
        });
        // Initial store list fetch
        await getStoreList(selectedCategoryId.value);
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      print('Category Fetch Error: $e');
      Utils.showErrorSnackbar("Exception", "Failed to load category");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getStoreList(String categoryId) async {
    try {
      isLoading(true);
      RestApi restApi = RestApi();
      final response = await restApi.getWithAuthApi('${getStoreListUrl}/${categoryId}');
      print('${getStoreListUrl}/${categoryId}');
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        // Handle fetched store list here
        print('Store List Responsepppppppppppppppp: ${response.body}');
        // Add your store list parsing logic
         storeList.value = storeListFromJson(response.body);
      } else if (response.statusCode == 401) {
        AuthHelper.handleUnauthorized();
      } else {
        Utils.showErrorSnackbar("Error", responseJson["message"] ?? "Something went wrong!");
      }
    } catch (e) {
      print('Store List Fetch Error: $e');
      Utils.showErrorSnackbar("Exception", "Failed to load store list");
    } finally {
      isLoading(false);
    }
  }
}

