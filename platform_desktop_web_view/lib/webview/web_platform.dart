import 'dart:html' show IFrameElement;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:platform_desktop_web_view/webview/another.dart';

class AppWebView extends BaseAppWebView {

  AppWebView();

  static final AppWebView initial = AppWebView();

  @override
  Widget webView(String link) {
    final id = Random().nextInt.toString();
    ui.platformViewRegistry
        .registerViewFactory(id, (int viewId) {
          var iframe = IFrameElement();
          iframe.src = link;
          return iframe;
        });
    return HtmlElementView(viewType: id,);
  }
}
