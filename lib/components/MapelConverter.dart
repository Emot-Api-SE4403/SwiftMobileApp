class MapelConverter {
  static String fromInt(int input) {
    switch (input) {
      case 1:
        return 'kuantitatif';
      case 2:
        return 'penalaran_matematika';
      case 3:
        return 'literasi_inggris';
      case 4:
        return 'literasi_indonesia';
      case 5:
        return 'penalaran_umum';
      case 6:
        return 'membaca_dan_menulis';
      default:
        throw Exception('Invalid input');
    }
  }

  static int fromStr(String name) {
    switch (name) {
      case 'kuantitatif':
        return 1;
      case 'penalaran_matematika':
        return 2;
      case 'literasi_inggris':
        return 3;
      case 'literasi_indonesia':
        return 4;
      case 'penalaran_umum':
        return 5;
      case 'membaca_dan_menulis':
        return 6;
      default:
        throw Exception('Invalid input');
    }
  }
}
