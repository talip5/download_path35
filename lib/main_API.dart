import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(HomePage());
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  var dio = Dio();
  bool isLoading=true;
  var  selectedCurrency=false;

  Future filex() async {
    //final response = await dio.get('https://google.com');
    final response = await dio.get('https://api.frankfurter.app');  //{"docs":"https://www.frankfurter.app/docs"}
    //response = await dio.download('https://www.google.com/', './xx.html');
    //response = await dio.download("storage/emulated/0/Android/data/com.example.directory/files/", './counter.txt');
    //response = await dio.download("c:\\test\\", './myfile.txt');
    //print(response.toString());
    //print(response.data);
    print(response.toString());
  }

  @override
  void initState(){
    super.initState();
    BaseOptions options = BaseOptions();
    options.baseUrl = 'https://api.frankfurter.app/';
    dio = new Dio(options);
    getCurrencies();
  }

  List<String> currencies=[];
  Future<List> getCurrencies()async{
    setState(() {
      isLoading;
    });
    Response result=await dio.get("currencies");
    if(result.statusCode==200){
      (result.data as Map).forEach((key,value){
        currencies.add(key);
      });
    }
    setState((){
      bool isLoading = false;
    });
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
                    SizedBox(height: 50),
                    Text('Currencies : '),
                    isLoading
                        ? CircularProgressIndicator()
                        : DropdownButton<String>(
                        value: selectedCurrency,
                        onChanged: (value) {
                          setState(() {
                            selectedCurrency = value;
                          });
                        },
                        items: currencies
                            .map((value) => DropdownMenuItem<String>(
                            value: value, child: Text(value)))
                            .toList())
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
