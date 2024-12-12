import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderController extends GetxController {
  // Reactive variables
  var isLoading = true.obs;
  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    fetchOrderDetails();
  }

  // Fetch order details from API
  Future<void> fetchOrderDetails() async {
    try {
      // Simulate API call delay
      final response = await http.get(
        Uri.parse('https://apib2b-production.up.railway.app/api/orderDetails'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['shippingName'] != null) {
          user.value = User.fromJson(data);
        } else {
          throw Exception('Invalid data structure');
        }
      } else {
        throw Exception('API returned status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching order details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

// User model
class User {
  final String shippingName;
  final String recipientName;
  final String fromAddress;
  final String toAddress;
  final int quantity;
  final double amount;

  User({
    required this.shippingName,
    required this.recipientName,
    required this.fromAddress,
    required this.toAddress,
    required this.quantity,
    required this.amount,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      shippingName: json['shippingName'] ?? '',
      recipientName: json['recipientName'] ?? '',
      fromAddress: json['fromAddress'] ?? '',
      toAddress: json['toAddress'] ?? '',
      quantity: json['quantity'] ?? 0,
      amount: (json['amount'] ?? 0).toDouble(),
    );
  }
}
