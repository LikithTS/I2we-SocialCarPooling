import 'dart:developer';
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

  Function(double lat, double lng) searchedAddressData;

  SearchLocationView({
    Key? key, required this.searchedAddressData
  }) : super(key: key);

  @override
  State<SearchLocationView> createState() => _SearchLocationViewState();
}

class _SearchLocationViewState extends State<SearchLocationView> {
  var _scrollController;
  var closeFlag = false;

  @override
  void initState() {
    super.initState();

    closeFlag = true;
  }

  @override
  Widget build(BuildContext context) {
    return SearchInjector(
      child: SafeArea(
        child: Consumer<LocationApi>(
          builder: (_, api, child) => SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(10)),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: deviceWidth(context) * .8,
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
                              borderSide: BorderSide(
                                  width: 0, color: Colors.transparent),
                            ),
                            hintText: 'Search Location',
                            prefixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                setState(()
                                {
                                  api.addressController.clear();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  closeFlag=true;
                                });
                              },
                            ),
                          ),
                          onChanged: api.handleSearch),
                    ),
                  ],
                ),
                closeFlag
                    ? Container(
                  margin: EdgeInsets.only(left: 40),
                  color: Colors.blue[200],
                  width: deviceWidth(context) * .75,
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
                                    children: List.generate(
                                        data.length, (index) {
                                      final places = data[index];
                                      return Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              /* api.addressController
                                                              .text =
                                                          '${places.name} , ${places.street} , ${places.country}';*/
                                              widget.searchedAddressData(places.latitude, places.longitude);
                                              ProviderPreference()
                                                  .putAddress(
                                                  context,
                                                  '${places.name} , ${places.street} , ${places.locality}');

                                              ProviderPreference()
                                                  .putLatLng(
                                                  context,
                                                  LatLng(
                                                      places
                                                          .latitude,
                                                      places
                                                          .longitude));

                                              closeFlag = false;
                                              FocusManager.instance.primaryFocus?.unfocus();
                                            },
                                            title: Text(
                                              '${places.name} : ${places.street}',
                                              style: TextStyleUtils
                                                  .primaryTextLight
                                                  .copyWith(
                                                  color: Colors
                                                      .black,
                                                  height: 1.2,
                                                  fontSize: 14),
                                            ),
                                            subtitle: Text(
                                              '${places.locality}',
                                              style: TextStyleUtils
                                                  .primaryTextLight
                                                  .copyWith(
                                                  color: Colors
                                                      .black,
                                                  height: 1.2,
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  10),
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
                    : Container()
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
