import 'package:flutter/material.dart';
import 'package:front/viewmodel/states.dart';
import 'package:get/get.dart';


class Cartoon extends StatefulWidget {
  const Cartoon({super.key});

  @override
  State<Cartoon> createState() => _CartoonState();
}

class _CartoonState extends State<Cartoon> {
  //Property
  CustomState customState = CustomState();
  List cartoonList = [];
  late double itemWidth;
  late double itemHeight;
  late double horizentalMargin;
  late double verticalMargin;

  getCartoonList() async {
    List cList = await customState.getCartoonList();
    cartoonList = cList;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCartoonList();
    itemWidth = 150;
    itemHeight = 300;
    horizentalMargin = 10;
    verticalMargin = 10;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartoon"),
        centerTitle: true,
      ),
      body:
      cartoonList.isEmpty
      ? const CircularProgressIndicator()
      :GridView.builder(
        itemCount: cartoonList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getRowItemCounts(),
            childAspectRatio: itemWidth/itemHeight,
            mainAxisSpacing: verticalMargin,
            crossAxisSpacing: horizentalMargin,
          ),
        itemBuilder:(context, index) {
          return Column(
            children: [
              GestureDetector(
                onTap: (){
                  moveCartoonViwer(cartoonList[index]['title']);
                },
                child: SizedBox(
                  width: itemWidth,
                  height: itemHeight,
                  child: Image.network(
                    cartoonList[index]["thumbnail_url"],
                    headers: customState.getHeaders(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(cartoonList[index]["title"]),
              Container(),
            ],
          );
        },
      )
    );
  }
  int getRowItemCounts(){
    double mediaWidth = MediaQuery.of(context).size.width;
    return (mediaWidth~/(itemWidth+2*horizentalMargin));
  }

  moveCartoonViwer(String title)async{
    List<dynamic> imagesList = await customState.getContents(title);
    Get.toNamed(
      "/cartoon/viwer",arguments: imagesList
    );
  }
}