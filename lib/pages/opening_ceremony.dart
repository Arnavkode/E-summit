import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';

class OpeningCeremony extends StatefulWidget {
  const OpeningCeremony({super.key});

  @override
  State<OpeningCeremony> createState() => _OpeningCeremonyState();
}

class _OpeningCeremonyState extends State<OpeningCeremony> {
  @override
  Widget build(BuildContext context) {
    var _isLoading = false;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Container(
            width: ScreenWidth(context),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(39, 93, 173, 1),
                  Color.fromRGBO(18, 18, 18, 1)
                ],
                begin: Alignment.topCenter,
                end: Alignment(0, -0.5),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: ScreenHeight(context) * 0.28, // 50% of the screen height
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'lib/assets/images/unwind.png', // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0.05 * ScreenHeight(context),
            left: 0.1 * ScreenWidth(context),
            child: Container(
              width: 0.8 * ScreenWidth(context),
              height: 0.75 * ScreenHeight(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Colors.white.withOpacity(0.2), width: 1.0),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xffd3c0c0).withOpacity(0.15),
                    Color(0xff222823).withOpacity(0.15)
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(0.05 * ScreenWidth(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                        Text(
                          "Opening",
                          style: TextStyle(
                              fontSize: 0.15 * ScreenWidth(context),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                        ),
                        Text(
                          "Ceremony",
                          style: TextStyle(
                              fontSize: 0.13 * ScreenWidth(context),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF275DAD),
                              decoration: TextDecoration.none),
                        ),
                      
                    SizedBox(height: 0.01 * ScreenHeight(context)),
                    Text(
                      "Venue : LT-101",
                      style: basic(),
                    ),
                    SizedBox(height: 0.005 * ScreenHeight(context)),
                    Text(
                      "Time : 11 A.M.",
                      style: basic(),
                    ),
                    SizedBox(height: 0.005 * ScreenHeight(context)),
                    
                    GestureDetector(
                        onTap: () {},
                        child: Text("Watch Livestream",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontFamily: 'Inter',
                                decoration: TextDecoration.none))),
                    SizedBox(height: 0.08 * ScreenHeight(context)),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading == true)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}