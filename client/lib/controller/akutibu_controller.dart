import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_akutibu/flutter_akutibu.dart' as flutter_akutibu;

class AkutibuController extends ChangeNotifier {
  final Dio _dio = Dio();
  Map<String, dynamic>? _activeWindow;
  String _apiUrl = "";
  String _secretKey = "";
  bool _isRunning = false;
  String _error = "";

  Map<String, dynamic>? get activeWindow => _activeWindow;
  String get apiUrl => _apiUrl;
  String get secretKey => _secretKey;
  bool get isRunning => _isRunning;
  String get error => _error;

  void start() {
    if (_isRunning) {
      return;
    }
    _isRunning = true;
    notifyListeners();
    const duration = Duration(seconds: 3);
    Timer.periodic(duration, (timer) async {
      if (!_isRunning) {
        timer.cancel();
      }
      final activeWindow = jsonDecode(await flutter_akutibu.getActiveWindow());
      setActiveWindow(activeWindow);
    });
  }

  void stop() {
    _isRunning = false;
    notifyListeners();
  }

  void setActiveWindow(Map<String, dynamic>? activeWindow) {
    if (activeWindow == null) {
      return;
    }
    if (activeWindow["pid"] == _activeWindow?["pid"]) return;
    _activeWindow = activeWindow;
    _postApi(_activeWindow!);
    notifyListeners();
  }

  void _postApi(Map<String, dynamic> data) async {
    try {
      await _dio.post(
        "$_apiUrl/akutibu",
        data: data,
        options: Options(
          headers: {
            "Authorization": _secretKey,
            "Content-Type": "application/json",
          },
        ),
      );
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  void setApiUrl(String apiUrl) {
    _apiUrl = apiUrl;
    notifyListeners();
  }

  void setSecretKey(String secretKey) {
    _secretKey = secretKey;
    notifyListeners();
  }
}
