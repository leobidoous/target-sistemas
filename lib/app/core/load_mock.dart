import 'dart:convert' show jsonDecode;

import 'package:either_dart/either.dart';
import 'package:flutter/services.dart' show rootBundle;

class LoadMock {
  static Future<Either<Exception, Map<String, dynamic>>> fromAsset(
    String path, {
    Map<String, dynamic> Function(dynamic data)? saveInLocalDatabase,
  }) async {
    try {
      final data = await rootBundle.loadString('assets/mocks/$path');
      var result = jsonDecode(data);

      if (saveInLocalDatabase != null) {
        return Right(saveInLocalDatabase(result));
      }

      return Right(result);
    } catch (e) {
      return Left(Exception('LoadMock.fromAsset($path): $e'));
    }
  }
}
