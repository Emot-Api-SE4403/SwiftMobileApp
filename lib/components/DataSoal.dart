

class TugasPembelajaran {
  String judul;
  int jumlahAttempt;
  List<SoalABC> daftarSoal;

  TugasPembelajaran({
    required this.judul,
    required this.jumlahAttempt,
    required this.daftarSoal,
  });

  factory TugasPembelajaran.fromJson(Map<String, dynamic> json) {
    List<SoalABC> daftarSoal = [];
    if (json['daftar_soal'] != null) {
      daftarSoal = List<SoalABC>.from(json['daftar_soal'].map((x) => SoalABC.fromJson(x)));
    }

    return TugasPembelajaran(
      judul: json['judul'],
      jumlahAttempt: json['jumlah_attempt'],
      daftarSoal: daftarSoal,
    );
  }
}

class SoalMultiPilih {
  String pertanyaan;
  List<JawabanMultiPilih> pilihan;

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

class SoalBenarSalah {
  String pertanyaan;
  String pernyataanPadaBenar;
  String pernyataanPadaSalah;
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

class SoalABC {
  String pertanyaan;
  List<String> pilihanJawaban;

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
