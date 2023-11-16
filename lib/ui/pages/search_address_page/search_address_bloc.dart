import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_event.dart';
import 'package:samo_techno_crm/ui/pages/search_address_page/search_address_state.dart';

class SearchAddressBloc extends Bloc<SearchAddressEvent, SearchAddressState> {
  SearchAddressBloc() : super(Initial()) {
    on<ShowToastEvent>((event, emit) async {
      await _showToast(emit);
    });
  }

  // Controllers

  TextEditingController searchAddressCtrl = TextEditingController();

  
  _showToast(Emitter<SearchAddressState> emit) {
    try {
      emit(ShowToastState(state: State.loading));
      Fluttertoast.showToast(
        msg: "Manzilni tanlang",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.indigo,
      );
      emit(ShowToastState(state: State.loaded));
    } catch (e) {
      emit(ShowToastState(state: State.error));
    }
  }
}
