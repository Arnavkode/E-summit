import 'package:e_summit25/utils/Datas.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
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
            // height: ScreenHeight(context) * 0.28, // 50% of the screen height
            child: Opacity(
              opacity: 0.8,
              child: Center(
                child: Container(
                  width: ScreenWidth(context), // Ensure the container is square
                  height: ScreenHeight(context) * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      
                      width: 4.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Half of the container size
                    child: Image.asset(
                      'lib/assets/images/unwind.png', // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About",
                              style: TextStyle(
                                  fontSize: 0.11 * ScreenWidth(context),
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            ),
                          
                        Text(
                          "Us",
                          style: TextStyle(
                              fontSize: 0.15 * ScreenWidth(context),
                              fontFamily: "Inter",
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF275DAD),
                              decoration: TextDecoration.none),
                        ),
                        ],
                        ),
                        Spacer(),
                        SizedBox(height: 80,child: Image.asset("lib/assets/images/TVC logo white.png", fit: BoxFit.contain,),)
                      ],
                    ),
                    SizedBox(height: 0.01 * ScreenHeight(context)),
                     Text(
                      "The Entrepreneurship Development cell, Thapar Institute of Engineering and Technology, Patiala has been established with an aim to foster and nurture talented young minds with a vision. With India witnessing the rise of start up culture, we encourage and guide everyone who is bitten by the spirit of entrepreneurship.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Inter-r',
                        decoration: TextDecoration.none,
                      ),
                      softWrap: true,
                    ),

                    SizedBox(height: 0.01 * ScreenHeight(context)),

                    Text(
                      "EDC aims at developing the spirit of entrepreneurship among the students of Thapar Institute of Engineering and Technology. It is committed to build a strong platform for budding entrepreneurs as a career, as a path to success, as a journey of wisdom.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontFamily: 'Inter-r',
                        decoration: TextDecoration.none,
                      ),
                      softWrap: true,
                    ),
                    
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

  TextStyle basic() {
    return TextStyle(
      fontFamily: "Inter",
      fontSize: 22,
      color: Colors.white,
      decoration: TextDecoration.none,
    );
  }
}