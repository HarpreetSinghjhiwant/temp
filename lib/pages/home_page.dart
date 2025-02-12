import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';
import 'package:temp/widgets/home_page/video_comp.dart';
import 'package:temp/widgets/home_page/youtube_video_player.dart';
import 'package:google_fonts/google_fonts.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String,String>> customiseVideoUrls = [
    {
      "title":"Simran weds Shikhar",
      "description":"Our love story is just like a modern-day fairytale! 🌍❤️ From the snow-covered streets of Canada to the vibrant lanes of India.",
      "image":"assets/home_page_assets/Customise_order_1/image.jpeg",
      "video":"assets/home_page_assets/Customise_order_1/DDLJ.mp4",
    },
    {
      "title":"Siddharth weds Maithili",
      "description":"Our love story is just like a modern-day fairytale! 🌍❤️ From the snow-covered streets of Canada to the vibrant lanes of India.",
      "image":"assets/home_page_assets/Customise_order2/image.png",
      "video":"assets/home_page_assets/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
    {
      "title":"Kanchan Priya weds Drew",
      "description":"Our love story began in the heart of Bangalore, where fate brought a USA groom and an Indian bride together in the most magical way. 🇺🇸❤️🇮🇳 Amidst the vibrant culture, bustling streets, and unforgettable moments, we found each other.",
      "image":"assets/home_page_assets/Customise_order3/image.png",
      "video":"assets/home_page_assets/Customise_order3/Kanchan_Priya_weds_Drew1.mp4",
    },
  ];

  final List<Map<String,String>> pdfInvites = [
    {
      "title":"Title 1",
      "image":"assets/home_page_assets/image.png",
    },
    {
      "title":"Title 2",
      "image":"assets/home_page_assets/image.png",
    },
    {
      "title":"Title 3",
      "image":"assets/home_page_assets/image.png",
    },
    {
      "title":"Title 4",
      "image":"assets/home_page_assets/image.png",
    },
    {
      "title":"Title 5",
      "image":"assets/home_page_assets/image.png",
    },
    {
      "title":"Title 6",
      "image":"assets/home_page_assets/image.png",
    },
  ];

  final List<Map<String,String>> videoUrls = [
    {
      "image":"assets/images/img_2024_08_13_15_20_26_3191.png",
      "video":"assets/home_page_assets/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
    {
      "image":"assets/images/img_2024_08_13_15_20_26_3191.png",
      "video":"assets/home_page_assets/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
    {
      "image":"assets/images/img_2024_08_13_15_20_26_3191.png",
      "video":"assets/home_page_assets/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
  ];

  final List<Map<String,String>> reviewVideoUrls = [
    {
      "image":"assets/home_page_assets/Review/Review.png",
      "video":"https://www.youtube.com/shorts/pt8bFP2GoOs",
    },
    {
      "image":"assets/home_page_assets/Review/Shreya&Ron.png",
      "video":"https://www.youtube.com/shorts/1T_JRakNa-Y",
    },
    {
      "image":"assets/home_page_assets/Review/gigapixel-2.png",
      "video":"https://www.youtube.com/shorts/I-EUvSw5oMc",
    },
    {
      "image":"assets/home_page_assets/Review/gigapixel-3.png",
      "video":"https://www.youtube.com/shorts/jCH3Do8DhXw",
    },
    {
      "image":"assets/home_page_assets/Review/gigapixel-4.png",
      "video":"https://www.youtube.com/shorts/kePFAl-rlE8",
    },
  ];

  Widget _buildCustomizedInvites(String image, String video, String title, String description) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      width: 291,
      height: 639,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xffD7D7D7), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 29.5, // Half of the width and height
                  // backgroundImage: AssetImage(image),
                  backgroundColor: Colors.green,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style:GoogleFonts.roboto(textStyle: TextStyle(color: Color(0xff737373), fontSize: 17, fontWeight: FontWeight.bold)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              description,
              maxLines: 2,
              style:GoogleFonts.roboto(textStyle: TextStyle(color: Color(0xff737373), fontSize: 15,)),
            ),
          ),
          SizedBox(height: 12),
          _buildVideoCard(image,video),
        ],
      ),
    ),
  );
}


  Widget _buildFooterSection() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SingleChildScrollView(  // To handle overflow on smaller screens
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Our Founder',
              style:GoogleFonts.poppins(textStyle:  TextStyle(color: Color(0xffD9D9D9), fontSize: 45)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:18.0,bottom: 4),
            child: Text(
              'Abhinav Goyal',
              style:GoogleFonts.roboto(textStyle: TextStyle(color: Color(0xff6D6D6D), fontSize: 32)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:16.0,bottom: 12),
            child: Text(
              '( Alumni of IIT Hyderabad )',
              style: GoogleFonts.manrope(textStyle:TextStyle(color: Color(0xff6D6D6D), fontSize: 22)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:16.0,top: 14),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been tLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been t',
              style:GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xff6D6D6D), fontSize: 16)),
            ),
          ),
          
          // Social Media Icons and Image Section
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(
                          bottom: 3,
                          width: 600,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:28.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 211, 208, 208),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 211, 208, 208),
                                      spreadRadius: 0.2,
                                      blurRadius: 0.2
                                    )
                                  ]
                                ),
                                height: 1,
                                width: 343,
                              ),
                            ),
                          ),
                        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Social Icons
                  Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        _buildSocialIcon(PhosphorIcons.linkedinLogo()),
                        SizedBox(height: 30),
                        _buildSocialIcon(PhosphorIcons.instagramLogo()),
                      ],
                    ),
                  ),
                  
                  // Founder Image
              
                  Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Blurred Shadow Layer
                          Positioned(
                            bottom: 1, // Offset for shadow effect
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                  sigmaX: 10, sigmaY: 10), // Apply blur for shadow
                              child: Image.asset(
                                ImageConstant.Image,
                                width: 320,
                                height: 250,
                                color: Color(0xff4E9459), // Shadow color with transparency
                              ),
                            ),
                          ),
                          // Main Image (on top)
                          Image.asset(
                            ImageConstant.Image,
                            width: 284,
                            height: 244,
                            fit: BoxFit.fitHeight,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
            _buildContact(),
        ],
      ),
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

// Helper widget for Social Icons
Widget _buildSocialIcon(IconData iconData) {
  return Container(
    width: 48,
    height: 50,
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xff4E9459), width: 2),
      borderRadius: BorderRadius.circular(50),
    ),
    child: IconButton(
      onPressed: () {},
      icon: Icon(iconData, color: Color(0xff4E9459), size: 22),
    ),
  );
}

// Helper widget for Contact Rows
Widget _buildContactRow(IconData iconData, String info) {
  return Row(
    children: [
      Icon(iconData, size: 24, color: Color(0xff6D6D6D)),
      SizedBox(width: 6),
      Flexible(
        child: Text(info, style:GoogleFonts.roboto(textStyle: TextStyle(color: Color(0xff6D6D6D), fontSize: 14))),
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




  Widget _buildVideoCard(String image,String videoUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 277.95,
          height: 476.81,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff6D6D6D), width: 1),
              borderRadius: BorderRadius.circular(20)
              ),
          child: ClipRRect(borderRadius: BorderRadius.circular(20),child: SimpleVideoPlayer(videoUrl: videoUrl)),
        ),
      ),
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

 Widget _buildPdfInvites(String image, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,  // Center contents in the column
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color(0xff4E9459),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: 167,  // Make the image fill the container
            height: 167,
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
        textAlign: TextAlign.center,  // Center the text
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}



  Widget _buildMenu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffE5E5E5)),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.menu,size:26),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              ImageConstant.celebrareImage,
              width: 111,
              height: 25.55,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 20,
              // backgroundImage: AssetImage(ImageConstant.profileImage),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                              style: TextStyle(
                                  fontSize: 16), // Emoji stays colorful
                            ),
                            TextSpan(
                              text: 'Winter Sale get 60% OFF! Upto 120 Rs ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16), // White text
                            ),
                            TextSpan(
                              text: '🎉',
                              style: TextStyle(
                                  fontSize: 16), // Emoji stays colorful
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildMenu(),
                SizedBox(
                  height: 50,
                ),
                Container(
  child: Column(
    children: [
      Center(
        child: Text(
          'For Special',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: Color(0xff4E9459),
              letterSpacing: 3,
            ),
          ),
        ),
      ),
      Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20), // Move the image down
            child: Image.asset(
              ImageConstant.mainBackground,
              width: double.infinity,
              height: 244,
              fit: BoxFit.cover, // Ensures the image covers the area properly
            ),
          ),
          Center(
            child: Text(
              'Moments',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff4E9459),
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),


                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Text(
                      'PDF Invites',
                      style:GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffD9D9D9), fontSize: 45,fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
  padding: const EdgeInsets.all(12.0),
  child: Align(
    alignment: Alignment.center,
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,  // Added spacing for better visuals
        mainAxisSpacing: 2,
        childAspectRatio: 0.85,  // Adjust aspect ratio to control item sizing
      ),
      itemBuilder: (context, index) {
        return _buildPdfInvites(
          pdfInvites[index]['image']!,
          pdfInvites[index]['title']!,
        );
      },
      itemCount: 6,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    ),
  ),
),

                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: _buildButton('Create Now', () {}),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left:22.0),
                    child: Text(
                      'Video Invites',
                      style:GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffD9D9D9), fontSize: 45,fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 550, // Adjust height based on video card size
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      itemCount: videoUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _buildVideoCard(videoUrls[index]["image"]!,videoUrls[index]["video"]!),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: _buildButton('Explore All', () {}),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left:24.0),
                    child: Text(
                      'Reviews',
                      style:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffD9D9D9), fontSize: 45,fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 480, // Adjust height based on video card size
                  child: Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      itemCount: reviewVideoUrls.length,
                      itemBuilder: (context, index) {
                        return VideoReviewCard(image:reviewVideoUrls[index]["image"]!,videoUrl:reviewVideoUrls[index]["video"]!);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:22.0),
                  child: Container(
                    child: Text(
                      'Customized\ninvites',
                      style:GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffD9D9D9), fontSize: 45,fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 662, // Adjust height based on video card size
                  child: Padding(
                    padding: const EdgeInsets.only(left:12),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection:
                          Axis.horizontal, // Enable horizontal scrolling
                      itemCount: customiseVideoUrls.length,
                      itemBuilder: (context, index) {
                        return _buildCustomizedInvites(customiseVideoUrls[index]["image"]!,customiseVideoUrls[index]["video"]!,customiseVideoUrls[index]["title"]!,customiseVideoUrls[index]["description"]!);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  child: _buildButton('Contact Us', () {}),
                ),
                SizedBox(
                  height: 100,
                ),
                _buildFooterSection(),
                SizedBox(height: 60,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
