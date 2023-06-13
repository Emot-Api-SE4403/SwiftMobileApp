import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/components/Loading.dart';
import '/main.dart';
import '/profil.dart';
import '/components/AppBar.dart';
import 'package:http/http.dart' as http;



 FlutterSecureStorage storage = FlutterSecureStorage();
void main() {
  runApp(const MyAppChangeProfile());
}

class MyAppChangeProfile extends StatelessWidget {
  const MyAppChangeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChangeProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({super.key, required this.title});

  final String title;
  final double _appBarHeight = 100.0;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  _ChangeProfilePageState createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController asalSekolahController= TextEditingController();
  TextEditingController jurusanController = TextEditingController(text: "IPS");

  @override
  void initState() {
    loading();
    super.initState();
  }
  
  Future sendData() async {
    try {
      LoadingDialog.show(context);
      var nama = namaController.text;
      var email = emailController.text;
      var asalSekolah = asalSekolahController.text;
      var jurusan = jurusanController.text;
      
      if (nama.length == 0 || email.length == 0 || asalSekolah.length == 0 ) {
        throw Exception("Invalid input");
      }      
      
      var profile = {};
      if (nama != await storage.read(key: "nama_lengkap")) {
        profile["nama"] = nama;
      }
      if (email!= await storage.read(key: "email")) {
        profile["email"] = email;
      }
      if (asalSekolah != await storage.read(key:"asal_sekolah")) {
        profile["asalSekolah"] = asalSekolah;
      }
      if (jurusan!= await storage.read(key:"jurusan")) {
        profile["jurusan"] = jurusan;
      }
      
      var response = await http.post(
        Uri.parse("${dotenv.get("API_URL")}/pelajar/updatedata"),
        headers: {
          'Authorization':"Bearer ${await storage.read(key: "jwt")}",
        },
        body: profile
      );
      LoadingDialog.hide(context);

      if (response.statusCode != 200) {
        throw Exception(response.body);
      } else {
        showDialog(
          context: context,
          builder: buildPemberitahuanAlert
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.toString())
        )
      );
    }
  }


  Future<void> loading() async {
    namaController.text = await storage.read(key: "nama_lengkap") ?? "Loading";
    emailController.text = await storage.read(key: "email") ?? "Loading";
    asalSekolahController.text = await storage.read(key: "asal_sekolah") ?? "Loading";
    jurusanController.text = await storage.read(key: "jurusan") ?? "Loading";
    setState(() {
      
    });
  }

  Widget buildPemberitahuanAlert(context) {
    return AlertDialog(
      title: const Text('Pemberitahuan'),
      content: const Text(
          'Data ini telah berhasil disimpan.'),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MyApp()),
            );
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage(title:'')),
            );
          },
        ),
      ],
    );
  }

  Widget buildKonfirmasiAlert(context) {
    return AlertDialog(
      title: const Text('Konfirmasi'),
      content: const Text(
          'Apakah anda yakin akan mengubah data pada profil ini?'),
      actions: [
        TextButton(
          child: const Text('YA'),
          onPressed: () {
            Navigator.of(context).pop();
            sendData();
          },
        ),
        TextButton(
          child: const Text('TIDAK'),
          onPressed: () {
            // kode untuk menyimpan data pada profil
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all( 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                const Text('UBAH PROFIL'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: buildKonfirmasiAlert
                    );
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
          
          Expanded( 
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(28.0),
                margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: namaController,
                      decoration: const InputDecoration(
                        labelText: 'NAMA*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'EMAIL*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: asalSekolahController,
                      decoration: const InputDecoration(
                        labelText: 'SEKOLAH*',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: jurusanController.text,
                      onChanged: (value) {
                        setState(() {
                          jurusanController.text = value ?? "";
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(value: "IPA", child: Text("IPA")),
                        DropdownMenuItem<String>(value: "IPS", child: Text("IPS")),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'JURUSAN*',
                        border: OutlineInputBorder(),
                        
                        ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your major';
                        }
                        return null;
                      },
                    ),
                  ]
                ),
              ),
            ),
          ),
          
        ], // Column children
      ),
    );
  }
}
