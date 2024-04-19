import '/flutter_flow/flutter_flow_util.dart';
import 'monitor_plants_widget.dart' show MonitorPlantsWidget;
import 'package:flutter/material.dart';

class MonitorPlantsModel extends FlutterFlowModel<MonitorPlantsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
