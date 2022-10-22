import 'package:common/network/repository/CarRepository.dart';
import 'package:flutter/material.dart';
import 'package:socialcarpooling/view/myvehicle/load_car_list_data.dart';

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
    return SafeArea(
      child: FutureBuilder<List<dynamic>>(
        future: _carRepository.carDetails(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.none: return Text('No Internet!!');
            case ConnectionState.waiting: return Text('Please wait... Loading details');
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return loadCarListData(snapshot.data);
              }
          }

          // return snapshot.connectionState == ConnectionState.waiting
          //     ? const CircularProgressIndicator()
          //     : Column(
          //   children: [
          //     loadCarListData(snapshot.data),
          //   ],
          // );
        },
      ),
    );
  }
}
