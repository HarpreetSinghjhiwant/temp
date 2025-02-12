import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String type = 'South Indian';
  final List<Map<String, String>> pdfInvites = [
    {
      "title": "Title 1",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 2",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 3",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 4",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 5",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 6",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 7",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 8",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 9",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 10",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 11",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 12",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 13",
      "image": "assets/home_page_assets/image.png",
    },
    {
      "title": "Title 14",
      "image": "assets/home_page_assets/image.png",
    },
  ];

  Widget _buildPdfInvites(String image, String title) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center contents in the column
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xff4E9459),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400]!,
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: 173, // Make the image fill the container
              height: 259,
              // Adjust height as needed
            ),
          ),
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(color: Color(0xff737373), fontSize: 15),
          ),
          textAlign: TextAlign.center, // Center the text
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.back,
                      size: 30, color: Color(0xff9D9D9D)),
                ),
              ),
              Text(
                'PDF Invites',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: Color(0xff969696),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE2E2E2)),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<String>(
                  value: type, // Set initial value
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Icon(
                      PhosphorIcons.caretDown(),
                      size: 24,
                      color: Color(0xff6D6D6D),
                    ),
                  ),
                  style: GoogleFonts.roboto(
                    textStyle:
                        TextStyle(color: Color(0xff4E9459), fontSize: 16),
                  ),
                  underline: Container(
                    height: 0,
                  ),
                  items: <String>[
                    'South Indian',
                    'North Indian',
                    'Western',
                    'Others',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      // Handle value change
                      type = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE2E2E2)),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12),
                  child: Row(
                    children: [
                      Text(
                        "Couple's Details",
                        style: GoogleFonts.roboto(
                          textStyle:
                              TextStyle(color: Color(0xff6D6D6D), fontSize: 14),
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(PhosphorIcons.pencilSimpleLine(),
                          size: 24, color: Color(0xff4E9459)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildContact() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Contact',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Color(0xff6F6F6F),
                              fontSize: 16,
                              fontWeight: FontWeight.bold))),
                ),
                SizedBox(height: 12),
                _buildContactRow(PhosphorIcons.phoneCall(), '+91-8005993442'),
                SizedBox(height: 12),
                _buildContactRow(
                    PhosphorIcons.envelopeSimple(), 'support@celebrare.in'),
              ],
            ),
          ),

          // Connect With Us
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Connect With Us on',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Color(0xff6F6F6F),
                              fontSize: 14,
                              fontWeight: FontWeight.bold))),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      _buildSocialLogo(ImageConstant.pinterestLogo),
                      _buildSocialLogo(ImageConstant.instagramLogo),
                      _buildSocialLogo(ImageConstant.facebookLogo),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Helper widget for Contact Rows
  Widget _buildContactRow(IconData iconData, String info) {
    return Row(
      children: [
        Icon(iconData, size: 24, color: Color(0xff6F6F6F)),
        SizedBox(width: 6),
        Flexible(
          child: Text(info,
              style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(color: Color(0xff6F6F6F), fontSize: 14))),
        ),
      ],
    );
  }

// Helper widget for Social Logos
  Widget _buildSocialLogo(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Image.asset(assetPath, width: 24, height: 24),
    );
  }

  Widget _buildButton(String title, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: 199,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xff4E9459),
          borderRadius: BorderRadius.circular(50), // Pill shape
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Ensures space between text and icon
          children: [
            SizedBox(
              width: 12,
            ),
            // Text Widget
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
            ),

            // Icon inside a circular container
            Padding(
              padding: const EdgeInsets.all(1.5),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xff4E9459), width: 2),
                ),
                child: Icon(
                  PhosphorIcons.arrowDown(),
                  size: 24.0,
                  color: Color(0xff4E9459),
                ),
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff4E9459),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '❄️ ',
                            style:
                                TextStyle(fontSize: 16), // Emoji stays colorful
                          ),
                          TextSpan(
                            text: 'Winter Sale get 60% OFF! Upto 120 Rs ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16), // White text
                          ),
                          TextSpan(
                            text: '🎉',
                            style:
                                TextStyle(fontSize: 16), // Emoji stays colorful
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _buildMenuSection(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.center,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2, // Added spacing for better visuals
                      mainAxisSpacing: 2,
                      childAspectRatio:
                          0.6, // Adjust aspect ratio to control item sizing
                    ),
                    itemBuilder: (context, index) {
                      return _buildPdfInvites(
                        pdfInvites[index]['image']!,
                        pdfInvites[index]['title']!,
                      );
                    },
                    itemCount: 14,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ),
              SizedBox(height: 8),
              _buildButton('Show More', () {}),
              SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Divider(
                  color: Color.fromARGB(255, 211, 208, 208),
                  thickness: 1,
                ),
              ),
              SizedBox(height: 12),
              _buildContact(),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }
}
