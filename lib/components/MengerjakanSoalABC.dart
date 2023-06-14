import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:swift_elearning/components/Loading.dart';
import '../MengerjakanSoal.dart';
import 'DataSoal.dart';

class MengerjakanTugasABC extends StatefulWidget {
  const MengerjakanTugasABC({
    Key? key,
    required this.tugasPembelajaran,
    required this.no,
  }) : super(key: key);

  final TugasPembelajaran tugasPembelajaran;
  final int no;

  @override
  State<MengerjakanTugasABC> createState() => _MengerjakanTugasABCState();
}

class _MengerjakanTugasABCState extends State<MengerjakanTugasABC> {
  int selectedAnswer = -1; // Menyimpan jawaban yang dipilih

  Future apiCallKumpulkan() async {
    try {
      LoadingDialog.show(context);          
      MengerjakanSoal.done(widget.tugasPembelajaran);
      LoadingDialog.hide(context);
      FlutterSecureStorage storage = FlutterSecureStorage();
      var response = await http.post(
        Uri.parse("${dotenv.get("API_URL")}/video/tugas/kumpul"),
        body: json.encode({
          "id_tugas":widget.tugasPembelajaran.id,
          "waktu_mulai": MengerjakanSoal.mulai?.toIso8601String(),
          "waktu_selesai": MengerjakanSoal.selesai?.toIso8601String(),
          "jawaban":MengerjakanSoal.jawaban
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${await storage.read(key: "jwt")}"
        }
      );

      
      if(response.statusCode != 200) {
        throw HttpException(response.body);
      } else {
        Navigator.popUntil(context, ModalRoute.withName("/"));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SoalABC soal = widget.tugasPembelajaran.daftarSoal[widget.no] as SoalABC;
    return Scaffold(
      
      body: Center(
        child: Container(
          color: Colors.blueGrey[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.no + 1}. ${soal.pertanyaan}',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 16),
              Column(
                children: List.generate(
                  soal.pilihanJawaban.length,
                  (index) => RadioListTile<int>(
                    value: index,
                    groupValue: selectedAnswer,
                    onChanged: (value) {
                      setState(() {
                        selectedAnswer = value as int;
                      });
                    },
                    title: Text(
                      '${String.fromCharCode(65 + index)}. ${soal.pilihanJawaban[index]}',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Logika untuk mengirim jawaban ke server atau melakukan pengecekan jawaban
                  // Anda dapat menambahkan logika Anda sendiri di sini
                  if(selectedAnswer >= 0 && selectedAnswer < soal.pilihanJawaban[widget.no].length) {
                    MengerjakanSoal.jawaban?[widget.no] = selectedAnswer;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Jawaban tersimpan"))
                    );
                  }
                  if (widget.no == widget.tugasPembelajaran.daftarSoal.length - 1) {
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        title: const Text("Anda yakin dengan jawaban anda?"),
                        content: const Text("Jawaban yang sudah dikumpulkan tidak dapat diubah lagi"),
                        actions: [
                          TextButton(
                            onPressed: () => apiCallKumpulkan(), 
                            child: const Text("Yakin")
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context), 
                            child: const Text("Batal")
                          ),
                        ],
                      );
                    });
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.navigate_before),
                    tooltip: 'Go to the previous page',
                    onPressed: (widget.no > 0) ? () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MengerjakanSoal(
                            tugasPembelajaran: widget.tugasPembelajaran,
                            noSoal: widget.no - 1,
                          ),
                        ),
                      );
                    }: null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    tooltip: 'Go to the next page',
                    onPressed: (widget.no < widget.tugasPembelajaran.daftarSoal.length - 1) ? 
                    () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MengerjakanSoal(
                            tugasPembelajaran: widget.tugasPembelajaran,
                            noSoal: widget.no + 1,
                          ),
                        ),
                      );
                    } : null
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
