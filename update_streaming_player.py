import re

with open('lib/features/streaming/presentation/streaming_player_screen.dart', 'r') as f:
    content = f.read()

imports_pattern = r"import 'package:flutter/material\.dart';"
if 'import \'dart:io\';' not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'dart:io';")

build_pattern = r'  @override\n  Widget build\(BuildContext context\) \{\n    final playerController = _playerController;\n    final candidates = playerController\?\.candidates \?\? const \[\];\n    final currentIndex = playerController\?\.currentIndex \?\? -1;\n\n    return Column\(\n      mainAxisSize: MainAxisSize\.min,\n      crossAxisAlignment: CrossAxisAlignment\.start,\n      children: \[\n        if \(context\.isMobile\)\n          SizedBox\(\n            height: 240,\n            width: double\.infinity,\n            child: _buildPlayerBody\(\),\n          \)\n        else\n          AspectRatio\(aspectRatio: 16 / 9, child: _buildPlayerBody\(\)\),\n        _FigmaServerSelector\(\n          candidates: candidates,\n          currentIndex: currentIndex,\n          enabled: playerController\?\.canUseControls \?\? false,\n          onSelected: \(index\) => playerController\?\.selectCandidate\(index\),\n        \),\n      \],\n    \);'

new_build = """  @override
  Widget build(BuildContext context) {
    final playerController = _playerController;
    final candidates = playerController?.candidates ?? const [];
    final currentIndex = playerController?.currentIndex ?? -1;

    final bool isMobileLandscape = !kIsWeb && (Platform.isAndroid || Platform.isIOS) && MediaQuery.orientationOf(context) == Orientation.landscape;

    if (isMobileLandscape) {
      return Stack(
        fit: StackFit.expand,
        children: [
          _buildPlayerBody(),
          if (candidates.isNotEmpty)
            Positioned(
              top: 16,
              right: 140, // Next to episodes button
              child: SafeArea(
                child: _ServerDropdownSelector(
                  candidates: candidates,
                  currentIndex: currentIndex,
                  enabled: playerController?.canUseControls ?? false,
                  onSelected: (index) => playerController?.selectCandidate(index),
                ),
              ),
            ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (context.isMobile)
          SizedBox(
            height: 240,
            width: double.infinity,
            child: _buildPlayerBody(),
          )
        else
          AspectRatio(aspectRatio: 16 / 9, child: _buildPlayerBody()),
        _FigmaServerSelector(
          candidates: candidates,
          currentIndex: currentIndex,
          enabled: playerController?.canUseControls ?? false,
          onSelected: (index) => playerController?.selectCandidate(index),
        ),
      ],
    );"""

content = re.sub(build_pattern, new_build, content)

dropdown_class = """
class _ServerDropdownSelector extends StatelessWidget {
  const _ServerDropdownSelector({
    required this.candidates,
    required this.currentIndex,
    required this.enabled,
    required this.onSelected,
  });

  final List<StreamingEmbedResult> candidates;
  final int currentIndex;
  final bool enabled;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    if (candidates.isEmpty) return const SizedBox();
    
    final active = currentIndex >= 0 && currentIndex < candidates.length ? candidates[currentIndex] : null;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: currentIndex >= 0 ? currentIndex : null,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          dropdownColor: Colors.black87,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          onChanged: enabled ? (int? newValue) {
            if (newValue != null) {
              onSelected(newValue);
            }
          } : null,
          items: List.generate(
            candidates.length,
            (index) => DropdownMenuItem<int>(
              value: index,
              child: Text(candidates[index].server.displayName),
            ),
          ),
        ),
      ),
    );
  }
}
"""

content += dropdown_class

with open('lib/features/streaming/presentation/streaming_player_screen.dart', 'w') as f:
    f.write(content)

print("Updated streaming_player_screen.dart")
