import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple YouTube Player Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final TextEditingController _urlController = TextEditingController(
    text: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  );

  String _currentUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';
  double _width = 300;
  double _height = 200;
  bool _autoPlay = false;
  bool _showControls = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple YouTube Player'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // URL Input
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'YouTube URL',
                border: OutlineInputBorder(),
                hintText: 'Paste YouTube URL here',
              ),
            ),
            const SizedBox(height: 16),

            // Width Slider
            Row(
              children: [
                const Text('Width: '),
                Expanded(
                  child: Slider(
                    value: _width,
                    min: 200,
                    max: 400,
                    divisions: 20,
                    label: _width.round().toString(),
                    onChanged: (value) {
                      setState(() => _width = value);
                    },
                  ),
                ),
                Text(_width.round().toString()),
              ],
            ),

            // Height Slider
            Row(
              children: [
                const Text('Height: '),
                Expanded(
                  child: Slider(
                    value: _height,
                    min: 150,
                    max: 300,
                    divisions: 15,
                    label: _height.round().toString(),
                    onChanged: (value) {
                      setState(() => _height = value);
                    },
                  ),
                ),
                Text(_height.round().toString()),
              ],
            ),

            // Options
            SwitchListTile(
              title: const Text('Auto Play'),
              value: _autoPlay,
              onChanged: (value) {
                setState(() => _autoPlay = value);
              },
            ),

            SwitchListTile(
              title: const Text('Show Controls'),
              value: _showControls,
              onChanged: (value) {
                setState(() => _showControls = value);
              },
            ),

            const SizedBox(height: 16),

            // Load Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentUrl = _urlController.text;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Load Video'),
            ),

            const SizedBox(height: 32),

            // Video Player
            Center(
              child: SimpleYoutubePlayer(
                key: ValueKey(
                    _currentUrl + _width.toString() + _height.toString()),
                url: _currentUrl,
                width: _width,
                height: _height,
                autoPlay: _autoPlay,
                showControls: _showControls,
              ),
            ),

            const SizedBox(height: 32),

            // Example URLs
            const Text(
              'Try these URLs:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildExampleUrl('https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
            _buildExampleUrl('https://youtu.be/jNQXAC9IVRw'),
            _buildExampleUrl('https://www.youtube.com/embed/9bZkp7q19f0'),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleUrl(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          setState(() {
            _urlController.text = url;
            _currentUrl = url;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.link, size: 20, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  url,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
