import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:receipe_app/ui/screens/authentication/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.receipe_app/image');
  String? _imagePath;

  Future<void> _pickImage() async {
    try {
      await platform.invokeMethod('pickImage');
    } on PlatformException catch (e) {
      print("Failed to pick image: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((call) async {
      if (call.method == "imagePicked") {
        setState(() {
          _imagePath = call.arguments;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Native Image Picker Demo'),
      ),
      body: Center(
        child: _imagePath == null
            ? const Text('No image selected.')
            : Image.network(_imagePath!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
