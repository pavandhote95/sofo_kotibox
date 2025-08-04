import 'package:get/get.dart';

class WalletController extends GetxController {
  final RxDouble mainWallet = 3500.0.obs;
  final RxDouble bonusWallet = 500.0.obs;
  final RxDouble referralWallet = 200.0.obs;

  RxDouble get totalWallet => (mainWallet.value + bonusWallet.value + referralWallet.value).obs;
}
