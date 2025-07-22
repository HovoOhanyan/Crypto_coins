part of 'crypto_coin_bloc.dart';

sealed class CryptoCoinState extends Equatable {
  @override
  List<Object> get props => [];
}

class CryptoCoinsInital extends CryptoCoinState {}

class CryptoCoinLoadingState extends CryptoCoinState {}

class CryptoCoinLoadedState extends CryptoCoinState {}

class CryptoCoinLoadingMoreState extends CryptoCoinState {}

class CryptoCoinLoadedMoreState extends CryptoCoinState {}

class CryptoCoinGetedState extends CryptoCoinState {
  CryptoCoinGetedState({required this.coins});

  final List<CryptoCoinModel> coins;
}
