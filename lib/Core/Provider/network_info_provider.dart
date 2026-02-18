import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkProvider extends ChangeNotifier {

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _subscription;

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  bool _backToOnline = false;
  bool get backToOnline => _backToOnline;

  NetworkProvider() {
    _init();
  }

  void _init() async {
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);

    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final newStatus = !results.contains(ConnectivityResult.none);

    if (_isOnline != newStatus) {
      if(newStatus){_backToOnline=true;}
      _isOnline = newStatus;
      notifyListeners();
    }
  }


  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
