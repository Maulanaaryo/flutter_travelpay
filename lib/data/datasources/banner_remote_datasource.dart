import 'dart:convert';

import 'package:ata_travelpay/data/models/banner_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class BannerRemoteDataSource {
  Future<Either<String, List<BannerResponseModel>>> getAllBanner() async {
  final response = await http.get(
    Uri.parse('https://api.npoint.io/33198fd6c5e7c62b974b'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonDataList = json.decode(response.body);
    final List<BannerResponseModel> banners = [];

    for (final jsonData in jsonDataList) {
      banners.add(BannerResponseModel.fromMap(jsonData));
    }

    return Right(banners);
  } else {
    return const Left('Get Banner Failed');
  }
}
}
