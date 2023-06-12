import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import '/components/AppBar.dart';
import '/setting.dart';

void main() {
  runApp(const MyAppProfile());
}

class MyAppProfile extends StatelessWidget {
  const MyAppProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfilePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});

  final String title;
  final double _appBarHeight = 100.0;

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String profilePictureUrl = "https://i.gifer.com/ZKZx.gif";
  String fullName = "Loading...";
  String jurusan = "Loading...";
  String asalSekolah = "Loading...";
  String email = "Loading...";
  String since = "Loading...";

  @override
  void initState(){
    super.initState();
    _retrieveData();
  }

  Future<void> _retrieveData() async {
    final storage = const FlutterSecureStorage();
    profilePictureUrl = await storage.read(key: 'profile_picture') ?? 'https://iili.io/HrZtFQs.th.png';
    fullName = await storage.read(key: 'nama_lengkap') ?? "Error has occured";
    jurusan = await storage.read(key: 'jurusan') ?? "Error has occured";
    asalSekolah = await storage.read(key: 'asal_sekolah') ?? "Error has occured";
    email = await storage.read(key: 'email') ?? "Error has occured";
    since = await storage.read(key: 'time_created') ?? "Error has occured";
    var time = since.split('T');
    since = time[0];
    setState(() {}); // Update the widget's state to trigger a rebuild
  }  

  Future handleInputFoto(bool isSourceCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    if (isSourceCamera) {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }
    
    if (image == null) {
      Navigator.of(context).pop();
      return;
    } 
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: const Text("Anda yakin memilih foto ini?"),
          content: Text(image?.name ?? "nama file yang dipilih"),
          actions: [
            TextButton(
              onPressed: () {}, 
              child: const Text("Yakin")
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal")
            )
          ],
        );
      }
    );

    
  }

  void pilihSumberFoto() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil Foto dari Kamera'),
              onTap: () => handleInputFoto(true),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Ambil Foto dari Galeri'),
              onTap: () => handleInputFoto(false),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0, -0.45),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color.fromARGB(255, 82, 82, 82),
                borderRadius: BorderRadius.circular(30.0),
              ),
              width: 350,
              height: 300,
              child: Stack(
                children: [
                  Positioned(
                    top: 16,
                    right: 16,
                    child: IconButton(
                      iconSize: 32,
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return const SettingPage(title: '',);
                          },
                        ));
                      },
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: IconButton(
                      iconSize: 32,
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.grey[50],
                      ),
                      onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/")),
                    )
                  ),
                  Positioned(
                    top: 100,
                    left: 0,
                    child: SizedBox(
                      width: 350,
                      child: Text(
                      '$fullName',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    )
                  ),
                  Positioned(
                    top: 140,
                    left: 20,
                    child: SizedBox(
                      width: 330,
                      child: Text(
                      'JURUSAN                    : $jurusan',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    )
                  ),
                  Positioned(
                    top: 170,
                    left: 20,
                    child: SizedBox(
                      width: 330,
                      child: Text(
                        'ASAL SEKOLAH         : $asalSekolah',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 20,
                    child: SizedBox(
                      width: 330,
                      child: Text(
                        'EMAIL                          : $email',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 230,
                    left: 20,
                    child: SizedBox(
                      width: 330,
                      child: Text(
                        'BERGABUNG SEJAK  : $since',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.85),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 80, 162, 164),
              ),
              width: 150,
              height: 150,
            ),
          ),
          Align(
            alignment: const Alignment(0, -0.813),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage( profilePictureUrl // Get value from secure storage with key = "profile_picture",
                  )
                )
              ),
              width: 120,
              height: 120,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("FOTO PROFIL"),
                        content: const Text("Ganti foto profil?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              pilihSumberFoto();
                            },
                            child: const Text("YA"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("BATAL"),
                          ),
                        ],
                      );
                    },
                  );
                },
                
              ),
            ),
          ),
          /**
          Align(
            alignment: const Alignment(0, 0.6),
            child: Container(
              width: 350,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromARGB(255, 80, 162, 164),
              ),
              child: Row(
                children: [
                  const Text('Riwayat Pembelian'),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      // aksi yang ingin dilakukan ketika tombol diklik
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(16),
                      child: const Icon(Icons.shopping_cart),
                    ),
                  ),
                ],
              ),
            ),
          ),
           */
        ],
      ),
    );
  }
}


