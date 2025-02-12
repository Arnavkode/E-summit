import 'package:flutter/material.dart';
import 'package:e_summit25/utils/Datas.dart';

class HorizontalListNormal extends StatelessWidget {
  final List<Map<String, String>> items;

  const HorizontalListNormal({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenWidth(context);
    double cardWidth = screenWidth * 0.5; // Responsive card width

    return SizedBox(
      height: screenWidth * 0.55, // Adjust height dynamically
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: cardWidth, // Responsive card width
            margin: EdgeInsets.only(
              left: index == 0 ? screenWidth * 0.08 : screenWidth * 0.02, // First item extra margin
              right: screenWidth * 0.02,
            ),
            padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
            decoration: BoxDecoration(
                gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                const Color(0xffd3c0c0).withOpacity(0.15),
                                const Color(0xff222823).withOpacity(0.15)
                              ],
                            ),
                          
                // Background color for visibility
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text left
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  child: SizedBox(
                    width: double.infinity, // Full width
                    height: screenWidth * 0.38, // Responsive height
                    child: Image.asset(
                      items[index]["image"]!,
                      fit: BoxFit.cover, // Fill container
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),

                // Title
                Text(
                  items[index]["title"]!,
                  style: TextStyle(
                    fontSize: screenWidth * 0.047,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
