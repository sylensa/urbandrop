import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbandrop/controllers/shared_preference.dart';
import 'package:urbandrop/core/http/http_client_wrapper.dart';
import 'package:urbandrop/core/utils/app_url.dart';
import 'package:urbandrop/core/utils/response_codes.dart';
import 'package:urbandrop/cubit_state/config_state.dart';
import 'package:urbandrop/models/config_model.dart';

class ConfigController extends Cubit<ConfigState>{
  ConfigController() : super(ConfigInitial());
  final userPreferences = UserPreferences();
  final HttpClientWrapper _http = HttpClientWrapper();
  ConfigData? configModel;
  getUserConfig() async {
    if(configModel == null){
      emit(ConfigInitial());
      try {
        var response = await _http.getRequest(AppUrl.config);
        if (response["status"] == AppResponseCodes.success) {
          configModel = ConfigData.fromJson(response["data"]);
          emit(ConfigLoaded(configModel: configModel));
        }else{
          emit(ConfigEmpty());
        }
      } catch (e) {
        emit(ConfigEmpty());
      }
    }

  }



}