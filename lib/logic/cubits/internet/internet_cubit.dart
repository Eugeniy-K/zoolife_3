import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
            if (state is InternetConnected)
              return;
            emitInternetConnected(ConnectionType.Connected);
          }

          if (result == ConnectivityResult.none)
            emitInternetDisconnected();
        });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}