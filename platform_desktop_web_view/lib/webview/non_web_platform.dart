import 'package:flutter/material.dart';
import 'package:platform_desktop_web_view/webview/another.dart';

import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends BaseAppWebView {
  late final WebViewController controller;

  AppWebView() {
    controller = WebViewController();
  }

  static final AppWebView initial = AppWebView();

  @override
  Widget webView(String link) {
    controller.loadRequest(
      Uri.parse(link),
    );
    return Expanded(
      child: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
