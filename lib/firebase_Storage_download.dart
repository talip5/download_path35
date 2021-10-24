//https://www.w3.org/TR/PNG/iso_8859-1.txt
//https://www.w3.org/People/mimasa/test/imgformat/img/w3c_home.jpg
//https://firebasestorage.googleapis.com/v0/b/cloud2-f6bda.appspot.com/o/user%2Fali%2Fprofil.png?alt=media&token=01ea9038-8139-4640-a4e9-97ff0d5d621c
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HomePage());
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var dio = Dio();
  String savePath;
  String dirPath;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  Future<void> storage() async{
    //  .getDownloadUrl().addOnSuccessListener(new OnSuccessListener<Uri>()
    var ref5 =firebase_storage.FirebaseStorage.instance.ref().child('user').child('ali').child('profil.png');
    ref5.getDownloadURL().then((value) => print(value));
  }



  deneme() async {
    //Response response = await dio.get('https://www.w3.org/TR/PNG/iso_8859-1.txt');
    //Response response = await dio.get('https://www.w3.org/People/mimasa/test/imgformat/img/w3c_home.jpg');
    Response response = await dio.get('https://www.w3.org/People/mimasa/test/imgformat/img/w3c_home.jpg');
    Directory directory= await getExternalStorageDirectory();
    dirPath=directory.path;
    savePath='$dirPath/jpgDeneme.jpg';
    print(directory);
    print(dirPath);
    print(savePath);
    print(response.data);
  }

  Future writeDownload() async {
    Response response = await dio.get('https://www.w3.org/TR/PNG/iso_8859-1.txt',
      //onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    Directory directory= await getExternalStorageDirectory();
    dirPath=directory.path;
    savePath='$dirPath/jpgDeneme.jpg';
    File file=File(savePath);
    var raf=file.openSync(mode: FileMode.write);
    //response.data is List<int>
    raf.writeFromSync(response.data);
    await raf.close();
    print('kayit yapildi');
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'download',
      home: SafeArea(
        child:Scaffold(
            appBar:AppBar(title:Text('Currency API35'))
            ,
            body:Container(
              alignment: Alignment.topCenter,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network('https://firebasestorage.googleapis.com/v0/b/cloud2-f6bda.appspot.com/o/user%2Fali%2Fprofil.png?alt=media&token=01ea9038-8139-4640-a4e9-97ff0d5d621c'),
                    ElevatedButton(
                        onPressed:() async{
                          await storage();
                          print('deneme');
                        },
                        child:Text('deneme')
                    ),
                    ElevatedButton(
                        onPressed:(){
                          writeDownload();
                          print('writeDownload');
                        },
                        child:Text('writeDownload')
                    ),
                    ElevatedButton(
                        onPressed:(){
                          //filex();
                          print('filex');
                        },
                        child:Text('filex')
                    ),
                    Text('deneme'),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
