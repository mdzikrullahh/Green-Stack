import '/flutter_flow/flutter_flow_util.dart';
import 'myplant_widget.dart' show MyplantWidget;
import 'package:flutter/material.dart';

class MyplantModel extends FlutterFlowModel<MyplantWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
