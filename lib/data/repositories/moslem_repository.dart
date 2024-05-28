import 'package:kita_muslim/data/providers/api_moslem_add_provider.dart';

class MoslemRepository {
  final apiMoslemAddProvider = ApiMoslemAddProvider();

  Future<int> getSellPriceGold() async {
    return await apiMoslemAddProvider.getSellPriceGold();
  }
}
