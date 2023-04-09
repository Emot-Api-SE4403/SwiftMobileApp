import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro1 extends StatelessWidget {
  const Intro1({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      color: Colors.lightBlue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 370,
                    height: 370,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255,159,248,255),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 130,211,255),
                    ),
                  ),
                ),
                Center(child: Image.asset('assets\\image\\intro (1).png')),
              ],
            ),
            const SizedBox(height: 50), 
             Text(
              'Video yang bervariasi',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 24
              ),
            ),
             Text(
              'Kami menyediakan berbagai macam video pembelajaran yang bisa Anda pilih sesuai dengan kebutuhan belajar Anda',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14,
              ),
            ),
          ],
        ),
      )
    );
  }
}
