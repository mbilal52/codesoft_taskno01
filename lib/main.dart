import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final camera = cameras.first;
  runApp( HomePage(camera: camera));
}

class HomePage extends StatefulWidget {
  final CameraDescription camera;

  const HomePage({super.key, required this.camera});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CameraController controller;
  bool isFlashOn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.low);
    controller.initialize();
  }

  void flashLight(){
    if(isFlashOn){
      controller.setFlashMode(FlashMode.off);
    }else{
      controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      isFlashOn =! isFlashOn;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flash Light'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 170,
                  ),
                  const Center(
                      child: Text(
                        'Flashlight',
                        style: TextStyle(
                            fontSize: 50,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      flashLight();
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Center(
                          child: isFlashOn ? const Text('OFF', style: TextStyle(
                            fontSize: 40,
                          ),): const Text(
                            'ON',
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          )),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
