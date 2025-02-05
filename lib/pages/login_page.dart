import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
      enableDrag: false, // Prevents dragging down to close
      backgroundColor: Colors.transparent,
      builder: (context) => WillPopScope(
        // Prevents back button from closing
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
                child: BottomSheet(),
              ),
            ),
          ],
        ),
      ),
    );
  }

//   Widget buildLoginForm(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height *
//             0.75, // 75% of the screen height
//       ),
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 44,
//         right: 44,
//         top: 26,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 20),

//           // Title Text
//           Text(
//             !_isCorrectOtp?  "India's #1 Digital\nInvitation App" :"You are just one step away !",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//                 fontSize: 24,
//                 fontWeight:!_isCorrectOtp? FontWeight.bold :FontWeight.normal,
//                 height: 1.2,
//                 color: const Color(0xff636363)),
//           ),
//           const SizedBox(height: 50),
//           if(_isCorrectOtp && _isOtpSent)
//           Column(
//   children: [
//     Container(
//       width: double.infinity, // Make it take full width
//       alignment: Alignment.centerLeft, // Align text to the left
//       child: Text(
//         "Enter Couple's First Name",
//         style: TextStyle(
//           fontSize: 16,
//           height: 1.2,
//           color: Color.fromARGB(255, 168, 166, 166),
//         ),
//       ),
//     ),
//     SizedBox(height: 20),
//     // First Row with Two TextFields
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the fields
//       children: [
//         // First TextField
//         Container(
//           width: 140, // Adjust width as needed
//           child: TextField(
//             controller: _groomNameController,
//             decoration: InputDecoration(
//               labelText: 'Groom Name',
//               labelStyle: TextStyle(color: Colors.grey.shade600),
//               floatingLabelBehavior: FloatingLabelBehavior.never, // Keep the label fixed
//               border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.green, width: 2),
//                   ),
//             ),
//           ),
//         ),
//         SizedBox(width: 10), // Space between the two textfields
//         // Second TextField
//         Container(
//           width: 140,
//           child: TextField(
//             controller: _brideNameController,
//             decoration: InputDecoration(
//               labelText: 'Bride Name',
//               labelStyle: TextStyle(color: Colors.grey.shade600),
//               floatingLabelBehavior: FloatingLabelBehavior.never, // Keep the label fixed
//               border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.green, width: 2),
//                   ),
//             ),
//           ),
//         ),
//       ],
//     ),
//     SizedBox(height: 20), // Space between the rows

//     // Label for the bottom field
//     Container(
//       width: double.infinity, // Make it take full width
//       alignment: Alignment.centerLeft, // Align text to the left
//       child: Text(
//         "Your Wedding Date",
//         style: TextStyle(
//           fontSize: 16,
//           height: 1.2,
//           color: Color.fromARGB(255, 168, 166, 166),
//         ),
//       ),
//     ),
//     SizedBox(height: 20),
//     // Bottom TextField (full width)
//     Container(
//       width: double.infinity, // Make it take full width
//       child: TextField(
//         controller: _weddingDateController,
//         decoration: InputDecoration(
//           labelText: '15 December 2024',
//           labelStyle: TextStyle(color: Colors.grey.shade600),
//           floatingLabelBehavior: FloatingLabelBehavior.never, // Keep the label fixed
//           border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.green, width: 2),
//                   ),
//         ),
//       ),
//     ),
//   ],
// ),

// if(_isOtpSent&& _isCorrectOtp)
// const SizedBox(height: 50),


//           if (_isOtpSent && !_isCorrectOtp)
//             Container(
//               width: double.infinity, // Make it take full width
//               alignment: Alignment.centerLeft, // Align text to the left
//               child: Text(
//                 "Enter OTP",
//                 style: TextStyle(
//                   fontSize: 16,
//                   height: 1.2,
//                   color: Color.fromARGB(255, 168, 166, 166),
//                 ),
//               ),
//             ), 
//           if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 10),
//           if (_isOtpSent && !_isCorrectOtp)
//             Container(
//               width: double.infinity, // Make it take full width
//               alignment: Alignment.center, // Align text to the center
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment
//                     .spaceBetween, // Align OTP fields in the center
//                 children: [
//                   // OTP Field 1
//                   Container(
//                     width: 60, // Adjust width for each field
//                     height: 60, // Adjust height for each field
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       maxLength: 1, // Limit to 1 digit per field
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         counterText: '', // Hide counter text
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (value) {
//                         // Handle input change
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10), // Space between OTP fields
//                   // OTP Field 2
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (value) {
//                         // Handle input change
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10), // Space between OTP fields
//                   // OTP Field 3
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (value) {
//                         // Handle input change
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10), // Space between OTP fields
//                   // OTP Field 4
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: TextField(
//                       keyboardType: TextInputType.number,
//                       maxLength: 1,
//                       textAlign: TextAlign.center,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         border: InputBorder.none,
//                       ),
//                       onChanged: (value) {
//                         // Handle input change
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 50),
//           if (_isOtpSent && !_isCorrectOtp)
//             Container(
//               width: double.infinity, // Make it take full width
//               alignment: Alignment.center, // Align text to the left
//               child: Text(
//                 "Didn't get OTP?",
//                 style: TextStyle(
//                   fontSize: 18,
//                   height: 1.2,
//                   color: Color.fromARGB(255, 168, 166, 166),
//                 ),
//               ),
//             ),
//           if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 10),
//           if (_isOtpSent && !_isCorrectOtp)
//             Container(
//               width: double.infinity, // Make it take full width
//               alignment: Alignment.center, // Align text to the left
//               child: GestureDetector(
//                 child: Text(
//                   "RESEND OTP",
//                   style: TextStyle(
//                     fontSize: 16,
//                     height: 1.2,
//                     color: Color(0xFF4E9459), // Text color
//                     decoration: TextDecoration.underline, // Underline the text
//                     decorationColor: Color(0xFF4E9459),
//                   ),
//                 ),
//               ),
//             ),

//           if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 20),
//           // Phone Number Input with Country Flag and Code
//           // Phone Number Input with Country Flag and Code
//           // Phone Number Label
//           if (!_isOtpSent)
//             Container(
//               width: double.infinity, // Make it take full width
//               alignment: Alignment.centerLeft, // Align text to the left
//               child: Text(
//                 "Phone Number",
//                 style: TextStyle(
//                   fontSize: 16,
//                   height: 1.2,
//                   color: Color.fromARGB(255, 168, 166, 166),
//                 ),
//               ),
//             ),
//           if (!_isOtpSent) const SizedBox(height: 10),
//           if (!_isOtpSent)
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: IntlPhoneField(
//                 controller: _phoneController,
//                 dropdownDecoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border(
//                     right: BorderSide(color: Colors.grey.shade300),
//                   ),
//                 ),
//                 showDropdownIcon: false, // Hide dropdown arrow
//                 disableLengthCheck: true,
//                 decoration: InputDecoration(
//                   labelText: 'Enter your Ph. Number',
//                   labelStyle: TextStyle(color: Colors.grey.shade600),
//                   floatingLabelBehavior: FloatingLabelBehavior.never,
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 14, horizontal: 16),
//                   filled: true, // Keep it filled to match UI
//                   fillColor: Colors.white,

//                   // Border styles
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         BorderSide(color: Colors.grey.shade300, width: 1),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: Colors.green, width: 2),
//                   ),
//                 ),
//                 initialCountryCode: 'IN', // Default country code
//                 onChanged: (phone) {
//                   // Handle phone number change
//                 },
//               ),
//             ),
//           if (!_isOtpSent) const SizedBox(height: 20),

//           // Continue Button
//           ElevatedButton(
//             onPressed: () {
//               // Handle continue button press
              
//               setState(() {
//                 if (!_isOtpSent && !_isCorrectOtp) {
//                   _isOtpSent = true;
//                   // Handle OTP verification
//                 } else if(_isOtpSent && !_isCorrectOtp){
//                   _isCorrectOtp = false;
//                   // Handle OTP verification
//                 }
//                  else {
                 
//                   // Handle phone number verification
//                 }
//               });
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Color(0xFF4E9459),
//               minimumSize: const Size(double.infinity, 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Continue',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 4,
//                 ),
//                 PhosphorIcon(
//                   PhosphorIcons.arrowRight(),
//                   color: Colors.white,
//                   size: 24,
//                 ),
//               ],
//             ),
//           ),
//           if (!_isOtpSent) const SizedBox(height: 20),

//           // OR Divider
//           if (!_isOtpSent)
//             Row(
//               children: [
//                 Expanded(child: Divider(color: Colors.grey.shade300)),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: Text(
//                     'OR',
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ),
//                 Expanded(child: Divider(color: Colors.grey.shade300)),
//               ],
//             ),
//           if (!_isOtpSent) const SizedBox(height: 20),

//           // Google Sign In Button with Material Icon
//           if (!_isOtpSent)
//             Container(
//               width: 70, // Increased circular size
//               height: 70, // Increased circular size
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: InkWell(
//                 borderRadius: BorderRadius.circular(40), // Match circular shape
//                 onTap: () {
//                   // Handle Google sign-in
//                 },
//                 child: Image.asset(
//                   ImageConstant.googleLogo,
//                   width: 70, // Increase the image width
//                   height: 70, // Increase the image height
//                   fit: BoxFit.contain, // Ensure image scales correctly
//                 ),
//               ),
//             ),

//           const SizedBox(height: 60),
//         ],
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.unsplash.com/photo-1519225421980-715cb0215aed?q=80&w=300'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({super.key});

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {

  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  final TextEditingController _groomNameController = TextEditingController();
  final TextEditingController _brideNameController = TextEditingController();
  final TextEditingController _weddingDateController = TextEditingController();
  bool _isOtpSent = false;
  bool _isCorrectOtp = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *
            0.75, // 75% of the screen height
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
          Text(
            !_isCorrectOtp?  "India's #1 Digital\nInvitation App" :"You are just one step away !",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight:!_isCorrectOtp? FontWeight.bold :FontWeight.normal,
                height: 1.2,
                color: const Color(0xff636363)),
          ),
          const SizedBox(height: 50),
          if(_isCorrectOtp && _isOtpSent)
          Column(
  children: [
    Container(
      width: double.infinity, // Make it take full width
      alignment: Alignment.centerLeft, // Align text to the left
      child: Text(
        "Enter Couple's First Name",
        style: TextStyle(
          fontSize: 16,
          height: 1.2,
          color: Color.fromARGB(255, 168, 166, 166),
        ),
      ),
    ),
    SizedBox(height: 20),
    // First Row with Two TextFields
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out the fields
      children: [
        // First TextField
        Container(
          width: 140, // Adjust width as needed
          child: TextField(
            controller: _groomNameController,
            decoration: InputDecoration(
              labelText: 'Groom Name',
              labelStyle: TextStyle(color: Colors.grey.shade600),
              floatingLabelBehavior: FloatingLabelBehavior.never, // Keep the label fixed
              border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
            ),
          ),
        ),
        SizedBox(width: 10), // Space between the two textfields
        // Second TextField
        Container(
          width: 140,
          child: TextField(
            controller: _brideNameController,
            decoration: InputDecoration(
              labelText: 'Bride Name',
              labelStyle: TextStyle(color: Colors.grey.shade600),
              floatingLabelBehavior: FloatingLabelBehavior.never, // Keep the label fixed
              border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
            ),
          ),
        ),
      ],
    ),
    SizedBox(height: 20), // Space between the rows

    // Label for the bottom field
    Container(
      width: double.infinity, // Make it take full width
      alignment: Alignment.centerLeft, // Align text to the left
      child: Text(
        "Your Wedding Date",
        style: TextStyle(
          fontSize: 16,
          height: 1.2,
          color: Color.fromARGB(255, 168, 166, 166),
        ),
      ),
    ),
    SizedBox(height: 20),
    // Bottom TextField (full width)
    Container(
      width: double.infinity, // Make it take full width
      child: TextField(
        controller: _weddingDateController,
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Disable past dates
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary:
                  Color(0xFF4E9459), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      if (pickedDate != null) {
        _weddingDateController.text =
            DateFormat('dd MMMM yyyy').format(pickedDate);
      }
    });
        },
        decoration: InputDecoration(
          labelText: '15 December 2024',
          labelStyle: TextStyle(color: Colors.grey.shade600),
          floatingLabelBehavior: FloatingLabelBehavior.never, // Keep the label fixed
          border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
        ),
      ),
    ),
  ],
),

if(_isOtpSent&& _isCorrectOtp)
const SizedBox(height: 50),


          if (_isOtpSent && !_isCorrectOtp)
            Container(
              width: double.infinity, // Make it take full width
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                "Enter OTP",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.2,
                  color: Color.fromARGB(255, 168, 166, 166),
                ),
              ),
            ), 
          if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 10),
          if (_isOtpSent && !_isCorrectOtp)
            Container(
              width: double.infinity, // Make it take full width
              alignment: Alignment.center, // Align text to the center
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align OTP fields in the center
                children: [
                  // OTP Field 1
                  Container(
                    width: 60, // Adjust width for each field
                    height: 60, // Adjust height for each field
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _otpControllers[0],
                      keyboardType: TextInputType.number,
                      maxLength: 1, // Limit to 1 digit per field
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '', // Hide counter text
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Handle input change
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Space between OTP fields
                  // OTP Field 2
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _otpControllers[1],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Handle input change
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Space between OTP fields
                  // OTP Field 3
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _otpControllers[2],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Handle input change
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Space between OTP fields
                  // OTP Field 4
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _otpControllers[3],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // Handle input change
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 50),
          if (_isOtpSent && !_isCorrectOtp)
            Container(
              width: double.infinity, // Make it take full width
              alignment: Alignment.center, // Align text to the left
              child: Text(
                "Didn't get OTP?",
                style: TextStyle(
                  fontSize: 18,
                  height: 1.2,
                  color: Color.fromARGB(255, 168, 166, 166),
                ),
              ),
            ),
          if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 10),
          if (_isOtpSent && !_isCorrectOtp)
            Container(
              width: double.infinity, // Make it take full width
              alignment: Alignment.center, // Align text to the left
              child: GestureDetector(
                child: Text(
                  "RESEND OTP",
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.2,
                    color: Color(0xFF4E9459), // Text color
                    decoration: TextDecoration.underline, // Underline the text
                    decorationColor: Color(0xFF4E9459),
                  ),
                ),
              ),
            ),

          if (_isOtpSent && !_isCorrectOtp) const SizedBox(height: 20),
          // Phone Number Input with Country Flag and Code
          // Phone Number Input with Country Flag and Code
          // Phone Number Label
          if (!_isOtpSent)
            Container(
              width: double.infinity, // Make it take full width
              alignment: Alignment.centerLeft, // Align text to the left
              child: Text(
                "Phone Number",
                style: TextStyle(
                  fontSize: 16,
                  height: 1.2,
                  color: Color.fromARGB(255, 168, 166, 166),
                ),
              ),
            ),
          if (!_isOtpSent) const SizedBox(height: 10),
          if (!_isOtpSent)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: IntlPhoneField(
                controller: _phoneController,
                dropdownDecoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                showDropdownIcon: false, // Hide dropdown arrow
                disableLengthCheck: true,
                decoration: InputDecoration(
                  labelText: 'Enter your Ph. Number',
                  labelStyle: TextStyle(color: Colors.grey.shade600),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  filled: true, // Keep it filled to match UI
                  fillColor: Colors.white,

                  // Border styles
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                initialCountryCode: 'IN', // Default country code
                onChanged: (phone) {
                  // Handle phone number change
                },
              ),
            ),
          if (!_isOtpSent) const SizedBox(height: 20),

          // Continue Button
          ElevatedButton(
            onPressed: () {
              // Handle continue button press
              
              setState(() {
                if (!_isOtpSent && !_isCorrectOtp) {
                  _isOtpSent = true;
                  // Handle OTP verification
                } else if(_isOtpSent && !_isCorrectOtp){
                  _isCorrectOtp = true;
                  // Handle OTP verification
                }
                 else {
                 
                  // Handle phone number verification
                }
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E9459),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                PhosphorIcon(
                  PhosphorIcons.arrowRight(),
                  color: Colors.white,
                  size: 24,
                ),
              ],
            ),
          ),
          if (!_isOtpSent) const SizedBox(height: 20),

          // OR Divider
          if (!_isOtpSent)
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
          if (!_isOtpSent) const SizedBox(height: 20),

          // Google Sign In Button with Material Icon
          if (!_isOtpSent)
            Container(
              width: 70, // Increased circular size
              height: 70, // Increased circular size
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(40), // Match circular shape
                onTap: () {
                  // Handle Google sign-in
                },
                child: Image.asset(
                  ImageConstant.googleLogo,
                  width: 70, // Increase the image width
                  height: 70, // Increase the image height
                  fit: BoxFit.contain, // Ensure image scales correctly
                ),
              ),
            ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
