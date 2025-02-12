import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart'; // For date parsing
import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';

class HorizontalImageList extends StatelessWidget {
  final List<Map<String, String>> items;

  const HorizontalImageList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenWidth(context);
    double cardWidth = screenWidth * 0.71; // Responsive card width

    // Get today's date
    DateTime today = DateTime.now();
    DateFormat dateFormat = DateFormat("dd MMM yyyy"); // Ensure correct year handling

    // Convert "13 Feb" -> "13 Feb 2025" (assume current year)
    List<Map<String, String>> sortedItems = List.from(items)
      ..sort((a, b) {
        DateTime dateA = dateFormat.parse("${a["date"]} ${today.year}");
        DateTime dateB = dateFormat.parse("${b["date"]} ${today.year}");
        return dateA.compareTo(dateB); // Sort by ascending date
      });

    // Remove past events (optional)
    sortedItems = sortedItems.where((item) {
      DateTime eventDate = dateFormat.parse("${item["date"]} ${today.year}");
      return !eventDate.isBefore(today); // Keep only upcoming events
    }).toList();

    return SizedBox(
      
      height: screenWidth * 0.61, // Adjust height dynamically
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: sortedItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (sortedItems[index]["route"] != null) {
                Fluttertoast.showToast(msg: sortedItems[index]["route"]!);
                Navigator.pushNamed(context, sortedItems[index]["route"]!);
              }
              else{
                Fluttertoast.showToast(msg: "Route is not defined");
              }
            },
            child: Container(
              
              width: cardWidth, // Adjust width dynamically
              margin: EdgeInsets.only(
                left: index == 0 ? screenWidth * 0.08 : screenWidth * 0.02, // Responsive spacing
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
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    child: SizedBox(
                      width: double.infinity, // Makes sure the image takes full width
                      height: screenWidth * 0.38, // Responsive height
                      child: Image.asset(
                        sortedItems[index]["image"]!,
                        fit: BoxFit.cover, // Ensures the image fills the box
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),

                  // Title and Date in Column (Left-Aligned)
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            sortedItems[index]["title"]!,
                            style: TextStyle(
                              fontSize: screenWidth * 0.047,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            sortedItems[index]["date"]!,
                            style: TextStyle(
                              fontSize: screenWidth * 0.047,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Time Container (Always Aligned Bottom Right)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenWidth * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        ),
                        child: Text(
                          sortedItems[index]["time"]!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
