import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final TextEditingController _phoneController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (index) => TextEditingController());
  final TextEditingController _groomNameController = TextEditingController();
  final TextEditingController _brideNameController = TextEditingController();
  final TextEditingController _weddingDateController = TextEditingController();

  bool _isOtpSent = false;
  bool _isCorrectOtp = false;
  bool _isLoading = false;
  String? _phoneError;
  String? _otpError;

  final List<FocusNode> _otpFocusNodes =
      List.generate(4, (index) => FocusNode());

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

  double getResponsiveTextSize(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Image Section (50% of screen height)
            Stack(
              children: [
                Container(
                  height: screenSize.height * 0.45,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_page_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (!_isCorrectOtp)
                  Positioned(
                    top: 40, // Distance from the top of the screen
                    right: 30, // Distance from the right side of the screen
                    child:
                        _buildSkipButton(), // Skip button positioned on top-right
                  ),
              ],
            ),

            // Bottom White Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.1,
                vertical: screenSize.height * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    !_isCorrectOtp
                        ? "India's #1 Digital\nInvitation App"
                        : "You are just one step away!",
                    textAlign:
                        !_isCorrectOtp ? TextAlign.center : TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: !_isCorrectOtp ? 24 : 22,
                      fontWeight:
                          !_isCorrectOtp ? FontWeight.w600 : FontWeight.normal,
                      height: 1.2,
                      color: !_isCorrectOtp
                          ? const Color(0xff636363)
                          : Color(0xff747474),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.06),
                  if (!_isOtpSent) _buildPhoneInput(context),
                  if (_isOtpSent && !_isCorrectOtp) _buildOtpInput(context),
                  if (_isCorrectOtp) _buildCoupleDetailsForm(context),
                  if (_isOtpSent) SizedBox(height: screenSize.height * 0.05),
                  if (!_isOtpSent) SizedBox(height: screenSize.height * 0.03),
                  _buildContinueButton(context),
                  if (!_isOtpSent) ...[
                    SizedBox(height: screenSize.height * 0.02),
                    _buildOrDivider(),
                    SizedBox(height: screenSize.height * 0.02),
                    _buildGoogleSignIn(context),
                    SizedBox(height: screenSize.height * 0.02),
                  ],
                  if (_isOtpSent) SizedBox(height: screenSize.height * 0.04),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Rest of the code remains the same as in the previous version...
  // Include all the widget building methods (_buildPhoneInput, _buildOtpInput, etc.)
  // and helper methods (_handleContinue, _validatePhone, etc.) from the previous version

  Widget _buildPhoneInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: GoogleFonts.manrope(
            fontSize: getResponsiveTextSize(context, 0.04),
            color: Color(0xff7B7B7B),
          ),
        ),
        SizedBox(height: 8),
        IntlPhoneField(
          controller: _phoneController,
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              border: Border(right: BorderSide(color: Colors.grey.shade300))),
          showDropdownIcon: false,
          disableLengthCheck: true,
          decoration: InputDecoration(
            hintText: 'Enter your Ph. Number',
            errorText: _phoneError,
            hintStyle: GoogleFonts.manrope(
              fontSize: getResponsiveTextSize(context, 0.035),
              color: Color(0xff7B7B7B),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.green, width: 2),
            ),
          ),
          initialCountryCode: 'IN',
          onChanged: (phone) => setState(() => _phoneError = null),
        ),
      ],
    );
  }

  Widget _buildOtpInput(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            "Enter OTP",
            style: GoogleFonts.manrope(
              fontSize: 16,
              color: Color(0xff7B7B7B),
            ),
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: 50,
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
                  style: GoogleFonts.manrope(
                      fontSize: getResponsiveTextSize(context, 0.05),
                      color: Color(0xff7B7B7B)),
                  cursorColor: Color(0xFF4E9459),
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) => _handleOtpInput(value, index),
                ),
              ),
            ),
          ),
        ),
        if (_otpError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _otpError!,
              style: GoogleFonts.manrope(
                color: Colors.red,
                fontSize: getResponsiveTextSize(context, 0.035),
              ),
            ),
          ),
        SizedBox(height: 38),
        Center(
          child: Column(
            children: [
              Text(
                "Didn't get OTP yet?",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color.fromARGB(255, 168, 166, 166),
                ),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  // Handle resend OTP
                },
                child: Text(
                  "RESEND OTP",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4E9459),
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xFF4E9459)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleOtpInput(String value, int index) {
    if (value.length == 1 && index < 3) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  Widget _buildCoupleDetailsForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Couple's First Name",
          style: GoogleFonts.manrope(
            fontSize: getResponsiveTextSize(context, 0.04),
            color: Color.fromARGB(255, 168, 166, 166),
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 151,
              height: 51,
              child: TextField(
                cursorColor: Color(0xFF4E9459),
                controller: _groomNameController,
                style: GoogleFonts.manrope(
                    color: Color.fromARGB(255, 113, 113, 113)),
                decoration: _getInputDecoration(context, 'Groom Name'),
              ),
            ),
            SizedBox(width: 16),
            Container(
              width: 151,
              height: 51,
              child: TextField(
                cursorColor: Color(0xFF4E9459),
                controller: _brideNameController,
                style: GoogleFonts.manrope(
                    color: Color.fromARGB(255, 113, 113, 113)),
                decoration: _getInputDecoration(context, 'Bride Name'),
              ),
            ),
          ],
        ),
        SizedBox(height: 24),
        Text(
          "Your Wedding Date",
          style: GoogleFonts.manrope(
            fontSize: getResponsiveTextSize(context, 0.04),
            color: Color(0xff7B7B7B),
          ),
        ),
        SizedBox(height: 16),
        Container(
          height: 51,
          width: double.infinity,
          child: TextField(
            cursorColor: Color(0xFF4E9459),
            controller: _weddingDateController,
            readOnly: true,
            style:
                GoogleFonts.manrope(color: Color.fromARGB(255, 113, 113, 113)),
            onTap: () => _showDatePicker(context),
            decoration: _getInputDecoration(context, '15th December 2024'),
          ),
        ),
      ],
    );
  }

  InputDecoration _getInputDecoration(BuildContext context, String label) {
    return InputDecoration(
      hintText: label, // Use hintText instead of labelText
      hintStyle: GoogleFonts.manrope(
        fontSize: getResponsiveTextSize(context, 0.035),
        color: Color.fromARGB(255, 113, 113, 113),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: Colors.green, width: 2),
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
      onPressed: _isLoading ? null : _handleContinue,
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
                  style: GoogleFonts.manrope(
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
            style: GoogleFonts.manrope(
                color: Colors.grey[600], fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey[300])),
      ],
    );
  }

  Widget _buildSkipButton() {
    return Container(
      width: 78,
      height: 40, // Add padding for spacing
      decoration: BoxDecoration(
        color: Colors.black
            .withOpacity(0.5), // Slight transparency for better visibility
        borderRadius: BorderRadius.circular(50), // Rounded corners
      ),
      child: Center(
        child: Text(
          'Skip',
          style: GoogleFonts.manrope(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
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
          onTap: _handleGoogleSignIn,
          child: Image.asset(ImageConstant.googleLogo)),
    );
  }

  void _handleContinue() async {
    setState(() => _isLoading = true);

    try {
      if (!_isOtpSent) {
        if (_validatePhone()) {
          await Future.delayed(Duration(seconds: 1));
          setState(() => _isOtpSent = true);
        }
      } else if (!_isCorrectOtp) {
        if (_validateOtp()) {
          await Future.delayed(Duration(seconds: 1));
          setState(() => _isCorrectOtp = true);
        }
      } else {
        if (_validateCoupleDetails()) {
          await Future.delayed(Duration(seconds: 1));
                  Navigator.pushReplacementNamed(context, '/home');
          // Navigate to next screen or handle success
          print('Registration complete');
        }
      }
    } catch (e) {
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
      // Implement Google Sign In logic here
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

  bool _validatePhone() {
    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      setState(() => _phoneError = 'Please enter a valid phone number');
      return false;
    }
    setState(() => _phoneError = null);
    return true;
  }

  bool _validateOtp() {
    String otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length != 4) {
      setState(() => _otpError = 'Please enter a valid OTP');
      return false;
    }
    setState(() => _otpError = null);
    return true;
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

// Extension for responsive sizing
extension ResponsiveSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double wp(double percentage) => screenWidth * percentage / 100;
  double hp(double percentage) => screenHeight * percentage / 100;

  bool get isSmallScreen => screenWidth < 360;
  bool get isMediumScreen => screenWidth >= 360 && screenWidth < 600;
  bool get isLargeScreen => screenWidth >= 600;
}
