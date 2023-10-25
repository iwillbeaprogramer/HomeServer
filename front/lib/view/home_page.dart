import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                ),
                child: const Text("Home")
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                ),
                child: const Text("Github")
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                ),
                child: const Text("Blog")
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ElevatedButton(
                onPressed: (){
                  Get.toNamed("/cartoon");
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            )
                ),
                child: const Text("Cartoon")
              ),
            ),
          ],
        ),
      ),
    );
  }
}