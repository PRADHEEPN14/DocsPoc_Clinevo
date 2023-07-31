// import 'package:flutter/material.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: RazorpayPaymentPage(),
//     );
//   }
// }

// class RazorpayPaymentPage extends StatefulWidget {
//   @override
//   _RazorpayPaymentPageState createState() => _RazorpayPaymentPageState();
// }

// class _RazorpayPaymentPageState extends State<RazorpayPaymentPage> {
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Handle payment success
//     print("Payment success: ${response.paymentId}");
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Handle payment failure
//     print("Payment error: ${response.code} - ${response.message}");
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Handle external wallet selection
//     print("External wallet: ${response.walletName}");
//   }

//   void _openCheckout() {
//     var options = {
//       'key': 'rzp_test_92AKUUg4YLApBI', // Replace with your test API key
//       'amount': 1000, // amount in the smallest currency unit (e.g., paise in India)
//       'name': 'Your App Name',
//       'description': 'Test Payment',
//       'prefill': {'contact': '9090909090', 'email': 'YOUREMAILID@gmail.com'},
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: $e');
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Razorpay Payment Test'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _openCheckout,
//           child: Text('Make Payment'),
//         ),
//       ),
//     );
//   }
// }



/***** WEBVIEW for PDF DOC DOCX ..*****/




import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// InAppLocalhostServer localhostServer = new InAppLocalhostServer(documentRoot: 'assets');

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Permission.camera.request();
  // await Permission.microphone.request();
  // await Permission.storage.request();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }

  runApp(MyApp());
}

Drawer myDrawer({required BuildContext context}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          child: Text('flutter_inappbrowser example'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: const Text('InAppBrowser'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/InAppBrowser');
          },
        ),
        ListTile(
          title: const Text('ChromeSafariBrowser'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/ChromeSafariBrowser');
          },
        ),
        ListTile(
          title: const Text('InAppWebView'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        ListTile(
          title: const Text('HeadlessInAppWebView'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/HeadlessInAppWebView');
          },
        ),
      ],
    ),
  );
  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: {
      '/': (context) => const InAppWebViewExampleScreen(),
      '/InAppBrowser': (context) => const InAppBrowserExampleScreen(url: "",),
      '/ChromeSafariBrowser': (context) => const ChromeSafariBrowserExampleScreen(),
      '/HeadlessInAppWebView': (context) => const HeadlessInAppWebViewExampleScreen(),
    });
  }
  
}

 class InAppWebViewExampleScreen extends StatefulWidget {
  const InAppWebViewExampleScreen({super.key});

  @override
  State<InAppWebViewExampleScreen> createState() => _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Web sample"),),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Center(child: ElevatedButton(onPressed: (){
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InAppBrowserExampleScreen(url:"https://docs.google.com/gview?url=https://demo.emeetify.com:5890/dummyhenil.doc&embedded=true"),
          ),
        );
          }, child: const Text("Doc View"))),
          Center(child: ElevatedButton(onPressed: (){
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InAppBrowserExampleScreen(url:"https://docs.google.com/gview?url=https://demo.emeetify.com:5890/dummyhenil.docx&embedded=true"),
          ),
        );
          }, child: const Text("Docx View"))),
          Center(child: ElevatedButton(onPressed: (){
            Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InAppBrowserExampleScreen(url:"https://docs.google.com/gview?url=https://demo.emeetify.com:5890/dummyhenil.pdf&embedded=true"),
          ),
        );
          }, child: const Text("PDF View"))),
        ],
      ),
    );
  }

}

 class InAppBrowserExampleScreen extends StatefulWidget {
  final String url;
  const InAppBrowserExampleScreen({super.key,required this.url});

  @override
  State<InAppBrowserExampleScreen> createState() => _InAppBrowserExampleScreenState();
}

class _InAppBrowserExampleScreenState extends State<InAppBrowserExampleScreen> {
  String docLink = 'https://www.example.com/sample.docx'; // Replace this with your actual link
  Uri? link;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Call the function to open the document when needed
  link=Uri.parse(widget.url);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('In-App Web View'),
        ),
        body: Center(
          child:
          InAppWebView(
            initialUrlRequest: URLRequest(url: link),
          ),
        ),
      ),
    );
  }

}

 class ChromeSafariBrowserExampleScreen extends StatefulWidget {
  const ChromeSafariBrowserExampleScreen({super.key});

  @override
  State<ChromeSafariBrowserExampleScreen> createState() => _ChromeSafariBrowserExampleScreenState();
}

class _ChromeSafariBrowserExampleScreenState extends State<ChromeSafariBrowserExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}

 class HeadlessInAppWebViewExampleScreen extends StatefulWidget {
  const HeadlessInAppWebViewExampleScreen({super.key});

  @override
  State<HeadlessInAppWebViewExampleScreen> createState() => _HeadlessInAppWebViewExampleScreenState();
}

class _HeadlessInAppWebViewExampleScreenState extends State<HeadlessInAppWebViewExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

}


