class TugasPembelajaran {
  int id;
  String judul;
  int jumlahAttempt;
  List<Soal> daftarSoal;
  DateTime timeCreated;

  TugasPembelajaran({
    required this.id,
    required this.judul,
    required this.jumlahAttempt,
    required this.daftarSoal,
    required this.timeCreated,
  });

  static TugasPembelajaran placeholder = TugasPembelajaran(
    judul: "Loading...",
    jumlahAttempt: 0,
    daftarSoal: List.empty(),
    timeCreated: DateTime.fromMillisecondsSinceEpoch(0),
    id: -1
  );

  factory TugasPembelajaran.fromJson(Map<String, dynamic> json) {
    List<Soal> daftarSoal = [];
    if (json['daftar_soal'] != null) {
      daftarSoal = List<Soal>.from(json['daftar_soal'].map((x) => _parseSoal(x)));
    }


    return TugasPembelajaran(
      id: json['id'],
      judul: json['judul'],
      jumlahAttempt: json['jumlah_attempt'],
      daftarSoal: daftarSoal,
      timeCreated: DateTime.parse(json['time_created']),
    );
  }

  static Soal _parseSoal(Map<String, dynamic> json) {
    if (json['pilihan'] != null) {
      return SoalMultiPilih.fromJson(json);
    } else if (json['pernyataan_pada_benar'] != null && json['pernyataan_pada_salah'] != null) {
      return SoalBenarSalah.fromJson(json);
    } else {
      return SoalABC.fromJson(json);
    }
  }
}

abstract class Soal {
  
}

class SoalMultiPilih extends Soal {
  List<JawabanMultiPilih> pilihan;
  String pertanyaan;

  SoalMultiPilih({
    required this.pertanyaan,
    required this.pilihan,
  });

  factory SoalMultiPilih.fromJson(Map<String, dynamic> json) {
    List<JawabanMultiPilih> pilihan = [];
    if (json['pilihan'] != null) {
      pilihan = List<JawabanMultiPilih>.from(json['pilihan'].map((x) => JawabanMultiPilih.fromJson(x)));
    }

    return SoalMultiPilih(
      pertanyaan: json['pertanyaan'],
      pilihan: pilihan,
    );
  }
}

class JawabanMultiPilih {
  String isiJawaban;

  JawabanMultiPilih({
    required this.isiJawaban,
  });

  factory JawabanMultiPilih.fromJson(Map<String, dynamic> json) {
    return JawabanMultiPilih(
      isiJawaban: json['isi_jawaban'],
    );
  }
}

class SoalBenarSalah extends Soal {
  String pernyataanPadaBenar;
  String pernyataanPadaSalah;
  String pertanyaan;
  List<JawabanBenarSalah> daftarJawaban;

  SoalBenarSalah({
    required this.pertanyaan,
    required this.pernyataanPadaBenar,
    required this.pernyataanPadaSalah,
    required this.daftarJawaban,
  });

  factory SoalBenarSalah.fromJson(Map<String, dynamic> json) {
    List<JawabanBenarSalah> daftarJawaban = [];
    if (json['daftar_jawaban'] != null) {
      daftarJawaban = List<JawabanBenarSalah>.from(json['daftar_jawaban'].map((x) => JawabanBenarSalah.fromJson(x)));
    }

    return SoalBenarSalah(
      pertanyaan: json['pertanyaan'],
      pernyataanPadaBenar: json['pernyataan_pada_benar'],
      pernyataanPadaSalah: json['pernyataan_pada_salah'],
      daftarJawaban: daftarJawaban,
    );
  }
}

class JawabanBenarSalah {
  String isiJawaban;

  JawabanBenarSalah({
    required this.isiJawaban,
  });

  factory JawabanBenarSalah.fromJson(Map<String, dynamic> json) {
    return JawabanBenarSalah(
      isiJawaban: json['isi_jawaban'],
    );
  }
}

class SoalABC extends Soal {
  List<String> pilihanJawaban;
  String pertanyaan;

  SoalABC({
    required this.pertanyaan,
    required this.pilihanJawaban,
  });

  factory SoalABC.fromJson(Map<String, dynamic> json) {
    List<String> pilihanJawaban = [];
    if (json['pilihan_jawaban'] != null) {
      pilihanJawaban = List<String>.from(json['pilihan_jawaban'].map((x) => x.toString()));
    }

    return SoalABC(
      pertanyaan: json['pertanyaan'],
      pilihanJawaban: pilihanJawaban,
    );
  }
}
