import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/banner/banner_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<BannerBloc>().add(const BannerEvent.getBanner());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFE5F5F),
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFE5F5F), Color(0xFFFC9842)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(30),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TravelPay',
                          style: GoogleFonts.poppins(
                              fontSize: 22, color: Colors.white),
                        ),
                        const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 26,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 20,
                    right: 20,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.search,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Search',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 195, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildService(Icons.airplanemode_active,
                              Colors.blueAccent, 'Pesawat'),
                          _buildService(Icons.train, Colors.green, 'Kereta'),
                          _buildService(
                              Icons.apartment, Colors.blue.shade900, 'Hotel'),
                          _buildService(
                              Icons.directions_boat, Colors.red, 'Pelni')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<BannerBloc, BannerState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: Text('Error'),
                      );
                    },
                    loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    loaded: (datas) {
                      return Container(
                        height: 260,
                        margin: const EdgeInsets.only(
                          top: 12,
                          right: 6,
                        ),
                        // color: Colors.amber,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: datas.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  datas[index].img,
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildService(IconData iconData, Color iconColor, String text) {
    return SizedBox(
      width: 70,
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  iconData,
                  color: iconColor,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
