import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samo_techno_crm/ui/pages/profile_settings_page/profile_settings_event.dart';
import 'package:samo_techno_crm/ui/pages/profile_settings_page/profile_settings_state.dart';

class ProfileSettingsBloc
    extends Bloc<ProfileSettingsEvent, ProfileSettingsState> {
  ProfileSettingsBloc() : super(Initial()) {
    on<PickImageEvent>((event, emit) async {
      await _pickImage(emit);
    });
  }

  // Controllers

  TextEditingController chatCtrl = TextEditingController();

  // Data
  File? selectedImage;

  _pickImage(Emitter<ProfileSettingsState> emit) async {
    try {
      emit(PickImageState(state: State.loading));
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      }
      if (kDebugMode) {
        print("ChatBloc _pickImage image picked succesfully");
      }
      emit(PickImageState(state: State.loaded));
    } catch (e) {
      emit(PickImageState(state: State.error));
      if (kDebugMode) {
        print("ChatBloc _pickImage error => $e");
      }
    }
  }
}
