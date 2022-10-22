import 'package:common/network/repository/CarRepository.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/view/myvehicle/my_car_screen.dart';

class AllCarDetailsPage extends StatefulWidget {
  final CarRepository carRepository;

  const AllCarDetailsPage({Key? key, required this.carRepository})
      : super(key: key);

  @override
  State<AllCarDetailsPage> createState() => _AllCarDetailsPageState();
}

class _AllCarDetailsPageState extends State<AllCarDetailsPage> {
  CarRepository get _carRepository => widget.carRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _carRepository.carDetails(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return MyCarsScreen(snapshot.data, CarRepository());
          }
        },
      ),
    );
  }
}
