import 'package:famylia_client/famylia_client.dart';

import 'famylia_services.dart';

class ShareRepository {
  ShareRepository({FamyliaServices? services})
      : _client = (services ?? FamyliaServices.instance).client;

  final Client _client;

  Future<SharedContentAnalysis> analyzeContent(
    String content, {
    String? fileName,
    int? familyId,
  }) async {
    return _client.share.analyzeContent(content, fileName: fileName, familyId: familyId);
  }
}
