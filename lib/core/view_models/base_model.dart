import 'package:base_auth_lib/core/enums/types.dart';
import 'package:flutter/widgets.dart';

/// Shared ViewModel functionality for [setState]
/// 
/// We have a state property that tells us what
/// UI layout to show in the view and when it's
/// updated we want to call notifyListeners
class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}