import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfHome extends StatefulWidget {

  // Load from assets
  @override
  _PdfHomeState createState() => _PdfHomeState();
}

class _PdfHomeState extends State<PdfHome> {
  bool _isLoading = true;
PDFDocument doc;

@override
  void initState() {
    super.initState();
    loadDocument();
  }

  loadDocument() async {
    doc = await PDFDocument.fromAsset('assets/images/rbac117.pdf');

    setState(() => _isLoading = false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00005a),
        centerTitle: true,
        title:Text('RBAC 117'),),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
              showPicker:false ,
              indicatorBackground:Color(0xff858585),
              document: doc)),
    

      
      
    );
  }
}