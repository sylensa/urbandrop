import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final connectivityProvider = StreamProvider.autoDispose<ConnectivityResult>((ref) => Connectivity().onConnectivityChanged);

final internetProvider = FutureProvider.autoDispose<bool>((ref) async {
  final connectivity = ref.watch(connectivityProvider);
  if (connectivity.hasValue) {
    if (connectivity.value == ConnectivityResult.none) {
      return false;
    }
    final internetChecker = await InternetConnectionChecker().hasConnection;
    return internetChecker;
  }
  return await Connectivity().checkConnectivity() != ConnectivityResult.none;
});

final isConnectedProvider =
    Provider.autoDispose<bool>((ref) => ref.watch(internetProvider).maybeWhen(
          data: (isConnected) => isConnected,
          orElse: () => true,
        ));
final loginStepInternetCheckedProvider = Provider.autoDispose<bool>((ref) {
  return ref.watch(isConnectedProvider)
      ? true
      : false;
});