import 'package:flutter_observable_state/flutter_observable_state.dart';
import 'package:qr_gen/core/locator.dart';
import 'package:qr_gen/core/models/seed.dart';
import 'package:qr_gen/core/services/qr.dart';

enum LoadingState { Idle, Busy, Success, Failure }

class QrState {
  final _loading = Observable<LoadingState>(LoadingState.Idle);
  final _seed = Observable<Seed>(null);

  LoadingState get loading => _loading.get();
  set loading(LoadingState state) => _loading.set(state);

  Seed get seed => _seed.get();
  set seed(Seed seed) => _seed.set(seed);
}

class QrActions {
  final _state = sl<QrState>();
  final _repository = sl<QrService>();

  Future<void> getSeed() async {
    _state.loading = LoadingState.Busy;

    try {
      _state.seed = await _repository.getSeed();
      _state.loading = LoadingState.Success;
    } catch (e) {
      _state.loading = LoadingState.Failure;
    }
  }
}
