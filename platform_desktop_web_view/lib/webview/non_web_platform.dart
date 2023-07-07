import 'package:flutter/material.dart';
import 'package:platform_desktop_web_view/custom_platform.dart';
import 'package:platform_desktop_web_view/webview/another.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_windows/webview_windows.dart';

class AppWebView extends BaseAppWebView {
  late final controller;

  AppWebView() {
    if(AppPlatform.platform == CustomPlatform.android ||
       AppPlatform.platform == CustomPlatform.ios
    ) {
      late final PlatformWebViewControllerCreationParams params;
      if (WebViewPlatform.instance is WebKitWebViewPlatform) {
        params = WebKitWebViewControllerCreationParams();
      } else {
        params = const PlatformWebViewControllerCreationParams();
      }

      controller =
      WebViewController.fromPlatformCreationParams(params);
    }
  }

  static final AppWebView initial = AppWebView();

  @override
  Widget webView(String link) {
    if(AppPlatform.platform == CustomPlatform.android  ||
        AppPlatform.platform == CustomPlatform.ios) {
      controller.loadRequest(
        Uri.parse(link),
      );
      return WebViewWidget(
        controller: controller,
      );
    } else if(AppPlatform.platform == CustomPlatform.windows) {
      return WebViewWindows(link: link);
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Center(child: Text(link)),
        onTap: () async => await launchUrl(Uri.parse(link),),
      ),
    );
  }
}

class WebViewWindows extends StatefulWidget {
  const WebViewWindows({super.key, required String link}): _link = link;
  final String _link;
  @override
  State<WebViewWindows> createState() => _WebViewWindowsState();
}

class _WebViewWindowsState extends State<WebViewWindows> {
  final _controller = WebviewController();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await _controller.initialize();
    await _controller.setBackgroundColor(Colors.transparent);
    await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
    await _controller.loadUrl(widget._link);

    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller.value.isInitialized
          ? Webview(_controller)
          : const Text('Not Initialized'),
    );
  }
}
