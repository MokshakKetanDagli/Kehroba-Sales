import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late WebViewController controller;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: homeURL,
              javascriptMode: JavascriptMode.unrestricted,
              zoomEnabled: true,
              onWebViewCreated: (controller) {
                this.controller = controller;
              },
              onPageFinished: (url) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  )
                : Stack(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.currentUrl() != homeURL ? controller.loadUrl(homeURL) : true;
        },
        child: const Icon(Icons.home),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
