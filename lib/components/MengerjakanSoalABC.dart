import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:swift_elearning/MengerjakanSoal.dart';
import 'package:swift_elearning/components/DataSoal.dart';

class MengerjakanTugasABC extends StatefulWidget {
  const MengerjakanTugasABC({super.key, required this.tugasPembelajaran, required this.no});

  final TugasPembelajaran tugasPembelajaran;
  final int no;

  @override
  State<MengerjakanTugasABC> createState() => _MengerjakanTugasABCState();
}

class _MengerjakanTugasABCState extends State<MengerjakanTugasABC> {
  
  @override
  Widget build(BuildContext context) {
    SoalABC soal = widget.tugasPembelajaran.daftarSoal[widget.no] as SoalABC;
    return Center(
      child: Container(
        color: Colors.blueGrey[50],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              soal.pertanyaan,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              soal.pilihanJawaban[0],
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(soal.pilihanJawaban[1]),
            Text(soal.pilihanJawaban[2]),
            Text(soal.pilihanJawaban[3]),
            TextButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MengerjakanSoal(
                    tugasPembelajaran: widget.tugasPembelajaran, 
                    noSoal: widget.no + 1
                  )
                )
              );
            }, child: Text(
              "Next",
              
            )),
            TextButton(onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MengerjakanSoal(
                    tugasPembelajaran: widget.tugasPembelajaran, 
                    noSoal: widget.no - 1
                  )
                )
              );
            }, child: Text(
              "Before",
              
            ))

          ],
        ),
      ),
    );
  }
}