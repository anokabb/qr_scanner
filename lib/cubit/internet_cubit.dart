import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/screens/MainScreen.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetInitial()) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        emitInternetConnected();
      } else if (result == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
      // if (MainScreen.controller != null) {
      //   MainScreen.controller!.pauseCamera();
      //   MainScreen.controller!.resumeCamera();
      // }
    });
  }

  void emitInternetConnected() => emit(InternetConnected());

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
