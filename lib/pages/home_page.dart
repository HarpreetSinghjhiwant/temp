import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget _buildMenu(){
    return Container(
      child: Column(
        children: [
          Container(
            
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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

            ],
          ),
        ),
      ),
    );
  }
}
