class CryptoCoinModel {
  final String id;
  final String rank;
  final String symbol;
  final String name;
  final String supply;
  final String priceUsd;
  final String explorer;

  CryptoCoinModel({
    required this.id,
    required this.rank,
    required this.symbol,
    required this.name,
    required this.supply,
    required this.priceUsd,
    required this.explorer,
  });

  factory CryptoCoinModel.fromJson(Map<String, dynamic> json) {
    return CryptoCoinModel(
      id: json['id'] ?? '',
      rank: json['rank'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      supply: json['supply'] ?? '',
      priceUsd: json['priceUsd'] ?? '',
      explorer: json['explorer'] ?? '',
    );
  }
}
