<div align="center">

# 🎥 Simple YouTube Player

### The easiest way to embed YouTube videos in Flutter

[![pub package](https://img.shields.io/pub/v/simple_youtube_player.svg)](https://pub.dev/packages/simple_youtube_player)
[![likes](https://img.shields.io/pub/likes/simple_youtube_player)](https://pub.dev/packages/simple_youtube_player/score)
[![popularity](https://img.shields.io/pub/popularity/simple_youtube_player)](https://pub.dev/packages/simple_youtube_player/score)
[![pub points](https://img.shields.io/pub/points/simple_youtube_player)](https://pub.dev/packages/simple_youtube_player/score)

A beautifully simple, lightweight, and powerful YouTube video player for Flutter. Just provide a URL and dimensions - that's it! No complex setup, no boilerplate code, just pure simplicity.

[**Getting Started**](#-installation) • [**Examples**](#-usage) • [**Documentation**](#-parameters) • [**Demo**](#-live-demo)

</div>

---

## ✨ Why Simple YouTube Player?

🎯 **Zero Configuration** - Works out of the box with sensible defaults  
🚀 **Lightweight** - Minimal dependencies, maximum performance  
🎨 **Customizable** - Full control over size, autoplay, controls, and more  
🔗 **Flexible URLs** - Supports all YouTube URL formats automatically  
📱 **Responsive** - Perfect for any screen size  
🎮 **Controller Support** - Advanced control when you need it  
⚡ **Fast Loading** - Optimized for quick video loading  
🛡️ **Error Handling** - Graceful error messages built-in  
🌍 **Cross-Platform** - Works on iOS, Android, Web, and Desktop  

---

## 📦 Installation

Add `simple_youtube_player` to your `pubspec.yaml`:

```yaml
dependencies:
  simple_youtube_player: ^0.0.1
```

Then install it:

```bash
flutter pub get
```

That's it! You're ready to go 🎉

---

## 🚀 Quick Start

The simplest possible usage:

```dart
import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Simple YouTube Player')),
        body: Center(
          child: SimpleYoutubePlayer(
            url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            width: 350,
            height: 220,
          ),
        ),
      ),
    );
  }
}
```

**That's literally all you need!** 🎊

---

## 💡 Usage Examples

### 🎬 Basic Video Player

Perfect for simple video embedding:

```dart
SimpleYoutubePlayer(
  url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
  width: 300,
  height: 200,
)
```

### ⚙️ Customized Player

Full control over player behavior:

```dart
SimpleYoutubePlayer(
  url: 'https://youtu.be/jNQXAC9IVRw',
  width: 400,
  height: 250,
  autoPlay: true,        // Start playing automatically
  mute: true,            // Start muted (recommended with autoPlay)
  loop: true,            // Loop the video infinitely
  showControls: true,    // Show YouTube player controls
)
```

### 🎮 With Controller

For advanced control and state monitoring:

```dart
import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

class AdvancedPlayerScreen extends StatefulWidget {
  @override
  _AdvancedPlayerScreenState createState() => _AdvancedPlayerScreenState();
}

class _AdvancedPlayerScreenState extends State<AdvancedPlayerScreen> {
  final _controller = SimpleYoutubePlayerController();

  @override
  void initState() {
    super.initState();
    
    // Monitor player state changes
    _controller.addListener(() {
      setState(() {}); // Rebuild UI when state changes
      
      if (_controller.error != null) {
        print('Error: ${_controller.error}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Advanced Player')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleYoutubePlayer(
            url: 'https://www.youtube.com/watch?v=VIDEO_ID',
            width: 350,
            height: 220,
            controller: _controller,
          ),
          SizedBox(height: 20),
          // Show loading indicator
          if (_controller.isLoading)
            CircularProgressIndicator(),
          // Show error if any
          if (_controller.error != null)
            Text(
              'Error: ${_controller.error}',
              style: TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### 📱 Responsive Player

Adapts to any screen size with perfect aspect ratio:

```dart
import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

class ResponsivePlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Player')),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate responsive dimensions
            double width = constraints.maxWidth * 0.9;
            double height = width * 9 / 16; // 16:9 aspect ratio
            
            return SimpleYoutubePlayer(
              url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
              width: width,
              height: height,
            );
          },
        ),
      ),
    );
  }
}
```

### 📜 Video List

Display multiple videos in a scrollable list:

```dart
import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

class VideoListScreen extends StatelessWidget {
  final List<Map<String, String>> videos = [
    {
      'title': 'Amazing Video 1',
      'url': 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    },
    {
      'title': 'Cool Tutorial',
      'url': 'https://youtu.be/jNQXAC9IVRw',
    },
    {
      'title': 'Must Watch',
      'url': 'https://www.youtube.com/watch?v=9bZkp7q19f0',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Playlist')),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                videos[index]['title']!,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              SimpleYoutubePlayer(
                url: videos[index]['url']!,
                width: MediaQuery.of(context).size.width - 32,
                height: 200,
              ),
              SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
```

### 🎨 Styled Player

Add beautiful styling around your player:

```dart
import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

class StyledPlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Styled Player'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SimpleYoutubePlayer(
                url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                width: 350,
                height: 220,
              ),
              SizedBox(height: 16),
              Text(
                'Featured Video',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Watch this amazing content',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 🎭 Background Video

Full-screen background video effect:

```dart
import 'package:flutter/material.dart';
import 'package:simple_youtube_player/simple_youtube_player.dart';

class BackgroundVideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background video
          Positioned.fill(
            child: SimpleYoutubePlayer(
              url: 'https://www.youtube.com/watch?v=VIDEO_ID',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              mute: true,
              loop: true,
              showControls: false,
            ),
          ),
          // Overlay content
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Get Started'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 🔗 Supported URL Formats

The package automatically recognizes all YouTube URL formats:

| Format | Example | ✅ Supported |
|--------|---------|-------------|
| Standard | `https://www.youtube.com/watch?v=VIDEO_ID` | ✅ |
| Short | `https://youtu.be/VIDEO_ID` | ✅ |
| Embed | `https://www.youtube.com/embed/VIDEO_ID` | ✅ |
| Mobile | `https://m.youtube.com/watch?v=VIDEO_ID` | ✅ |
| Direct ID | `VIDEO_ID` (11 characters) | ✅ |

**Just paste any YouTube URL and it works!** 🎯

---

## 📋 Parameters

Complete reference of all available parameters:

| Parameter | Type | Default | Required | Description |
|-----------|------|---------|----------|-------------|
| `url` | `String` | - | ✅ | YouTube video URL or video ID |
| `width` | `double` | `300.0` | ❌ | Player width in logical pixels |
| `height` | `double` | `200.0` | ❌ | Player height in logical pixels |
| `autoPlay` | `bool` | `false` | ❌ | Auto-start video playback on load |
| `mute` | `bool` | `false` | ❌ | Start video with audio muted |
| `loop` | `bool` | `false` | ❌ | Loop video playback infinitely |
| `showControls` | `bool` | `true` | ❌ | Display YouTube player controls |
| `controller` | `SimpleYoutubePlayerController?` | `null` | ❌ | Controller for advanced features |

---

## 🎮 Controller API

For advanced control and monitoring, use `SimpleYoutubePlayerController`:

### Properties

```dart
final controller = SimpleYoutubePlayerController();

// Check player state
bool isPlaying = controller.isPlaying;    // Is video currently playing?
bool isLoading = controller.isLoading;    // Is video still loading?
String? error = controller.error;         // Error message if any
```

### Methods

```dart
// Listen to state changes
controller.addListener(() {
  print('Player state changed!');
  print('Loading: ${controller.isLoading}');
  print('Error: ${controller.error}');
});

// Don't forget to dispose!
controller.dispose();
```

---

## 🌟 Best Practices

### ✅ DO:

```dart
// Use mute with autoPlay for better UX
SimpleYoutubePlayer(
  url: 'https://youtube.com/watch?v=...',
  autoPlay: true,
  mute: true,  // ✅ Good practice
)

// Dispose controllers
@override
void dispose() {
  _controller.dispose();  // ✅ Prevents memory leaks
  super.dispose();
}

// Handle errors gracefully
controller.addListener(() {
  if (controller.error != null) {
    // Show user-friendly message
  }
});
```

### ❌ DON'T:

```dart
// Don't autoplay with sound (annoying for users)
SimpleYoutubePlayer(
  autoPlay: true,
  mute: false,  // ❌ Bad UX
)

// Don't forget controller cleanup
// ❌ Memory leak!

// Don't use extremely large dimensions
SimpleYoutubePlayer(
  width: 10000,  // ❌ Performance issue
  height: 10000,
)
```

---

## 🎨 Customization Tips

### Perfect 16:9 Aspect Ratio

```dart
double width = 400;
double height = width * 9 / 16;  // = 225

SimpleYoutubePlayer(
  url: url,
  width: width,
  height: height,
)
```

### Dynamic Sizing Based on Screen

```dart
double screenWidth = MediaQuery.of(context).size.width;
double playerWidth = screenWidth * 0.9;  // 90% of screen
double playerHeight = playerWidth * 9 / 16;
```

### Card-Style Player

```dart
Card(
  elevation: 8,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: SimpleYoutubePlayer(
      url: url,
      width: 300,
      height: 200,
    ),
  ),
)
```

---

## 🌍 Platform Support

| Platform | Supported | Notes |
|----------|-----------|-------|
| 🤖 Android | ✅ | Full support |
| 🍎 iOS | ✅ | Full support |
| 🌐 Web | ✅ | Full support |
| 💻 macOS | ✅ | Full support |
| 🪟 Windows | ✅ | Full support |
| 🐧 Linux | ✅ | Full support |

---

## ⚠️ Important Notes

- 📡 **Internet Required**: Videos require active internet connection
- 🔒 **Embed Restrictions**: Some videos may have embedding disabled by uploader
- 🎬 **YouTube Terms**: Respects YouTube's Terms of Service
- 🔄 **WebView Based**: Uses `webview_flutter` internally for reliability

---

## 🐛 Troubleshooting

### Video Not Loading?

1. **Check URL**: Ensure the URL is valid and video exists
2. **Check Internet**: Verify internet connection is active
3. **Check Embedding**: Some videos can't be embedded (error will show)
4. **Check Platform**: Ensure WebView is supported on your platform

### Controller Not Working?

```dart
// Make sure controller is initialized before use
final controller = SimpleYoutubePlayerController();

// Don't create new controller in build method
// ❌ Bad
@override
Widget build(BuildContext context) {
  final controller = SimpleYoutubePlayerController(); // Creates new every rebuild!
  ...
}

// ✅ Good
class _MyWidgetState extends State<MyWidget> {
  late final controller = SimpleYoutubePlayerController();
  ...
}
```

---

## 📱 Live Demo

Check out the `/example` folder for a complete demo app featuring:
- Basic player usage
- Advanced controller features
- Responsive layouts
- Multiple videos in list
- Styled player examples
- All configuration options

Run the example:

```bash
cd example
flutter run
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. 🐛 **Report Bugs**: Open an issue with reproduction steps
2. 💡 **Suggest Features**: Share your ideas in issues
3. 🔧 **Submit PRs**: Fork, code, and submit pull requests
4. 📖 **Improve Docs**: Help make documentation better
5. ⭐ **Star the Repo**: Show your support!

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**TL;DR**: Free to use, modify, and distribute. Commercial use allowed. 🎉

---

## 🙏 Credits

- Built with ❤️ for the Flutter community
- Powered by [`webview_flutter`](https://pub.dev/packages/webview_flutter)
- Inspired by the need for simplicity in video embedding

---

## 💬 Support & Feedback

- 📦 **Package**: [pub.dev/packages/simple_youtube_player](https://pub.dev/packages/simple_youtube_player)
- 💻 **Repository**: [GitHub](https://github.com/AbubakrFlutter/simple_youtube_player)
- 🐛 **Issues**: [GitHub Issues](https://github.com/AbubakrFlutter/simple_youtube_player/issues)
- ⭐ **Like it?**: Give us a star on GitHub!

---

#   s i m p l e _ y o u t u b e _ p l a y e r  
 