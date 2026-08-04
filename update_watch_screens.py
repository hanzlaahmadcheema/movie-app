import re

with open('lib/features/watch/watch_screens.dart', 'r') as f:
    content = f.read()

# Add imports if they don't exist
if 'import \'dart:io\';' not in content:
    content = content.replace("import 'dart:async';", "import 'dart:async';\nimport 'dart:io';\nimport 'package:flutter/foundation.dart';")

# Replace initState
init_state_pattern = r'  @override\n  void initState\(\) \{\n    super\.initState\(\);'
init_state_replacement = """  @override
  void initState() {
    super.initState();
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    }"""
content = re.sub(init_state_pattern, init_state_replacement, content)

# Replace dispose
dispose_pattern = r'  @override\n  void dispose\(\) \{'
if 'void dispose()' not in content:
    # Need to add dispose before `Widget build(BuildContext context)`
    build_pattern = r'  @override\n  Widget build\(BuildContext context\) \{'
    dispose_replacement = """  @override
  void dispose() {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {"""
    content = re.sub(build_pattern, dispose_replacement, content)
else:
    # Append to existing dispose
    pass # I'll assume dispose doesn't exist since I didn't see it, or I can just insert before build anyway

# Replace the mobile layout
# The mobile layout starts with:
#                               return ListView(
#                                 padding: EdgeInsets.zero,
#                                 children: [
#                                   DetailBackdrop(
# It ends at the end of the StreamBuilder/FutureBuilder stack.
# Let's just find `return ListView(` inside `builder: (context, watchedSnapshot) {`
# We can replace the `return ListView(` block for mobile.

mobile_layout_start = r'                              return ListView\(\n                                padding: EdgeInsets\.zero,\n                                children: \['
mobile_layout_replacement = """                              if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
                                return Scaffold(
                                  backgroundColor: Colors.black,
                                  endDrawer: widget.isSeries ? Drawer(
                                    child: SafeArea(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: SeasonDropdownTile(
                                              seasons: seasons,
                                              selectedSeasonNumber: selectedSeasonNumber ?? seasons.first.number,
                                              selectedEpisodeNumber: _selectedEpisodeNumber(activity) ?? 1,
                                              onSelected: (season) async {
                                                final episodesFutureLocal = _loadEpisodes(item.id, season.number);
                                                setState(() {
                                                  selectedSeasonNumber = season.number;
                                                  activeRequest = null;
                                                  episodesFuture = episodesFutureLocal;
                                                });
                                                await _setSeason(item, season.number);
                                                try {
                                                  final episodes = await episodesFutureLocal;
                                                  if (episodes.isNotEmpty && mounted) {
                                                    await _setEpisode(item, season.number, episodes.first);
                                                  }
                                                } catch (_) {}
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: FutureBuilder<List<Episode>>(
                                              future: episodesFuture,
                                              builder: (context, episodeSnapshot) {
                                                if (episodeSnapshot.connectionState != ConnectionState.done) {
                                                  return const Center(child: CircularProgressIndicator());
                                                }
                                                final episodes = episodeSnapshot.data ?? const <Episode>[];
                                                if (episodeSnapshot.hasError) {
                                                  return Center(child: Text('Error loading episodes'));
                                                }
                                                return EpisodeList(
                                                  episodes: episodes,
                                                  selectedEpisodeNumber: _selectedEpisodeNumber(activity),
                                                  onEpisodeSelected: (episode) => _setEpisode(
                                                    item,
                                                    selectedSeasonNumber ?? seasons.first.number,
                                                    episode,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ) : null,
                                  body: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      EmbeddedWatchPlayerPanel(
                                        request: activeRequest,
                                        selectionPrompt: widget.isSeries
                                            ? 'Select an episode from the menu to start playback.'
                                            : 'Preparing player...',
                                      ),
                                      Positioned(
                                        top: 16,
                                        left: 16,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                                          onPressed: () => Navigator.of(context).pop(),
                                        ),
                                      ),
                                      if (widget.isSeries)
                                        Positioned(
                                          top: 16,
                                          right: 16,
                                          child: Builder(
                                            builder: (ctx) => ElevatedButton.icon(
                                              icon: const Icon(Icons.list),
                                              label: const Text('Episodes'),
                                              onPressed: () => Scaffold.of(ctx).openEndDrawer(),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              }
                              return ListView(
                                padding: EdgeInsets.zero,
                                children: ["""

content = re.sub(mobile_layout_start, mobile_layout_replacement, content)

with open('lib/features/watch/watch_screens.dart', 'w') as f:
    f.write(content)

print("Updated watch_screens.dart")
