import 'dart:io';

import 'package:flutter/material.dart';
import '/components/DataSoal.dart';
import '/components/MengerjakanSoalABC.dart';




class MengerjakanSoal extends StatefulWidget {
  MengerjakanSoal({super.key, required this.tugasPembelajaran, required this.noSoal});

  final TugasPembelajaran tugasPembelajaran;
  static List? jawaban;
  static DateTime? mulai;
  static DateTime? selesai;
  int noSoal;

  static void init(TugasPembelajaran tugas) {
    jawaban = List.generate(tugas.daftarSoal.length, (index) {
      if(tugas.daftarSoal[index] is SoalABC) {
        return -1;
      } else {
        return {};
      }
    });
    mulai = DateTime.now();
  }

  static void done(TugasPembelajaran tugas) async {
    selesai = DateTime.now();
  }

  @override
  State<MengerjakanSoal> createState() => _MengerjakanSoalState();
}

class _MengerjakanSoalState extends State<MengerjakanSoal> {
  @override
  Widget build(BuildContext context) {
    if(widget.tugasPembelajaran.daftarSoal[widget.noSoal] is  SoalABC){
      return MengerjakanTugasABC(tugasPembelajaran: widget.tugasPembelajaran, no: widget.noSoal);
    } else if (widget.tugasPembelajaran.daftarSoal[widget.noSoal] is SoalMultiPilih) {
      return const Placeholder(child: Center(child: Text("UNSUPPORTED YET")));
    } else if (widget.tugasPembelajaran.daftarSoal[widget.noSoal] is  SoalBenarSalah) {
      return const Placeholder(child: Center(child: Text("UNSUPPORTED YET")));
    } else {
      return Placeholder();
    }
  }
}