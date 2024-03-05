import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:urbandrop/core/helper/hide.dart';
import 'package:urbandrop/models/address_cordinate.dart' as loc;
import 'package:urbandrop/models/get_location.dart';
import 'package:urbandrop/models/get_nearby_places.dart';
import 'package:urbandrop/models/get_places_details.dart';



class GooglePlacesController{
  Future<Position> getLocation() async{
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
     getPlaces(double lat, double lon) async {
    List<Result> results = [];
    try{
      var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$mapKey");

      Response response = await get(url);
      print("http res ${"https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$mapKey"}");
      Map _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        for (var i = 0; i < _places['results'].length; i++) {
          Result g = Result.fromJson(_places['results'][i]);
          results.add(g);
        }
        print("name: ${results[0].formattedAddress}");
        return results;
      }else{
        print(_places['status']);
        return results;
      }

    } catch(e){
      print("error message $e");
      return results;
    }

  }

   findPlaces(String placeName) async {
    List<Prediction> predictions = [];
    // try{
      String _url = '';
        _url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(placeName)}&key=$mapKey&sessiontoken=1234567890";
      var url = Uri.parse(_url);
      print("http res $url");
      Response response = await get(url);
      Map _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        for (var i = 0; i < _places['predictions'].length; i++) {
          Prediction g = Prediction.fromJson(_places['predictions'][i]);
          predictions.add(g);
          print("name: ${predictions[0].placeId}");
        }
      }
      return predictions;
    // } catch(e){
    //   print("error message $e");
    //   return predictions;
    // }

  }

  findDropOffPlacesDetails(String placeid) async {
    List<GetPlacesDetails> getPlacesDetails = [];
    try{
      var url = Uri.parse("https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$mapKey");

      Response response = await get(url);
      print("http res ${"https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$mapKey"}");
      Map<String, dynamic> _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        print("Status ok");
        print(_places['result']);
        GetPlacesDetails g = GetPlacesDetails.fromJson(_places);
        getPlacesDetails.add(g);
        if(getPlacesDetails.isNotEmpty){
          print("not empty resultDetails ${getPlacesDetails[0].result!.geometry!.location!.lat}");
        }else{
          print(" empty resultDetails");
        }
      }
      return getPlacesDetails;

    } catch(e){
      print("error message $e");
      return getPlacesDetails;
    }

  }


  getLoc(String cor) async {
    List<loc.GetPlacesDetailsCor> getPlacesDetails = [];
    // try{
    var url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$cor&sensor=false&key=$mapKey");

    Response response = await get(url);
    print("http loc res ${"https://maps.googleapis.com/maps/api/geocode/json?latlng=$cor&sensor=false&key=$mapKey"}");
    Map<String, dynamic> _places = jsonDecode(response.body);
    print("_places $_places");
    if(_places['status'].toString().toUpperCase() == "OK"){
      print("Status ok");
      print(_places['results']);
      loc.GetPlacesDetailsCor g = loc.GetPlacesDetailsCor.fromJson(_places);
      getPlacesDetails.add(g);
      if(getPlacesDetails.isNotEmpty){
      }else{
        print(" empty resultDetails");
      }
    }
    return getPlacesDetails;

    // } catch(e){
    //   print("error message $e");
    //   return getPlacesDetails;
    // }

  }


}
