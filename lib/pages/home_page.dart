import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';
import 'package:temp/widgets/video_comp.dart';
import 'package:temp/widgets/youtube_video_player.dart';

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
      "image":"assets/Element_for_UI/Customise_order_1/image.jpeg",
      "video":"assets/Element_for_UI/Customise_order_1/DDLJ.mp4",
    },
    {
      "title":"Siddharth weds Maithili",
      "description":"Our love story is just like a modern-day fairytale! 🌍❤️ From the snow-covered streets of Canada to the vibrant lanes of India.",
      "image":"assets/Element_for_UI/Customise_order2/image.png",
      "video":"assets/Element_for_UI/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
    {
      "title":"Kanchan Priya weds Drew",
      "description":"Our love story began in the heart of Bangalore, where fate brought a USA groom and an Indian bride together in the most magical way. 🇺🇸❤️🇮🇳 Amidst the vibrant culture, bustling streets, and unforgettable moments, we found each other.",
      "image":"assets/Element_for_UI/Customise_order3/image.png",
      "video":"assets/Element_for_UI/Customise_order3/Kanchan_Priya_weds_Drew1.mp4",
    },
  ];

  final List<Map<String,String>> pdfInvites = [
    {
      "title":"Title 1",
      "image":"assets/Element_for UI/PDF Invites/1.png",
    },
    {
      "title":"Title 2",
      "image":"assets/Element_for UI/PDF Invites/2.png",
    },
    {
      "title":"Title 3",
      "image":"assets/Element_for UI/PDF Invites/3.png",
    },
    {
      "title":"Title 4",
      "image":"assets/Element_for UI/PDF Invites/4.png",
    },
    {
      "title":"Title 5",
      "image":"assets/Element_for UI/PDF Invites/5.png",
    },
    {
      "title":"Title 6",
      "image":"assets/Element_for_UI/PDF Invites/6.png",
    },
  ];

  final List<Map<String,String>> videoUrls = [
    {
      "image":"assets/images/img_2024_08_13_15_20_26_3191.png",
      "video":"assets/Element_for_UI/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
    {
      "image":"assets/images/img_2024_08_13_15_20_26_3191.png",
      "video":"assets/Element_for_UI/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
    {
      "image":"assets/images/img_2024_08_13_15_20_26_3191.png",
      "video":"assets/Element_for_UI/Customise_order2/Siddharth_weds_Maithili1.mp4",
    },
  ];

  final List<Map<String,String>> reviewVideoUrls = [
    {
      "image":"assets/Element_for_UI/Review/Review.png",
      "video":"https://www.youtube.com/shorts/pt8bFP2GoOs",
    },
    {
      "image":"assets/Element_for_UI/Review/Shreya&Ron.png",
      "video":"https://www.youtube.com/shorts/1T_JRakNa-Y",
    },
    {
      "image":"assets/Element_for_UI/Review/gigapixel-2.png",
      "video":"https://www.youtube.com/shorts/I-EUvSw5oMc",
    },
    {
      "image":"assets/Element_for_UI/Review/gigapixel-3.png",
      "video":"https://www.youtube.com/shorts/jCH3Do8DhXw",
    },
    {
      "image":"assets/Element_for_UI/Review/gigapixel-4.png",
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
                    style: TextStyle(color: Color(0xff737373), fontSize: 17, fontWeight: FontWeight.bold),
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
              style: TextStyle(color: Color(0xff737373), fontSize: 15,),
            ),
          ),
          SizedBox(height: 12),
          _buildVideoCard(image,video),
          SizedBox(height: 12),
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
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Our Founder',
              style: TextStyle(color: Color(0xffD9D9D9), fontSize: 45),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Abhinav Goyal',
              style: TextStyle(color: Color(0xff6D6D6D), fontSize: 32),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              '( Alumni of IIT Hyderabad )',
              style: TextStyle(color: Color(0xff6D6D6D), fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '
              'Lorem Ipsum has been the industry standard dummy text ever since the 1500s.',
              style: TextStyle(color: Color(0xff6D6D6D), fontSize: 16),
            ),
          ),
          
          // Social Media Icons and Image Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Social Icons
              Column(
                children: [
                  _buildSocialIcon(PhosphorIcons.linkedinLogo()),
                  SizedBox(height: 20),
                  _buildSocialIcon(PhosphorIcons.instagramLogo()),
                ],
              ),
              
              // Founder Image
              Center(
                child: Image.asset(
                  ImageConstant.Image,
                  width: 200,   // Adjusted width to prevent overflow
                  height: 180,  // Adjusted height
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          
          Divider(color: Colors.grey, thickness: 1),  // Divider instead of empty container
          
          // Contact and Social Media Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact', style: TextStyle(color: Color(0xff6D6D6D), fontSize: 22)),
                      SizedBox(height: 12),
                      _buildContactRow(PhosphorIcons.phoneCall(), '+91-8005993442'),
                      SizedBox(height: 12),
                      _buildContactRow(PhosphorIcons.envelopeSimple(), 'support@celebrare.in'),
                    ],
                  ),
                ),
                
                // Connect With Us
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Connect With Us on', style: TextStyle(color: Color(0xff6D6D6D), fontSize: 18)),
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
              ],
            ),
          ),
        ],
      ),
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
      Icon(iconData, size: 32, color: Color(0xff6D6D6D)),
      SizedBox(width: 6),
      Flexible(
        child: Text(info, style: TextStyle(color: Color(0xff6D6D6D), fontSize: 16)),
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
          height: 466.81,
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xff6D6D6D), width: 2),
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
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),

            // Icon inside a circular container
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xff4E9459), width: 2),
              ),
              child: Icon(
                PhosphorIcons.arrowUpRight(),
                size: 24.0,
                color: Color(0xff4E9459),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPdfInvites(String image, String title) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color(0xff4E9459),
          ),
          child: Image.asset(
            image,
            width: 150,
            height: 150,
          ),
        ),
Container(
            child: Text(
              title,
              style: TextStyle(color: Color(0xff737373), fontSize: 15),
            ),
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.menu),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              ImageConstant.celebrareImage,
              width: 144,
              height: 39,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 134, 210, 145),
                              letterSpacing: 3),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Moments',
                          style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 134, 210, 145),
                              letterSpacing: 3),
                        ),
                      ),
                      Image.asset(
                        ImageConstant.mainBackground,
                        width: 405,
                        height: 244,
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
                      style: TextStyle(color: Color(0xffD9D9D9), fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0.01, // Adjusted horizontal spacing
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (context, index) {
                    return _buildPdfInvites(
                        'assets/Element_for_UI/image.png', 'Title $index');
                  },
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  child: _buildButton('Create Now', () {}),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Text(
                      'Video Invites',
                      style: TextStyle(color: Color(0xffD9D9D9), fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    height: 500, // Adjust height based on video card size
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
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Text(
                      'Reviews',
                      style: TextStyle(color: Color(0xffD9D9D9), fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    height: 500, // Adjust height based on video card size
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
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    child: Text(
                      'Customized\ninvites',
                      style: TextStyle(color: Color(0xffD9D9D9), fontSize: 45),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    height: 662, // Adjust height based on video card size
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
