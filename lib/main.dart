import 'package:flutter/material.dart';
// import 'dart:async';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';

void main() {
  runApp(MyApp());
}
// ignore_for_file: prefer_const_constructors

class MyApp extends StatefulWidget {
  // MyApp({Key, key}) : super(key: key);
  //
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int itag = 18;
  String error = "";
  String link = "";

  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/bg.jpg'),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,

            // appBar: AppBar(
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 65.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text.rich(
                        TextSpan(
                          text: 'BY',
                          style: TextStyle(color: Colors.white),
                          // default text style
                          children: <TextSpan>[
                            TextSpan(
                                text: ' AADITESH KADU ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic)),
                            // TextSpan(

                            //     style: TextStyle(
                            //         color: Colors.white,
                            //         fontWeight: FontWeight.bold)),
                            // const TextStyle(color: Colors.white),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: TextFormField(
                          controller: urlController,
                          decoration: const InputDecoration(
                            hintText: "Enter Youtube URL",
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      qualityButton(quality: "360p"),
                      const SizedBox(
                        height: 15,
                      ),
                      qualityButton(quality: "720p"),
                      const SizedBox(
                        height: 15,
                      ),
                      qualityButton(quality: "1080p"),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        child: const Text(
                          "Download",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          elevation: MaterialStateProperty.all(10),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 60),
                          ),
                        ),
                        // shape:MaterialStateProperty.all(
                        //   RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(13),
                        //   ),
                        // ),
                        onPressed: () async {
                          link =
                              await FlutterYoutubeDownloader.extractYoutubeLink(
                            urlController.text,
                            itag,
                          );
                          if (link == "Failed to get itag URL") {
                            setState(() {
                              error = "Invalid Youtube URL";
                            });
                          } else {
                            FlutterYoutubeDownloader.downloadVideo(
                                urlController.text.trim(),
                                "Youtube Video ",
                                itag);
                          }
                        },
                      ),
                    ])),
          )),
// Text (
//   error,
//   style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)
// )
    )));
  }

  ElevatedButton qualityButton({required String quality}) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          elevation: MaterialStateProperty.all(10),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 7, horizontal: 60),
          ),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)))),
      onPressed: () {
        // int itag==18;
        switch (quality) {
          case "360":
            setState(() {
              itag = 18;
            });
            break;
          case "720":
            setState(() {
              itag = 22;
            });
            break;
          case "1080":
            setState(() {
              itag = 137;
            });
            break;
          default:
            break;
        }
      },
      child: Text(
        quality,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
