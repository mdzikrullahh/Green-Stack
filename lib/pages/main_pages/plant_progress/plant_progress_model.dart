import '/flutter_flow/flutter_flow_util.dart';
import 'plant_progress_widget.dart' show PlantProgressWidget;
import 'package:flutter/material.dart';

class PlantProgressModel extends FlutterFlowModel<PlantProgressWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
