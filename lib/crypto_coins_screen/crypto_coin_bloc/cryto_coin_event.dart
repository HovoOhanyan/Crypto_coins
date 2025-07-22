part of 'crypto_coin_bloc.dart';

sealed class CrytoCoinEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCrytoCoinsEvent extends CrytoCoinEvent {
  LoadCrytoCoinsEvent({required this.limit, required this.offset});

  final int limit;
  final int offset;
}

class LoadMoreCrytoCoinsEvent extends CrytoCoinEvent {
  LoadMoreCrytoCoinsEvent({required this.limit, required this.offset});

  final int limit;
  final int offset;
}
