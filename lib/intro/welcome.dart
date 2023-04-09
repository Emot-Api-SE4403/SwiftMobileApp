import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login.dart';
import '../register.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset('assets\\image\\SWIFT welcome.png'),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Ayo gunakan sekarang juga!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 24
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Jangan biarkan kesempatan ini terlewat. "
                      "Segera masuk atau daftar untuk dapat mengakses " 
                      "berbagai video pembelajaran sekarang juga",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterPage()),
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade200,
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(4, 4)
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: Offset(-4, -4)
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Daftar', 
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      ),

                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade200,
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: const Offset(4, 4)
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                    offset: Offset(-4, -4)
                                  )
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Masuk', 
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24
                                  ),
                                )
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 80), 
        ],
      ),
    );
  }
}
