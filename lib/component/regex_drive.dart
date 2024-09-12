String regexGdriveLink(String url, String key) {
  if (url.contains('drive.google.com')) {
    final regExp = RegExp(r'/d/([a-zA-Z0-9_-]+)');
    final match = regExp.firstMatch(url);
    return 'https://www.googleapis.com/drive/v3/files/${match!.group(1)}?alt=media&key=$key';
  } else if (url.contains('www.googleapis.com')) {
    final regExp = RegExp(r'files\/([a-zA-Z0-9_-]+)\?');
    final match = regExp.firstMatch(url);
    return "https://www.googleapis.com/drive/v3/files/${match!.group(1)}?alt=media&key=$key";
  } else {
    return url;
  }
}