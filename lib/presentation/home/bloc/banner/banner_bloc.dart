import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:ata_travelpay/data/datasources/banner_remote_datasource.dart';

import '../../../../data/models/banner_response_model.dart';

part 'banner_bloc.freezed.dart';
part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRemoteDataSource bannerRemoteDataSource;
  BannerBloc(
    this.bannerRemoteDataSource,
  ) : super(const _Initial()) {
    on<BannerEvent>((event, emit) async {
      emit(const _Loading());
      final response = await bannerRemoteDataSource.getAllBanner();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
