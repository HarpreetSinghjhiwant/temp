import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';
import 'package:temp/widgets/video_comp.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> videoUrls = [
    "https://www.example.com/video1.mp4",
    "https://www.example.com/video2.mp4",
    "https://www.example.com/video3.mp4",
  ];

  Widget _buildVideoReviewsCard(String videoUrl) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: 247,
        height: 398,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xff605F5F),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: VideoPlayerComponent(videoUrl: ''),
      ),
    );
  }
  
  Widget _buildVideoCard(String videoUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 277.95,
        height: 466.81,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff4E9459), width: 2),
          borderRadius: BorderRadius.circular(20)
        ),
        child: VideoPlayerComponent(videoUrl: ''),
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
            SizedBox(width: 12,),
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
            width: 167,
            height: 167,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Container(
            child: Text(
              title,
              style: TextStyle(color: Color(0xff737373), fontSize: 15),
            ),
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
                      )
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
                    crossAxisSpacing: 2.0, // Adjusted horizontal spacing
                    mainAxisSpacing: 22.0,
                  ),
                  itemBuilder: (context, index) {
                    return _buildPdfInvites(
                        ImageConstant.celebrareImage, 'Title $index');
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
                SizedBox(height: 40,),
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
                        return _buildVideoCard(videoUrls[index]);
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
                SizedBox(height: 40,),
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
                        return _buildVideoReviewsCard(videoUrls[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
