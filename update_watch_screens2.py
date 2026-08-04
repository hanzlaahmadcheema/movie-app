import re

with open('lib/features/watch/watch_screens.dart', 'r') as f:
    content = f.read()

# Add imports if they don't exist
if 'import \'dart:io\';' not in content:
    content = content.replace("import 'dart:async';", "import 'dart:async';\nimport 'dart:io';\nimport 'package:flutter/foundation.dart';")

# Find the start of _WatchPageState
state_class_idx = content.find('class _WatchPageState extends State<_WatchPage> {')

# Replace initState ONLY ONCE
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
content = re.sub(init_state_pattern, init_state_replacement, content, count=1)

# Add dispose right before the FIRST build method after state_class_idx
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

# Find the first build method after the state class declaration
parts = content.split('class _WatchPageState extends State<_WatchPage> {', 1)
part1 = parts[0]
part2 = parts[1]
part2 = re.sub(build_pattern, dispose_replacement, part2, count=1)
content = part1 + 'class _WatchPageState extends State<_WatchPage> {' + part2

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
                                                  return const Center(child: Text('Error loading episodes'));
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

content = re.sub(mobile_layout_start, mobile_layout_replacement, content, count=1)

with open('lib/features/watch/watch_screens.dart', 'w') as f:
    f.write(content)

print("Updated watch_screens.dart correctly")
