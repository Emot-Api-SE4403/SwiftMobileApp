import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '/components/DataSoal.dart';
import '/components/MengerjakanSoalABC.dart';



class MengerjakanSoal extends StatefulWidget {
  MengerjakanSoal({super.key, required this.tugasPembelajaran, required this.noSoal});

  final TugasPembelajaran tugasPembelajaran;
  int noSoal;

  @override
  State<MengerjakanSoal> createState() => _MengerjakanSoalState();
}

class _MengerjakanSoalState extends State<MengerjakanSoal> {
  @override
  Widget build(BuildContext context) {
    if(widget.tugasPembelajaran.daftarSoal[widget.noSoal] is  SoalABC){
      return MengerjakanTugasABC(tugasPembelajaran: widget.tugasPembelajaran, no: widget.noSoal);
    } else if (widget.tugasPembelajaran.daftarSoal[widget.noSoal] is SoalMultiPilih) {
      return Container(
        child: Text("Soal multi pilih"),
      );
    } else if (widget.tugasPembelajaran.daftarSoal[widget.noSoal] is  SoalBenarSalah) {
      return Container(
        child: Text("Soal benar salah"),
      );
    } else {
      return Placeholder();
    }
  }
}