import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WebRTC Demo Camera'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

 
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _localRenderer = new RTCVideoRenderer();

  @override
  void dispose() {
    _localRenderer.dispose();
    super.dispose();
  }
  
  @override
  void initState() {
    initRenderers();
    _getUserMedia();
    super.initState();
  }
  
  initRenderers() async {
    await _localRenderer.initialize();
  }

  _getUserMedia() async {
    final Map<String, dynamic> meidaConstraints = {
      'audio': true,
      'video': {
        'facingMode': 'user',
      },
    };

    MediaStream stream = await navigator.mediaDevices.getUserMedia(meidaConstraints);

    _localRenderer.srcObject = stream;
  }
  
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Stack(
            children: <Widget>[
              new Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: new Container(
                  child: RTCVideoView(_localRenderer),
                ),
              )
            ],
          ),
        ),

      ),
    );
  }
}
