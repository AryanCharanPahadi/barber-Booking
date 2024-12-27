import 'package:barber_project/services/database.dart';
import 'package:flutter/material.dart';

import '../services/sharedpreferences.dart';

class Booking extends StatefulWidget {
  final String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool _isLoading = false; // Add this variable to manage the loading state.

  String? name, image, email;

  getTheDataFromSharedpref() async {
    name = await SharePreferencesHelper().getUserName();
    image = await SharePreferencesHelper().getUserImage();
    email = await SharePreferencesHelper().getUserEmail();

    setState(() {});
  }

  @override
  void initState() {
    getTheDataFromSharedpref();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
              const SizedBox(height: 30),

              // Header Section
              Text(
                "Let's Begin\nYour Journey",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 20),

              // Service Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/discount.png",
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Service Name
              Center(
                child: Text(
                  widget.service,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Date Picker
              _buildPickerCard(
                title: "Set a Date",
                icon: Icons.calendar_month,
                value:
                    '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),

              // Time Picker
              _buildPickerCard(
                title: "Set a Time",
                icon: Icons.access_time,
                value: _selectedTime.format(context),
                onTap: () => _selectTime(context),
              ),
              const SizedBox(height: 30),

              // Add this variable to manage the loading state

              GestureDetector(
                onTap: () async {
                  if (_isLoading)
                    return; // Prevent multiple taps if the loader is active

                  setState(() {
                    _isLoading =
                        true; // Start loading when the booking process begins
                  });

                  Map<String, dynamic> userBookingMap = {
                    "Service": widget.service,
                    "Date":
                        "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                    "Time": _selectedTime.format(context),
                    "Username": name,
                    "Image": image,
                    "Email": email,
                  };

                  try {
                    await DatabaseMethods().addUserBooking(userBookingMap);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Your Service has been booked Successfully",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Booking failed! Please try again.",
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ));
                  } finally {
                    setState(() {
                      _isLoading =
                          false; // Hide the loader after the process is done
                    });
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFfe8f33),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ) // Show loader when booking is in progress
                        : const Text(
                            'Book Now',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Pickers
  Widget _buildPickerCard(
      {required String title,
      required IconData icon,
      required String value,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFb4817e),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 10),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
