import 'package:flutter/material.dart';

/// Controller for SimpleYoutubePlayer
class SimpleYoutubePlayerController extends ChangeNotifier {
  bool _isPlaying = false;
  bool _isLoading = true;
  String? _error;

  bool get isPlaying => _isPlaying;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setPlaying(bool playing) {
    _isPlaying = playing;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    _isLoading = false;
    notifyListeners();
  }
}
