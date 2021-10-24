//https://www.w3.org/TR/PNG/iso_8859-1.txt
//https://www.w3.org/People/mimasa/test/imgformat/img/w3c_home.jpg

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(HomePage());
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var dio = Dio();
  bool isLoading=false;
  var  selectedCurrency;
  String savePath;
  String dirPath;
  List list=[25];

  Future deneme() async {
    //Response response = await dio.get('https://www.w3.org/TR/PNG/iso_8859-1.txt');
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
    //Response response = await dio.get('https://www.w3.org/TR/PNG/iso_8859-1.txt',
    Response response = await dio.get('https://www.w3.org/People/mimasa/test/imgformat/img/w3c_home.jpg',
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
            appBar:AppBar(title:Text('Currency API'))
            ,
            body:Container(
              alignment: Alignment.topCenter,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed:(){
                          deneme();
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
