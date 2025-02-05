import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Open bottom sheet after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoginBottomSheet(context);
    });
  }

  void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false, // Prevents closing when clicking outside
      enableDrag: false,    // Prevents dragging down to close
      backgroundColor: Colors.transparent,
      builder: (context) => WillPopScope( // Prevents back button from closing
        onWillPop: () async => false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Bottom Sheet Content
            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: buildLoginForm(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75, // 75% of the screen height
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 44,
        right: 44,
        top: 26,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          
          // Title Text
          const Text(
            "India's #1 Digital\nInvitation App",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 30),
          
          // Phone Number Input with Country Flag and Code
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: IntlPhoneField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              initialCountryCode: 'IN', 
              dropdownIcon: Icon(Icons.arrow_drop_down,color: Colors.transparent,),// Default country code
              onChanged: (phone) {
                // Handle phone number change
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Continue Button
          ElevatedButton(
            onPressed: () {
              // Handle continue button press
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E9459),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // OR Divider
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey.shade300)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey.shade300)),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Google Sign In Button with Material Icon
          Container(
            width: 50, // Fixed width for circular shape
            height: 50, // Fixed height for circular shape
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextButton(
              onPressed: () {
                // Handle Google sign in
              },
              child: Icon(
                Icons.g_translate, // Google icon from Material Icons
                size: 30,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1519225421980-715cb0215aed?q=80&w=300'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
