import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String _url = 'https://flutter.dev';
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('나만의 웹브라우저'),
        actions: [
          IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.add),
          ),
       //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
         PopupMenuButton<String>(
           onSelected: (value){
          //   setState(() {
               _webViewController.loadUrl(value);
          //   });
           },
           itemBuilder: (context) => [
             PopupMenuItem(
              child:Text('구글'),
               value: 'https://www.google.com',
             ),
             PopupMenuItem(
               child:Text('네이버'),
               value: 'https://www.naver.com',
             ),
             PopupMenuItem(
               child:Text('카카오'),
               value: 'https://www.kakao.com',
             )
           ],
         )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (await _webViewController.canGoBack()){
            await _webViewController.goBack();
            return false;
          }
          return true;
        },
        child: WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller){
            _webViewController = controller;
          },
        ),
      ),
    );
  }
}
