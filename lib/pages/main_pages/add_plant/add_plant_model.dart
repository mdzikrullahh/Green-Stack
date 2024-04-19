import '/flutter_flow/flutter_flow_util.dart';
import 'add_plant_widget.dart' show AddPlantWidget;
import 'package:flutter/material.dart';

class AddPlantModel extends FlutterFlowModel<AddPlantWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PlantName widget.
  FocusNode? plantNameFocusNode;
  TextEditingController? plantNameTextController;
  String? Function(BuildContext, String?)? plantNameTextControllerValidator;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    plantNameFocusNode?.dispose();
    plantNameTextController?.dispose();
  }
}
