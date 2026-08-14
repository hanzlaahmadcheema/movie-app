// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

void saveCsvFile(String filename, String content) {
  final bytes = Uri.encodeComponent(content);
  final anchor = html.AnchorElement(href: 'data:text/csv;charset=utf-8,$bytes')
    ..setAttribute('download', filename)
    ..style.display = 'none';
  html.document.body?.children.add(anchor);
  anchor.click();
  anchor.remove();
}
