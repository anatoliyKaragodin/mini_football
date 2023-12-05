import 'package:flutter/foundation.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

import '../../main.dart';
import '../utils/library.dart';

class HomePageWeb extends StatefulWidget {
  final String route = 'home page web';

  const HomePageWeb({Key? key}) : super(key: key);

  @override
  State<HomePageWeb> createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  Widget build(BuildContext context) {
    CookieManager cookieManager = CookieManager.instance();
    InAppWebViewController? webViewController;
    InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          cacheEnabled: true,
          allowFileAccessFromFileURLs: true,
          allowUniversalAccessFromFileURLs: true,
          userAgent: userAgent,
          useOnDownloadStart: true,
          useOnLoadResource: true,
          useShouldOverrideUrlLoading: true,
          useShouldInterceptFetchRequest: true,
          mediaPlaybackRequiresUserGesture: false,
          javaScriptCanOpenWindowsAutomatically: true,
        ),
        android: AndroidInAppWebViewOptions(
            allowContentAccess: true,
            allowFileAccess: true,
            thirdPartyCookiesEnabled: true,
            useShouldInterceptRequest: true,
            useHybridComposition: true,
            domStorageEnabled: true,
            databaseEnabled: true,
            useWideViewPort: true,
            loadWithOverviewMode: true,
            safeBrowsingEnabled: false,
            disableDefaultErrorPage: true,

            // ignoreSSLErrors: true,
            mixedContentMode:
                AndroidMixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW));

    /// URI
    Uri uri = Uri.parse(url);

    return Scaffold(
        body:

            /// Webview widget
            WillPopScope(
                onWillPop: () async {
                  webViewController?.goBack();
                  return false;
                },
                child: InAppWebView(
                  onWebViewCreated: (controller) async {
                    /// Set cookies
                    final prefs = await SharedPreferences.getInstance();
                    var cookiesNames = prefs.getKeys();
                    for (var element in cookiesNames) {
                      var cookieValue = prefs.getString(element);
                      cookieManager.setCookie(
                          url: uri, name: element, value: cookieValue!);
                    }
                    webViewController = controller;
                  },
                  androidShouldInterceptRequest: (controller, request) async {
                    if (kDebugMode) {
                      print('REQUEST: $request');
                    }
                  },

                  initialOptions: options,

                  /// On permission request
                  androidOnPermissionRequest:
                      (InAppWebViewController controller, String origin,
                          List<String> resources) async {
                    if (kDebugMode) {
                      print('ORIGIN: $origin');
                    }
                    if (kDebugMode) {
                      print('RESOURCES: $resources');
                    }
                  },

                  /// On download
                  onDownloadStartRequest: (controller, downloadRequest) async {
                    SnackBar snackBar = const SnackBar(
                      content: SizedBox(
                          height: 200,
                          child: Center(
                              child: Text(
                            'Download start',
                            style: TextStyle(fontSize: 20),
                          ))),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    if (kDebugMode) {
                      print(
                          "_______________________onDownloadStart url: ${downloadRequest.url}");
                    }
                    FileDownloader.downloadFile(
                        url: '${downloadRequest.url}',
                        onDownloadCompleted: (path) {
                          SnackBar snackBar = SnackBar(
                            content: SizedBox(
                                height: 200,
                                child: Center(
                                    child: Text(
                                  'File downloaded to $path',
                                  style: const TextStyle(fontSize: 20),
                                ))),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          if (kDebugMode) {
                            print('____________DOWNLOAD COMPLETED TO: $path');
                          }
                        });
                  },
                  onLoadStart:
                      (InAppWebViewController controller, Uri? url) async {
                    Map<String, String> headers = {
                      'Content-Security-Policy': 'frame-ancestors \'self\''
                    };
                    await controller.evaluateJavascript(
                        source:
                            "document.querySelector('iframe').setAttribute('sandbox', 'allow-same-origin');");

                    /// Set cookies
                    final prefs = await SharedPreferences.getInstance();
                    var cookiesNames = prefs.getKeys();
                    for (var element in cookiesNames) {
                      var cookieValue = prefs.getString(element);
                      cookieManager.setCookie(
                          url: uri, name: element, value: cookieValue!);
                    }
                  },
                  onLoadStop:
                      (InAppWebViewController controller, Uri? url) async {
                    await controller.evaluateJavascript(
                        source:
                            "document.querySelector('iframe').setAttribute('sandbox', 'allow-same-origin');");
                    final prefs = await SharedPreferences.getInstance();
                    List<Cookie> cookies =
                        await cookieManager.getCookies(url: url!);
                    cookies.forEach((cookie) async {
                      if (kDebugMode) {
                        print(cookie.name + " " + cookie.value);
                      }
                      await prefs.setString(cookie.name, cookie.value);
                    });

                    // webViewController!.loadUrl(urlRequest: URLRequest(url: Uri.tryParse(url)));
                  },
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  initialUrlRequest: URLRequest(url: uri, headers: {
                    'Content-Security-Policy': 'frame-ancestors \'self\''
                  }),
                )));
  }
}
