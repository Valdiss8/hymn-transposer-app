import 'dart:io';
import 'package:flutter/material.dart';
import '../models/hymnal.dart';
import '../services/api_service.dart';

class HymnalProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Hymnal? _hymnal;
  bool _isLoading = false;

  Hymnal? get hymnal => _hymnal;
  bool get isLoading => _isLoading;

  Future<void> uploadHymnal(File file, int transposeInterval) async {
    _isLoading = true;
    notifyListeners();

    _hymnal = await _apiService.uploadFile(file, transposeInterval);

    _isLoading = false;
    notifyListeners();
  }
}
