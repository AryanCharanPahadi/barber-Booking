import 'package:barber_project/login_signup/login_page.dart';
import 'package:flutter/material.dart';
import '../admin/admin_login.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage('assets/user_client.jpg'), // Add your image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient overlay for better contrast
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Content
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.all(20.0), // Add padding around the content
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the buttons vertically
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Center the buttons horizontally
                children: [
                  // Title or header for context
                  Text(
                    "Welcome to the App",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40, // Larger font size for the title
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for better contrast
                      fontFamily: 'Roboto', // Use a custom font
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: 40), // Add space between the header and buttons

                  // First button: "Are You a User"
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 45.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent,
                            Colors.deepPurple.shade700
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 12,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        "Are You a User",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text on buttons
                          letterSpacing: 1.2, // Add spacing between letters
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Space between the buttons

                  // Second button: "Are You a Partner"
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdminLogin()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 45.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purpleAccent,
                            Colors.deepPurple.shade700
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 12,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        "Are You a Partner",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text on buttons
                          letterSpacing: 1.2, // Add spacing between letters
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
