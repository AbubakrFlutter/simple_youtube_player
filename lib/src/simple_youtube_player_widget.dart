import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'youtube_url_parser.dart';
import 'player_controller.dart';

/// A simple YouTube video player widget
class SimpleYoutubePlayer extends StatefulWidget {
  /// YouTube video URL (supports multiple formats)
  final String url;

  /// Width of the player
  final double width;

  /// Height of the player
  final double height;

  /// Auto play video on load
  final bool autoPlay;

  /// Mute video by default
  final bool mute;

  /// Loop the video
  final bool loop;

  /// Show player controls
  final bool showControls;

  /// Optional controller
  final SimpleYoutubePlayerController? controller;

  const SimpleYoutubePlayer({
    Key? key,
    required this.url,
    this.width = 300,
    this.height = 200,
    this.autoPlay = false,
    this.mute = false,
    this.loop = false,
    this.showControls = true,
    this.controller,
  }) : super(key: key);

  @override
  State<SimpleYoutubePlayer> createState() => _SimpleYoutubePlayerState();
}

class _SimpleYoutubePlayerState extends State<SimpleYoutubePlayer> {
  late WebViewController _webViewController;
  late SimpleYoutubePlayerController _controller;
  String? _videoId;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? SimpleYoutubePlayerController();
    _initializePlayer();
  }

  void _initializePlayer() {
    // Extract video ID
    _videoId = YoutubeUrlParser.extractVideoId(widget.url);

    if (_videoId == null) {
      setState(() {
        _error = 'Invalid YouTube URL';
      });
      _controller.setError('Invalid YouTube URL');
      return;
    }

    // Generate embed URL
    final embedUrl = YoutubeUrlParser.generateEmbedUrl(
      _videoId!,
      autoplay: widget.autoPlay,
      mute: widget.mute,
      loop: widget.loop,
      showControls: widget.showControls,
    );

    // Initialize WebView
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            _controller.setLoading(true);
          },
          onPageFinished: (String url) {
            _controller.setLoading(false);
          },
          onWebResourceError: (WebResourceError error) {
            _controller.setError('Failed to load video');
          },
        ),
      )
      ..loadRequest(Uri.parse(embedUrl));
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              if (_controller.isLoading) {
                return Container(
                  color: Colors.black87,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
