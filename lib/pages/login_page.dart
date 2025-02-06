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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoginBottomSheet(context);
    });
  }

  void showLoginBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
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
                child: ResponsiveBottomSheet(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1519225421980-715cb0215aed?q=80&w=300'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ResponsiveBottomSheet extends StatefulWidget {
  const ResponsiveBottomSheet({super.key});

  @override
  State<ResponsiveBottomSheet> createState() => _ResponsiveBottomSheetState();
}

class _ResponsiveBottomSheetState extends State<ResponsiveBottomSheet> {
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(6, (index) => TextEditingController());
  final TextEditingController _groomNameController = TextEditingController();
  final TextEditingController _brideNameController = TextEditingController();
  final TextEditingController _weddingDateController = TextEditingController();
  
  bool _isOtpSent = false;
  bool _isCorrectOtp = false;
  bool _isLoading = false;
  String? _phoneError;
  String? _otpError;

  // Focus nodes for better field navigation
  final List<FocusNode> _otpFocusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    _phoneController.dispose();
    _otpControllers.forEach((controller) => controller.dispose());
    _otpFocusNodes.forEach((node) => node.dispose());
    _groomNameController.dispose();
    _brideNameController.dispose();
    _weddingDateController.dispose();
    super.dispose();
  }

  // Responsive text size helper
  double getResponsiveTextSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  // Validate phone number
  bool _validatePhone() {
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      setState(() => _phoneError = 'Please enter a valid phone number');
      return false;
    }
    setState(() => _phoneError = null);
    return true;
  }

  // Validate OTP
  bool _validateOTP() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length != 4) {
      setState(() => _otpError = 'Please enter a valid OTP');
      return false;
    }
    setState(() => _otpError = null);
    return true;
  }

  // Handle OTP field input
  void _handleOtpInput(String value, int index) {
    if (value.length == 1 && index < 3) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    return Container(
      width: double.maxFinite,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: screenSize.width * 0.1,
        right: screenSize.width * 0.1,
        top: screenSize.width * 0.06,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: screenSize.height * 0.02),
            
            // Title Text
            Text(
              !_isCorrectOtp ? "India's #1 Digital\nInvitation App" : "You are just one step away!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getResponsiveTextSize(context, 0.06),
                fontWeight: !_isCorrectOtp ? FontWeight.bold : FontWeight.normal,
                height: 1.2,
                color: const Color(0xff636363),
              ),
            ),
            
            SizedBox(height: screenSize.height * 0.04),

            // Conditional widgets based on state
            if (!_isOtpSent) _buildPhoneInput(context),
            if (_isOtpSent && !_isCorrectOtp) _buildOtpInput(context),
            if (_isCorrectOtp) _buildCoupleDetailsForm(context),

            SizedBox(height: screenSize.height * 0.03),

            // Continue Button
            _buildContinueButton(context),

            if (!_isOtpSent) ...[
              SizedBox(height: screenSize.height * 0.02),
              _buildOrDivider(),
              SizedBox(height: screenSize.height * 0.02),
              _buildGoogleSignIn(context),
            ],

            SizedBox(height: screenSize.height * 0.04),
          ],
        ),
      ),
    );
  }

  // Update the phone input field style:
  Widget _buildPhoneInput(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Phone Number",
        style: TextStyle(
          fontSize: getResponsiveTextSize(context, 0.04),
          color: Color.fromARGB(255, 168, 166, 166),
        ),
      ),
      SizedBox(height: 8),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: IntlPhoneField(
          controller: _phoneController,
          dropdownDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            border: Border(
              right: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          showDropdownIcon: false,
          disableLengthCheck: true,
          decoration: InputDecoration(
            labelText: 'Enter your Ph. Number',
            errorText: _phoneError,
            labelStyle: TextStyle(
              fontSize: getResponsiveTextSize(context, 0.035),
              color: Colors.grey.shade600,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) => setState(() => _phoneError = null),
          flagsButtonPadding: EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    ],
  );
}

  // In the _buildOtpInput method, update to include the "Didn't get OTP" and "Resend OTP" sections:

  Widget _buildOtpInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter OTP",
          style: TextStyle(
            fontSize: getResponsiveTextSize(context, 0.04),
            color: Color.fromARGB(255, 168, 166, 166),
          ),
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (index) => Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                keyboardType: TextInputType.number,
                maxLength: 1,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getResponsiveTextSize(context, 0.05)),
                decoration: InputDecoration(
                  counterText: '',
                  border: InputBorder.none,
                ),
                onChanged: (value) => _handleOtpInput(value, index),
              ),
            ),
          ),
        ),
        if (_otpError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _otpError!,
              style: TextStyle(
                color: Colors.red,
                fontSize: getResponsiveTextSize(context, 0.035),
              ),
            ),
          ),
        SizedBox(height: 50),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            "Didn't get OTP?",
            style: TextStyle(
              fontSize: getResponsiveTextSize(context, 0.045),
              color: Color.fromARGB(255, 168, 166, 166),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              // Handle resend OTP
            },
            child: Text(
              "RESEND OTP",
              style: TextStyle(
                fontSize: getResponsiveTextSize(context, 0.04),
                color: Color(0xFF4E9459),
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF4E9459),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Update the couple details form TextFields:
  Widget _buildCoupleDetailsForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Couple's First Name",
          style: TextStyle(
            fontSize: getResponsiveTextSize(context, 0.04),
            color: Color.fromARGB(255, 168, 166, 166),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _groomNameController,
                decoration: InputDecoration(
                  labelText: 'Groom Name',
                  labelStyle: TextStyle(
                    fontSize: getResponsiveTextSize(context, 0.035),
                    color: Colors.grey.shade600,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _brideNameController,
                decoration: InputDecoration(
                  labelText: 'Bride Name',
                  labelStyle: TextStyle(
                    fontSize: getResponsiveTextSize(context, 0.035),
                    color: Colors.grey.shade600,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
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
        SizedBox(height: 24),
        Text(
          "Your Wedding Date",
          style: TextStyle(
            fontSize: getResponsiveTextSize(context, 0.04),
            color: Color.fromARGB(255, 168, 166, 166),
          ),
        ),
        SizedBox(height: 16),
        _buildDatePicker(context),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return TextField(
      controller: _weddingDateController,
      readOnly: true,
      onTap: () => _showDatePicker(context),
      decoration: InputDecoration(
        labelText: '15th December 2024',
        labelStyle: TextStyle(
                    fontSize: getResponsiveTextSize(context, 0.035),
                    color: Colors.grey.shade600,
                  ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF4E9459),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _weddingDateController.text = DateFormat('dd MMMM yyyy').format(picked);
      });
    }
  }

  Widget _buildContinueButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _handleContinue(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4E9459),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: _isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: getResponsiveTextSize(context, 0.04),
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                PhosphorIcon(
                  PhosphorIcons.arrowRight(),
                  color: Colors.white,
                ),
              ],
            ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey[300])),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildGoogleSignIn(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.15;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: () => _handleGoogleSignIn(),
        child: Image.asset(
          ImageConstant.googleLogo,
          width: size * 0.6,
          height: size * 0.6,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  void _handleContinue() async {
    setState(() => _isLoading = true);

    try {
      if (!_isOtpSent) {
        if (_validatePhone()) {
          // Simulate API call
          await Future.delayed(Duration(seconds: 1));
          setState(() => _isOtpSent = true);
        }
      } else if (!_isCorrectOtp) {
        if (_validateOTP()) {
          // Simulate API call
          await Future.delayed(Duration(seconds: 1));
          setState(() => _isCorrectOtp = true);
        }
      } else {
        if (_validateCoupleDetails()) {
          // Simulate final submission
          await Future.delayed(Duration(seconds: 1));
          // Navigate to next screen or handle success
          print('Registration complete');
        }
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    try {
      // Implement Google Sign In
      await Future.delayed(Duration(seconds: 1));
      print('Google Sign In');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign In failed. Please try again.')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool _validateCoupleDetails() {
    if (_groomNameController.text.isEmpty ||
        _brideNameController.text.isEmpty ||
        _weddingDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return false;
    }
    return true;
  }
}

// Add these utility extensions for responsive sizing
extension ResponsiveSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  
  double wp(double percentage) => screenWidth * percentage / 100;
  double hp(double percentage) => screenHeight * percentage / 100;
  
  bool get isSmallScreen => screenWidth < 360;
  bool get isMediumScreen => screenWidth >= 360 && screenWidth < 600;
  bool get isLargeScreen => screenWidth >= 600;
}