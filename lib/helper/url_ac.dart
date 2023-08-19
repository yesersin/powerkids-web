import 'package:url_launcher/url_launcher.dart';

void urlAc({required String url}) {
  final Uri url2 = Uri.parse(url);
  launchUrl(url2, mode: LaunchMode.externalApplication);
}
