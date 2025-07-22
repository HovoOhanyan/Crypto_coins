import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_application_for_review/api_repository/crypto_coin_api_repository.dart';
import 'package:simple_application_for_review/crypto_coins_screen/crypto_coin_bloc/crypto_coin_bloc.dart';
import 'package:simple_application_for_review/crypto_coins_screen/crypto_coin_item.dart';
import 'package:simple_application_for_review/model/crypto_coin_model.dart';

class CryptoCoinsScreen extends StatefulWidget {
  const CryptoCoinsScreen({super.key});

  @override
  State<CryptoCoinsScreen> createState() => _CryptoCoinsScreenState();
}

class _CryptoCoinsScreenState extends State<CryptoCoinsScreen> {
  late final _bloc = CryptoCoinBloc(
    cryptoCoinApiRepository: CryptoCoinApiRepositoryImpl(),
  )..add(LoadCrytoCoinsEvent(offset: offset, limit: limit));

  final _scrollController = ScrollController();

  int limit = 15;
  int offset = 0;

  bool isLoading = true;
  bool isLoadingMore = false;

  List<CryptoCoinModel> coins = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<CryptoCoinBloc, CryptoCoinState>(
        listener: _listener,
        child: BlocBuilder<CryptoCoinBloc, CryptoCoinState>(
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: isLoading
                ? Container(
                    color: Colors.white,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.black,
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: coins.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == coins.length) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        } else {
                          return CryptoCoinItem(item: coins[index]);
                        }
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void _onScrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      offset = limit;
      limit += 15;

      _bloc.add(LoadMoreCrytoCoinsEvent(offset: offset, limit: limit));
    }
  }
}

extension _CryptoCoinsScreenStateAddition on _CryptoCoinsScreenState {
  void _listener(BuildContext context, CryptoCoinState state) {
    if (state is CryptoCoinLoadingState) {
      isLoading = true;
    }

    if (state is CryptoCoinLoadedState) {
      isLoading = false;
    }

    if (state is CryptoCoinLoadingMoreState) {
      isLoadingMore = true;
    }

    if (state is CryptoCoinLoadedMoreState) {
      isLoadingMore = false;
    }

    if (state is CryptoCoinGetedState) {
      coins.addAll(state.coins);
    }
  }
}
