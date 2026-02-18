import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';
import '../App Colors/main_colors.dart';
import '../Provider/network_info_provider.dart';
import 'network_snackbar.dart';

class NetworkListener extends StatefulWidget {
  final Widget child;
  const NetworkListener({super.key, required this.child});

  @override
  State<NetworkListener> createState() => _NetworkListenerState();
}

class _NetworkListenerState extends State<NetworkListener> {
  @override
  void initState() {
    super.initState();
    context.read<NetworkProvider>().addListener(_onNetworkChange);
  }

  void _onNetworkChange() {
    final isOnline = context.read<NetworkProvider>().isOnline;
    final scaffoldContext = navigatorKey.currentContext!;

    ScaffoldMessenger.of(scaffoldContext).hideCurrentSnackBar();

    NetworkSnackBar.show(context, isOnline);
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    context.read<NetworkProvider>().removeListener(_onNetworkChange);
    super.dispose();
  }
}
