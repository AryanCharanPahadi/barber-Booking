import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsPage extends StatelessWidget {
  final String email;

  BookingDetailsPage({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF6A1B9A),
        title: Text(
          "My Bookings",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // Applying gradient to the entire Scaffold
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF6A1B9A),
              Color(0xFF8E24AA),
              Color(0xFFAB47BC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("Booking")
                    .where("Email", isEqualTo: email)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading bookings."));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text(
                        "No bookings found!",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }

                  final bookings = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      final booking =
                          bookings[index].data() as Map<String, dynamic>;
                      return Card(
                        color: const Color(0xFFb4817e),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12), // Increased margin for bigger cards
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20.0,
                              horizontal: 16.0), // Increased padding
                          title: Text(
                            booking["Service"] ?? "No Service Name",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0, // Increased font size
                              fontWeight: FontWeight.bold, // Make text bold
                            ),
                          ),
                          subtitle: Text(
                            "Date: ${booking["Date"]}\nTime: ${booking["Time"]}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 20.0, // Increased font size
                            ),
                          ),
                          leading: booking["Image"] != null
                              ? CircleAvatar(
                                  radius: 30.0, // Larger avatar size
                                  backgroundImage:
                                      NetworkImage(booking["Image"]),
                                )
                              : const CircleAvatar(
                                  radius: 30.0, // Larger default avatar size
                                  child: Icon(
                                    Icons.person,
                                    size: 30.0, // Larger icon size
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
