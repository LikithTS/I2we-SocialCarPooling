import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/model/places.dart';
import 'package:socialcarpooling/provider/address_provider.dart';
import 'package:socialcarpooling/util/configuration.dart';
import 'package:socialcarpooling/view/map/location_service_api/location_api.dart';

import '../../provider/provider_preference.dart';
import '../../util/TextStylesUtil.dart';
import '../../util/color.dart';

class SearchLocationView extends StatefulWidget {

  const SearchLocationView(
      {Key? key,})
      : super(key: key);

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  var _scrollController;

  @override
  Widget build(BuildContext context) {
    return SearchInjector(
      child: SafeArea(
        child: Consumer<LocationApi>(
          builder: (_, api, child) => SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 60, right: 60),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ]),
                  child: TextField(
                      controller: api.addressController,
                      decoration: InputDecoration(
                          fillColor: Colors.grey,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, color: Colors.transparent),
                          ),
                          hintText: 'Search Location',
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Colors.grey,
                          )),
                      onChanged: api.handleSearch),
                ),
                Container(
                  color: Colors.blue[200],
                  width: deviceWidth(context) * .7,
                  child: StreamBuilder<List<Place>>(
                      stream: api.controllerOut,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        }
                        final data = snapshot.data;
                        return data!.isEmpty
                            ? Container(
                                child: Center(
                                child: Text('No address found'),
                              ))
                            : Container(
                                height: 300,
                                child: Scrollbar(
                                  controller: _scrollController,
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Container(
                                      child: Builder(builder: (context) {
                                        return Column(
                                          children: List.generate(data.length,
                                              (index) {
                                            final places = data[index];
                                            return Column(
                                              children: [
                                                ListTile(
                                                  onTap: () {
                                                    /* api.addressController
                                                              .text =
                                                          '${places.name} , ${places.street} , ${places.country}';*/
                                                    ProviderPreference().putAddress(
                                                        context,
                                                        '${places.name} , ${places.street} , ${places.country}');

                                                    ProviderPreference().putLat(
                                                        context,
                                                        '${places.latitude}');
                                                    ProviderPreference().putLong(
                                                        context,
                                                        '${places.longitude}');
                                                  },
                                                  title: Text(
                                                    '${places.name} : ${places.street}',
                                                    style: TextStyleUtils
                                                        .primaryTextLight
                                                        .copyWith(
                                                            color: Colors.black,
                                                            height: 1.2,
                                                            fontSize: 14),
                                                  ),
                                                  subtitle: Text(
                                                    '${places.locality}',
                                                    style: TextStyleUtils
                                                        .primaryTextLight
                                                        .copyWith(
                                                            color: Colors.black,
                                                            height: 1.2,
                                                            fontSize: 12),
                                                  ),
                                                ),
                                                Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Divider(
                                                      height: 1,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            );
                                          }),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchInjector extends StatelessWidget {
  final Widget child;

  const SearchInjector({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationApi(),
      child: child,
    );
  }
}
