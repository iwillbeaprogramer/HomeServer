import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartoonViewer extends StatefulWidget {
  const CartoonViewer({super.key});

  @override
  State<CartoonViewer> createState() => _CartoonViewerState();
}

class _CartoonViewerState extends State<CartoonViewer> {
  //Property
  GetStorage getStorage = GetStorage();
  late List<dynamic> imagesList;
  late int currentPage = 0;

  @override
  void initState() {
    super.initState();
    imagesList = Get.arguments ?? [""];
    currentPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text("Viwer"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: ()=>preButton(), child: const Text("<<")),
            SizedBox(
              width: getWidth(),
              height: getHeight(),
              child: Image.network(
                "http://127.0.0.1:8000/cartoon/${imagesList[currentPage][0]}/contents/${imagesList[currentPage][1]}",
                fit: BoxFit.fill,
              ),
            ),
            ElevatedButton(onPressed: ()=>nextButton(), child: const Text(">>"))
          ],
        ),
      ),
    );
  }

  double getWidth(){
    return MediaQuery.of(context).size.width-300;
  }
  double getHeight(){
    return MediaQuery.of(context).size.height-100;
  }

  preButton(){
    currentPage++;
    setState(() {currentPage;});
  }
  nextButton(){
    currentPage++;
    setState(() {currentPage;});
  }
}