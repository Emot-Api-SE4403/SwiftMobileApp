import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    SoalABC soal = widget.tugasPembelajaran.daftarSoal[widget.no] as SoalABC;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kembali"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Logika untuk mengirim jawaban ke server atau melakukan pengecekan jawaban
                  // Anda dapat menambahkan logika Anda sendiri di sini
                },
                child: Text('Submit'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.navigate_before),
                    tooltip: 'Go to the previous page',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MengerjakanSoal(
                            tugasPembelajaran: widget.tugasPembelajaran,
                            noSoal: widget.no - 1,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    tooltip: 'Go to the next page',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MengerjakanSoal(
                            tugasPembelajaran: widget.tugasPembelajaran,
                            noSoal: widget.no + 1,
                          ),
                        ),
                      );
                    },
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
