

import 'package:urbandrop/models/config_model.dart';

abstract class ConfigState {}

class ConfigInitial extends ConfigState {}

class ConfigLoading extends ConfigState {}
class ConfigEmpty extends ConfigState {}

class ConfigLoaded extends ConfigState {
ConfigData? configModel;
  ConfigLoaded({required this.configModel});
}




