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
    } else if(AppPlatform.platform == CustomPlatform.windows) {
      controller = WebviewController();

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
      var f = () async {
        await controller.dispose();
        await controller.initialize();
        await controller.loadUrl(link);
      };
      return Webview(
        controller,
      );
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