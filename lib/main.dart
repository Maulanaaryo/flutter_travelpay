import 'package:ata_travelpay/data/datasources/banner_remote_datasource.dart';
import 'package:ata_travelpay/presentation/home/bloc/banner/banner_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/home/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannerBloc(BannerRemoteDataSource()),
      child: MaterialApp(
        title: 'Flutter Travel Pay',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
