import 'package:get/get.dart';

class ReviewsController extends GetxController {
  var reviewsList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  void fetchReviews() {
    reviewsList.value = [
      {
        'customerName': 'Aryan Kumar',
        'comment': 'Great service and friendly staff!',
        'rating': 5
      },
      {
        'customerName': 'Neha Sharma',
        'comment': 'Average experience, could be better.',
        'rating': 3
      },
      {
        'customerName': 'Ravi Verma',
        'comment': 'Very poor response.',
        'rating': 1
      },
    ];
  }
}
