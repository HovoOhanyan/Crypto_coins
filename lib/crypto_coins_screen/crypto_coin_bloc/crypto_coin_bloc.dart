import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_application_for_review/api_repository/crypto_coin_api_repository.dart';
import 'package:simple_application_for_review/model/crypto_coin_model.dart';

part 'cryto_coin_state.dart';
part 'cryto_coin_event.dart';

class CryptoCoinBloc extends Bloc<CrytoCoinEvent, CryptoCoinState> {
  CryptoCoinBloc({required this.cryptoCoinApiRepository})
    : super(CryptoCoinsInital()) {
    on<LoadCrytoCoinsEvent>(_onLoadCrytoCoinsEvent);
    on<LoadMoreCrytoCoinsEvent>(_onLoadMoreCrytoCoinsEvent);
  }

  final CryptoCoinApiRepository cryptoCoinApiRepository;

  Future<void> _onLoadCrytoCoinsEvent(
    LoadCrytoCoinsEvent event,
    Emitter emit,
  ) async {
    if (event.limit <= 15) {
      emit(CryptoCoinLoadingState());
    }

    final coins = await cryptoCoinApiRepository.loadCrytoCoins(
      offset: event.offset,
      limit: event.limit,
    );

    emit(CryptoCoinGetedState(coins: coins));

    if (event.limit <= 15) {
      emit(CryptoCoinLoadedState());
    }
  }

  Future<void> _onLoadMoreCrytoCoinsEvent(
    LoadMoreCrytoCoinsEvent event,
    Emitter emit,
  ) async {
    emit(CryptoCoinLoadingMoreState());

    final coins = await cryptoCoinApiRepository.loadCrytoCoins(
      offset: event.offset,
      limit: event.limit,
    );

    emit(CryptoCoinGetedState(coins: coins));

    emit(CryptoCoinLoadedMoreState());
  }
}
