import 'dart:developer';

import 'package:backdoor_flutter/backdoor_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  Backdoor.initialize(
    appName: 'unpaid',
    url: 'https://raw.githubusercontent.com/gktirkha/backdoor_flutter/master/assets/example-hosted.json',
    version: 1,
    hiveBoxName: 'TEST',
    showLogs: true,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async => await Backdoor.checkPayment(
              onPaid: () {
                log('onPaid', name: 'Your Project');
              },
              onUnpaid: (apiResponse) {
                log('onUnpaid ${apiResponse?.message}', name: 'Your Project');
              },
              onException: (exception) {
                throw (exception);
              },
              onNetworkException: (exception) {
                log('onNetworkException', name: 'Your Project');
              },
              onCounter: ({expiryDate, remainingCounter, storedResponse}) {
                log('onCounter: storedResponse $storedResponse, expiryDate $expiryDate, remainingCounter $remainingCounter ', name: 'Your Project');
              },
            ),
            child: const Text('Check'),
          ),
        ),
      ),
    );
  }
}
