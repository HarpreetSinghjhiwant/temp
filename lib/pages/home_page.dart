import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:temp/core/app_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget _buildButton(){
    return Container(
      child: ElevatedButton(
        onPressed: (){},
        child: Row(
          children: [
            Text('Button'),
            PhosphorIcon(
              PhosphorIcon.arrowRight,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPdfInvites(String image, String title){
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
        SizedBox(height: 10,),
        Container(
        child: Container(
            child: Text(title,
            style: TextStyle(
              color: Color(0xff737373),
              fontSize: 15
            ),),
          ),
      ),
      ],
    );
  }

  Widget _buildMenu(){
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
                              style: TextStyle(fontSize: 16),  // Emoji stays colorful
                            ),
                            TextSpan(
                              text: 'Winter Sale get 60% OFF! Upto 120 Rs ',
                              style: TextStyle(color: Colors.white, fontSize: 16), // White text
                            ),
                            TextSpan(
                              text: '🎉',
                              style: TextStyle(fontSize: 16),  // Emoji stays colorful
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildMenu(),
                SizedBox(height: 50,),
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
                            letterSpacing: 3
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Moments',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 134, 210, 145),
                            letterSpacing: 3
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      'PDF Invites',
                      style: TextStyle(
                        color: Color(0xffD9D9D9),
                        fontSize: 45
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0, // Adjusted horizontal spacing
                  mainAxisSpacing: 22.0,
                  ),
                  itemBuilder: (context, index) {
                  return _buildPdfInvites(ImageConstant.celebrareImage, 'Title $index');
                  },
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
