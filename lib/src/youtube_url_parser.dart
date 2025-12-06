/// Extracts YouTube video ID from various URL formats
class YoutubeUrlParser {
  /// Extract video ID from YouTube URL
  static String? extractVideoId(String url) {
    // Remove whitespace
    url = url.trim();

    // Pattern 1: youtube.com/watch?v=VIDEO_ID
    RegExp regExp1 = RegExp(
      r'youtube\.com/watch\?v=([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );

    // Pattern 2: youtu.be/VIDEO_ID
    RegExp regExp2 = RegExp(
      r'youtu\.be/([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );

    // Pattern 3: youtube.com/embed/VIDEO_ID
    RegExp regExp3 = RegExp(
      r'youtube\.com/embed/([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );

    // Pattern 4: m.youtube.com/watch?v=VIDEO_ID
    RegExp regExp4 = RegExp(
      r'm\.youtube\.com/watch\?v=([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );

    // Try each pattern
    var match = regExp1.firstMatch(url) ??
        regExp2.firstMatch(url) ??
        regExp3.firstMatch(url) ??
        regExp4.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }

    // If no pattern matches, check if it's already a video ID
    if (RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(url)) {
      return url;
    }

    return null;
  }

  /// Generate embed URL from video ID
  static String generateEmbedUrl(
    String videoId, {
    bool autoplay = false,
    bool mute = false,
    bool loop = false,
    bool showControls = true,
  }) {
    final params = <String>[];

    if (autoplay) params.add('autoplay=1');
    if (mute) params.add('mute=1');
    if (loop) params.add('loop=1&playlist=$videoId');
    if (!showControls) params.add('controls=0');

    final queryString = params.isEmpty ? '' : '?${params.join('&')}';

    return 'https://www.youtube.com/embed/$videoId$queryString';
  }
}
