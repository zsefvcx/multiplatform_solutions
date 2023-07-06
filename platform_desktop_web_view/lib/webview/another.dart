
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class BaseAppWebView{

  Widget webView(String link);
}

class AppWebView extends BaseAppWebView{

  AppWebView();

  static final AppWebView initial = AppWebView();

  @override
  Widget webView(String link) {
    return GestureDetector(
      child: Center(child: Text(link)),
      onTap: () async => await launchUrl(Uri.parse(link),),
    );
  }
}
