import os
import re

files = [
    "lib/features/auth/tv_login_screen.dart",
    "lib/features/details/tv/tv_movie_details_screen.dart",
    "lib/features/details/tv/tv_series_details_screen.dart",
    "lib/features/home/tv/tv_home_screen.dart",
    "lib/features/jellyfin/player/widgets/native_player_loading_state.dart",
    "lib/features/search/tv/tv_search_screen.dart",
    "lib/features/settings/tv/tv_jellyfin_settings_screen.dart",
    "lib/features/settings/tv/tv_settings_screen.dart",
    "lib/features/watch/watch_screens.dart",
    "lib/main.dart",
]

for f in files:
    path = os.path.join("/home/hanzlaahmad/PersonalProjects/movie-app", f)
    if not os.path.exists(path):
        continue
    with open(path, "r") as file:
        content = file.read()
    
    content = re.sub(r'\.withOpacity\((.*?)\)', r'.withValues(alpha: \1)', content)
    
    content = re.sub(r"import 'dart:ui';\n", "", content)
    content = re.sub(r"import 'dart:io';\n", "", content)
    content = re.sub(r"import 'package:flutter/foundation\.dart';\n", "", content)
    content = re.sub(r"import '../../../core/responsive/adaptive_container\.dart';\n", "", content)
    content = re.sub(r"import '../../../core/services/user_activity_repository\.dart';\n", "", content)
    content = re.sub(r"import '../../../widgets/app_chrome\.dart';\n", "", content)
    content = re.sub(r"import '../../../widgets/buttons\.dart';\n", "", content)
    content = re.sub(r"import '../../movies/widgets/movie_card\.dart';\n", "", content)
    content = re.sub(r"import '../../../widgets/firebase_posters\.dart';\n", "", content)
    
    # For settings screens, we might still need some imports, but the warning said they are unused.
    # Let's be careful.
    if f == "lib/features/settings/tv/tv_jellyfin_settings_screen.dart":
        content = re.sub(r"import '../../../app/app_theme\.dart';\n", "", content)
        content = re.sub(r"import '../../../widgets/state_views\.dart';\n", "", content)
    if f == "lib/features/settings/tv/tv_settings_screen.dart":
        content = re.sub(r"import '../../../app/app_theme\.dart';\n", "", content)
        
    if f == "lib/features/home/tv/tv_home_screen.dart":
        content = re.sub(r"import '../../../core/models/movie_item\.dart';\n", "", content, count=1)
        content = re.sub(r"import '../../../core/services/tmdb_repository\.dart';\n", "", content, count=1)
        content = re.sub(r"const _FocusablePoster\(\{", "const _FocusablePoster({super.key, ", content)
        content = re.sub(r"const _ContinueWatchingRow\(\{", "const _ContinueWatchingRow({super.key, ", content)
        content = re.sub(r"const _TopHeroRow\(\{", "const _TopHeroRow({super.key, ", content)
        content = re.sub(r"const _CategoryRow\(\{", "const _CategoryRow({super.key, ", content)
        content = re.sub(r"const _PosterItem\(\{", "const _PosterItem({super.key, ", content)
        
    if f == "lib/features/details/tv/tv_movie_details_screen.dart":
        content = re.sub(r"          final item = detail\.item;\n", "", content)
        
    if f == "lib/features/watch/watch_screens.dart":
        content = re.sub(r"location: providerUrl,", "uri: Uri.parse(providerUrl),", content)
        
    with open(path, "w") as file:
        file.write(content)
