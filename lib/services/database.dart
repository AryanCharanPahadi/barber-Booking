// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class DatabaseMethods {
//   // Add user details to Firestore
//   Future addUserDetails(Map<String, dynamic> userInfomap, String id) async {
//     return await FirebaseFirestore.instance
//         .collection("users")
//         .doc(id)
//         .set(userInfomap);
//   }
//
//   // Add user booking to Firestore
//   Future addUserBooking(Map<String, dynamic> userInfomap) async {
//     return await FirebaseFirestore.instance
//         .collection("Booking")
//         .add(userInfomap);
//   }
//
//   // Get all bookings from Firestore
//   Future<Stream<QuerySnapshot>> getBookings() async {
//     return FirebaseFirestore.instance.collection("Booking").snapshots();
//   }
//
//   // Delete a user booking from Firestore by ID
//   Future deleteUserBooking(String id) async {
//     return await FirebaseFirestore.instance
//         .collection("Booking")
//         .doc(id)
//         .delete();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // Add user details to Firestore
  Future addUserDetails(Map<String, dynamic> userInfomap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfomap);
  }

  // Add user booking to Firestore
  Future addUserBooking(Map<String, dynamic> userInfomap) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .add(userInfomap);
  }

  // Get all bookings from Firestore
  Future<Stream<QuerySnapshot>> getBookings() async {
    return FirebaseFirestore.instance.collection("Booking").snapshots();
  }

  // Delete a user booking from Firestore by ID
  Future deleteUserBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .doc(id)
        .delete();
  }

  // Fetch booking details by email ID
  Future<Stream<QuerySnapshot>> getBookingsByEmail(String email) async {
    return FirebaseFirestore.instance
        .collection("Booking")
        .where("email", isEqualTo: email)
        .snapshots();
  }
}
