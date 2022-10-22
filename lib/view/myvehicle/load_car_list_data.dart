
import 'dart:developer';

import 'package:common/network/response/CarDetailsResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadCarListData(List<CarDetailsResponse> data) {
  log("List of car details : $data");
  return Material(
    child: Card(
      child: Container(
        width: double.infinity,
        child: Wrap(
            direction: Axis.vertical,
            children: [
              ListView.builder(
                itemCount:   data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Item ${data[index].carName}'),
                  );
                },
              ),
            ]
        ),
      ),
    )
  );
}