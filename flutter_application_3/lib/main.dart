import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'header_widgets.dart'; // Import the HeaderWidget file
import 'personal_info_screen.dart'; // Import the new PersonalInfoScreen

void main() => runApp(PeriodApp());

class PeriodApp extends StatelessWidget {
  const PeriodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PeriodHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PeriodHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  PeriodHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHD8PlMytcDjNLdRnfHiGIynkOLRC9MFg92A&s',
              fit: BoxFit.cover,
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  HeaderWidget(), // The navigation header
                  const SizedBox(height: 24), // Add spacing below the header
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Message with Google Fonts
                        Text(
                          'Welcome to Feminine',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(
                              fontSize: 36, // Stylish font size
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Tracking your period is important for understanding your health and managing your lifestyle better.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const Text(
                          'Let\'s make it easier for you!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Let\'s get to know you',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Signup Form
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              _buildTextField('Name', icon: Icons.person),
                              const SizedBox(height: 16),
                              _buildTextField('Email', icon: Icons.email),
                              const SizedBox(height: 16),
                              _buildTextField(
                                'Password',
                                obscureText: true,
                                icon: Icons.lock,
                              ),
                              const SizedBox(height: 16),
                              _buildTextField('Age', icon: Icons.cake),
                              const SizedBox(height: 24),
                              ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Navigate to PersonalInfoScreen on sign-in
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PersonalInfoScreen(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                icon: const Icon(Icons.check, color: Colors.white),
                                label: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 12.0,
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  // Helper method to build text fields with validation
  Widget _buildTextField(String label,
      {bool obscureText = false, IconData? icon}) {
    return SizedBox(
      width: 500, // Adjusted width to shorten the border
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.purple), // Label color updated to purple
          prefixIcon: icon != null ? Icon(icon, color: Colors.purple) : null,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.pink, width: 0.8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.pink, width: 1),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}
