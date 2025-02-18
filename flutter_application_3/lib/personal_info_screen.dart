import 'package:flutter/material.dart';
import 'period_calendar.dart'; // Import the PeriodCalendar page

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final TextEditingController favoriteColorController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();
  final TextEditingController healthConcernsController =
      TextEditingController();
  final TextEditingController cycleLengthController = TextEditingController();
  final TextEditingController lastPeriodController = TextEditingController();
  final TextEditingController flowIntensityController = TextEditingController();

  DateTime? lastPeriodStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personalized Information',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor:  Colors.pink.withOpacity(0.4),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHD8PlMytcDjNLdRnfHiGIynkOLRC9MFg92A&s',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Image (Reduced Size)
                    Center(
                      child: Image.network(
                        'https://tse2.mm.bing.net/th?id=OIP.8XMfS8DPZc1QpzKbhk6ZKQHaHa&pid=Api&P=0&h=180',
                        fit: BoxFit.cover,
                        height: 150, // Reduced height
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Tracking Your Cycle Section
                    const Text(
                      'Tracking your cycle is important for understanding your health and managing your lifestyle better. Let\'s make it easier for you!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    // Form Title
                    const Text(
                      'Tell us more about you!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Input Fields
                    _buildTextField(
                      'Favorite Color',
                      favoriteColorController,
                      icon: Icons.palette,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      'Hobbies',
                      hobbiesController,
                      icon: Icons.sports_esports,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      'Health Concerns',
                      healthConcernsController,
                      icon: Icons.health_and_safety,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      'How many days does your cycle last?',
                      cycleLengthController,
                      icon: Icons.calendar_today,
                      isNumeric: true,
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(
                      'When was the start of your last period?',
                      lastPeriodController,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      'How heavy is your flow (light/medium/heavy)?',
                      flowIntensityController,
                      icon: Icons.water_drop,
                    ),
                    const SizedBox(height: 24),
                    // Submit Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PeriodCalendar(
                                  cycleLength: int.parse(
                                      cycleLengthController.text), // Cycle length
                                  menstruationLength: 5, // Default for now
                                  lastPeriodStart:
                                      lastPeriodStart!, // Last period
                                ),
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
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildTextField(String label, TextEditingController controller,
    {IconData? icon, bool isNumeric = false}) {
  return Center( // Center the text field
    child: SizedBox(
      width: 400, // Increased width to match the date field
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.purple),
          prefixIcon: icon != null
              ? Icon(icon, color: Colors.purple)
              : null, // Add prefix icon
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.pink, width: 1),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.pink, width: 1),
          ),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? 'This field is required' : null,
      ),
    ),
  );
}

Widget _buildDateField(String label, TextEditingController controller) {
  return Center( // Center the date field
    child: SizedBox(
      width: 400, // Ensure consistent width with other fields
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (pickedDate != null) {
            setState(() {
              lastPeriodStart = pickedDate;
              controller.text = pickedDate.toLocal().toString().split(' ')[0];
            });
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(color: Colors.purple),
              prefixIcon: const Icon(Icons.date_range, color: Colors.purple),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                borderSide: BorderSide(color: Colors.pink, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                borderSide: BorderSide(color: Colors.pink, width: 1),
              ),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'This field is required' : null,
          ),
        ),
      ),
    ),
  );
}
}