
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:socialcarpooling/provider/address_provider.dart';

class ProviderPreference{


  void putAddress(context,address)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeAddress(address);
  }
  void putStartDriverAddress(context,address)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeStartDriverAddress(address);
  }
  void putEndDriverAddress(context,address)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeEndDriverAddress(address);
  }
  void putStartRiderAddress(context,address)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeStartRiderAddress(address);
  }
  void putEndRiderAddress(context,address)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeEndRiderAddress(address);
  }
  void putDriverStartLatLng(context,latLng)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeDriverStartLatLong(latLng);
  }
  void putDriverDestLatLng(context,latLng)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeDriverDestLatLong(latLng);
  }
  void putLatLng(context,latLng)
  {
    Provider.of<AddressProvider>(context,
        listen: false)
        .changeLatLng(latLng);
  }

}