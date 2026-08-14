import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AdminPaths {
  static const appConfigMain = 'appConfig/main';
  static const providers = 'providers';
  static const banners = 'banners';
  static const featuredContent = 'featuredContent';
  static const notices = 'notices';
  static const playbackLogs = 'playbackLogs';
  static const contentRequests = 'contentRequests';
}

enum AdminContentType { movie, series }

enum BannerActionType { watch, details }

enum NoticeType { info, warning, danger, success }

enum NoticeTarget { all, admins, users }

enum ContentRequestType {
  requestMovie,
  requestSeries,
  missingEpisode,
  videoNotPlaying,
  subtitleIssue,
  wrongContent,
  other,
}

enum ContentRequestStatus { pending, inProgress, resolved, rejected }

DateTime? _toDate(Object? value) {
  if (value is Timestamp) {
    return value.toDate();
  }
  return null;
}

int? _toInt(Object? value) {
  return switch (value) {
    int number => number,
    num number => number.toInt(),
    _ => int.tryParse(value?.toString() ?? ''),
  };
}

bool _isActiveWindow(DateTime now, DateTime? startAt, DateTime? endAt) {
  if (startAt != null && now.isBefore(startAt)) {
    return false;
  }
  if (endAt != null && now.isAfter(endAt)) {
    return false;
  }
  return true;
}

class AdminBanner {
  const AdminBanner({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tmdbId,
    required this.contentType,
    required this.buttonText,
    required this.buttonAction,
    required this.order,
    required this.enabled,
    this.imageUrl,
    this.startAt,
    this.endAt,
  });

  final String id;
  final String title;
  final String subtitle;
  final int tmdbId;
  final AdminContentType contentType;
  final String? imageUrl;
  final String buttonText;
  final BannerActionType buttonAction;
  final int order;
  final bool enabled;
  final DateTime? startAt;
  final DateTime? endAt;

  bool get isCurrentlyActive =>
      enabled && _isActiveWindow(DateTime.now(), startAt, endAt);

  factory AdminBanner.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return AdminBanner(
      id: doc.id,
      title: (data['title'] ?? '').toString(),
      subtitle: (data['subtitle'] ?? '').toString(),
      tmdbId: _toInt(data['tmdbId']) ?? 0,
      contentType: (data['contentType'] ?? 'movie') == 'series'
          ? AdminContentType.series
          : AdminContentType.movie,
      imageUrl: data['imageUrl']?.toString(),
      buttonText: (data['buttonText'] ?? 'Watch Now').toString(),
      buttonAction: (data['buttonAction'] ?? 'watch') == 'details'
          ? BannerActionType.details
          : BannerActionType.watch,
      order: _toInt(data['order']) ?? 0,
      enabled: data['enabled'] == true,
      startAt: _toDate(data['startAt']),
      endAt: _toDate(data['endAt']),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title.trim(),
      'subtitle': subtitle.trim(),
      'tmdbId': tmdbId,
      'contentType': contentType == AdminContentType.series
          ? 'series'
          : 'movie',
      'imageUrl': imageUrl?.trim().isNotEmpty == true ? imageUrl!.trim() : null,
      'buttonText': buttonText.trim(),
      'buttonAction': buttonAction == BannerActionType.details
          ? 'details'
          : 'watch',
      'order': order,
      'enabled': enabled,
      'startAt': startAt == null ? null : Timestamp.fromDate(startAt!),
      'endAt': endAt == null ? null : Timestamp.fromDate(endAt!),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class FeaturedContentConfig {
  const FeaturedContentConfig({
    required this.id,
    required this.tmdbId,
    required this.contentType,
    required this.section,
    required this.order,
    required this.enabled,
    this.titleOverride,
    this.subtitle,
  });

  final String id;
  final int tmdbId;
  final AdminContentType contentType;
  final String section;
  final String? titleOverride;
  final String? subtitle;
  final int order;
  final bool enabled;

  factory FeaturedContentConfig.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const {};
    return FeaturedContentConfig(
      id: doc.id,
      tmdbId: _toInt(data['tmdbId']) ?? 0,
      contentType: (data['contentType'] ?? 'movie') == 'series'
          ? AdminContentType.series
          : AdminContentType.movie,
      section: (data['section'] ?? 'featured').toString(),
      titleOverride: data['titleOverride']?.toString(),
      subtitle: data['subtitle']?.toString(),
      order: _toInt(data['order']) ?? 0,
      enabled: data['enabled'] == true,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'tmdbId': tmdbId,
      'contentType': contentType == AdminContentType.series
          ? 'series'
          : 'movie',
      'section': section.trim(),
      'titleOverride': titleOverride?.trim().isNotEmpty == true
          ? titleOverride!.trim()
          : null,
      'subtitle': subtitle?.trim().isNotEmpty == true ? subtitle!.trim() : null,
      'order': order,
      'enabled': enabled,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class AdminNotice {
  const AdminNotice({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.target,
    required this.enabled,
    this.startAt,
    this.endAt,
  });

  final String id;
  final String title;
  final String message;
  final NoticeType type;
  final NoticeTarget target;
  final bool enabled;
  final DateTime? startAt;
  final DateTime? endAt;

  bool get isCurrentlyActive =>
      enabled && _isActiveWindow(DateTime.now(), startAt, endAt);

  factory AdminNotice.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return AdminNotice(
      id: doc.id,
      title: (data['title'] ?? '').toString(),
      message: (data['message'] ?? '').toString(),
      type: switch ((data['type'] ?? 'info').toString()) {
        'warning' => NoticeType.warning,
        'danger' => NoticeType.danger,
        'success' => NoticeType.success,
        _ => NoticeType.info,
      },
      target: switch ((data['target'] ?? 'all').toString()) {
        'admins' => NoticeTarget.admins,
        'users' => NoticeTarget.users,
        _ => NoticeTarget.all,
      },
      enabled: data['enabled'] == true,
      startAt: _toDate(data['startAt']),
      endAt: _toDate(data['endAt']),
    );
  }

  Map<String, Object?> toJson() {
    final data = <String, Object?>{
      'title': title.trim(),
      'message': message.trim(),
      'type': type.name,
      'target': target.name,
      'enabled': enabled,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (startAt != null) {
      data['startAt'] = Timestamp.fromDate(startAt!);
    }
    if (endAt != null) {
      data['endAt'] = Timestamp.fromDate(endAt!);
    }
    return data;
  }
}

class ProviderConfigRecord {
  const ProviderConfigRecord({
    required this.id,
    required this.providerId,
    required this.displayName,
    required this.enabled,
    required this.priority,
    required this.maintenanceMode,
    required this.fallbackAllowed,
    this.statusMessage,
  });

  final String id;
  final String providerId;
  final String displayName;
  final bool enabled;
  final int priority;
  final bool maintenanceMode;
  final bool fallbackAllowed;
  final String? statusMessage;

  factory ProviderConfigRecord.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const {};
    return ProviderConfigRecord(
      id: doc.id,
      providerId: (data['providerId'] ?? doc.id).toString(),
      displayName: (data['displayName'] ?? doc.id).toString(),
      enabled: data['enabled'] != false,
      priority: _toInt(data['priority']) ?? 0,
      maintenanceMode: data['maintenanceMode'] == true,
      fallbackAllowed: data['fallbackAllowed'] != false,
      statusMessage: data['statusMessage']?.toString(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'providerId': providerId.trim(),
      'displayName': displayName.trim(),
      'enabled': enabled,
      'priority': priority,
      'maintenanceMode': maintenanceMode,
      'statusMessage': statusMessage?.trim().isNotEmpty == true
          ? statusMessage!.trim()
          : null,
      'fallbackAllowed': fallbackAllowed,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class AppRemoteConfig {
  const AppRemoteConfig({
    this.maintenanceMode = false,
    this.maintenanceMessage = '',
    this.minimumAppVersion = '',
    this.forceUpdateEnabled = false,
    this.forceUpdateMessage = '',
    this.signupEnabled = true,
    this.googleLoginEnabled = true,
    this.phoneLoginEnabled = true,
    this.defaultPlaybackMode = 'auto',
    this.contactEmail = '',
    this.supportWhatsapp = '',
    this.privacyPolicyUrl = '',
    this.termsUrl = '',
    this.defaultJellyfinServerUrl = '',
    this.jellyfinEnabled = true,
    this.jellyfinNativeEnabled = true,
    this.jellyfinWebEnabled = true,
    this.tailscaleRequiredMessage = '',
    this.jellyfinSetupGuide = '',
    this.paymentWhatsappLink = '',
  });

  final bool maintenanceMode;
  final String maintenanceMessage;
  final String minimumAppVersion;
  final bool forceUpdateEnabled;
  final String forceUpdateMessage;
  final bool signupEnabled;
  final bool googleLoginEnabled;
  final bool phoneLoginEnabled;
  final String defaultPlaybackMode;
  final String contactEmail;
  final String supportWhatsapp;
  final String privacyPolicyUrl;
  final String termsUrl;
  final String defaultJellyfinServerUrl;
  final bool jellyfinEnabled;
  final bool jellyfinNativeEnabled;
  final bool jellyfinWebEnabled;
  final String tailscaleRequiredMessage;
  final String jellyfinSetupGuide;
  final String paymentWhatsappLink;

  factory AppRemoteConfig.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? const {};
    return AppRemoteConfig(
      maintenanceMode: data['maintenanceMode'] == true,
      maintenanceMessage: (data['maintenanceMessage'] ?? '').toString(),
      minimumAppVersion: (data['minimumAppVersion'] ?? '').toString(),
      forceUpdateEnabled: data['forceUpdateEnabled'] == true,
      forceUpdateMessage: (data['forceUpdateMessage'] ?? '').toString(),
      signupEnabled: data['signupEnabled'] != false,
      googleLoginEnabled: data['googleLoginEnabled'] != false,
      phoneLoginEnabled: data['phoneLoginEnabled'] != false,
      defaultPlaybackMode: (data['defaultPlaybackMode'] ?? 'auto').toString(),
      contactEmail: (data['contactEmail'] ?? '').toString(),
      supportWhatsapp: (data['supportWhatsapp'] ?? '').toString(),
      privacyPolicyUrl: (data['privacyPolicyUrl'] ?? '').toString(),
      termsUrl: (data['termsUrl'] ?? '').toString(),
      defaultJellyfinServerUrl: (data['defaultServerUrl'] ?? '').toString(),
      jellyfinEnabled: data['jellyfinEnabled'] != false,
      jellyfinNativeEnabled: data['jellyfinNativeEnabled'] != false,
      jellyfinWebEnabled: data['jellyfinWebEnabled'] != false,
      tailscaleRequiredMessage: (data['tailscaleRequiredMessage'] ?? '')
          .toString(),
      jellyfinSetupGuide: (data['jellyfinSetupGuide'] ?? '').toString(),
      paymentWhatsappLink: (data['paymentWhatsappLink'] ?? '').toString(),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'maintenanceMode': maintenanceMode,
      'maintenanceMessage': maintenanceMessage.trim(),
      'minimumAppVersion': minimumAppVersion.trim(),
      'forceUpdateEnabled': forceUpdateEnabled,
      'forceUpdateMessage': forceUpdateMessage.trim(),
      'signupEnabled': signupEnabled,
      'googleLoginEnabled': googleLoginEnabled,
      'phoneLoginEnabled': phoneLoginEnabled,
      'defaultPlaybackMode': defaultPlaybackMode.trim(),
      'contactEmail': contactEmail.trim(),
      'supportWhatsapp': supportWhatsapp.trim(),
      'privacyPolicyUrl': privacyPolicyUrl.trim(),
      'termsUrl': termsUrl.trim(),
      'defaultServerUrl': defaultJellyfinServerUrl.trim(),
      'jellyfinEnabled': jellyfinEnabled,
      'jellyfinNativeEnabled': jellyfinNativeEnabled,
      'jellyfinWebEnabled': jellyfinWebEnabled,
      'tailscaleRequiredMessage': tailscaleRequiredMessage.trim(),
      'jellyfinSetupGuide': jellyfinSetupGuide.trim(),
      'paymentWhatsappLink': paymentWhatsappLink.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class ContentRequestRecord {
  const ContentRequestRecord({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.type,
    required this.title,
    required this.message,
    required this.status,
    this.tmdbId,
    this.contentType,
    this.seasonNumber,
    this.episodeNumber,
    this.adminNote,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String userId;
  final String userEmail;
  final ContentRequestType type;
  final String title;
  final int? tmdbId;
  final AdminContentType? contentType;
  final int? seasonNumber;
  final int? episodeNumber;
  final String message;
  final ContentRequestStatus status;
  final String? adminNote;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ContentRequestRecord.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const {};
    return ContentRequestRecord(
      id: doc.id,
      userId: (data['userId'] ?? '').toString(),
      userEmail: (data['userEmail'] ?? '').toString(),
      type: switch ((data['type'] ?? 'other').toString()) {
        'request_movie' => ContentRequestType.requestMovie,
        'request_series' => ContentRequestType.requestSeries,
        'missing_episode' => ContentRequestType.missingEpisode,
        'video_not_playing' => ContentRequestType.videoNotPlaying,
        'subtitle_issue' => ContentRequestType.subtitleIssue,
        'wrong_content' => ContentRequestType.wrongContent,
        _ => ContentRequestType.other,
      },
      title: (data['title'] ?? '').toString(),
      tmdbId: _toInt(data['tmdbId']),
      contentType: switch (data['contentType']) {
        'movie' => AdminContentType.movie,
        'series' => AdminContentType.series,
        _ => null,
      },
      seasonNumber: _toInt(data['seasonNumber']),
      episodeNumber: _toInt(data['episodeNumber']),
      message: (data['message'] ?? '').toString(),
      status: switch ((data['status'] ?? 'pending').toString()) {
        'in_progress' => ContentRequestStatus.inProgress,
        'resolved' => ContentRequestStatus.resolved,
        'rejected' => ContentRequestStatus.rejected,
        _ => ContentRequestStatus.pending,
      },
      adminNote: data['adminNote']?.toString(),
      createdAt: _toDate(data['createdAt']),
      updatedAt: _toDate(data['updatedAt']),
    );
  }

  Map<String, Object?> toCreateJson() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'type': switch (type) {
        ContentRequestType.requestMovie => 'request_movie',
        ContentRequestType.requestSeries => 'request_series',
        ContentRequestType.missingEpisode => 'missing_episode',
        ContentRequestType.videoNotPlaying => 'video_not_playing',
        ContentRequestType.subtitleIssue => 'subtitle_issue',
        ContentRequestType.wrongContent => 'wrong_content',
        ContentRequestType.other => 'other',
      },
      'title': title.trim(),
      if (tmdbId != null) 'tmdbId': tmdbId,
      if (contentType != null)
        'contentType': contentType == AdminContentType.series
            ? 'series'
            : 'movie',
      if (seasonNumber != null) 'seasonNumber': seasonNumber,
      if (episodeNumber != null) 'episodeNumber': episodeNumber,
      'message': message.trim(),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}

class PlaybackLogRecord {
  const PlaybackLogRecord({
    required this.id,
    required this.userId,
    required this.contentType,
    required this.providerId,
    required this.playbackMode,
    required this.errorType,
    required this.errorMessageSafe,
    required this.devicePlatform,
    required this.appVersion,
    this.tmdbId,
    this.seasonNumber,
    this.episodeNumber,
    this.createdAt,
  });

  final String id;
  final String userId;
  final String contentType;
  final String providerId;
  final String playbackMode;
  final String errorType;
  final String errorMessageSafe;
  final String devicePlatform;
  final String appVersion;
  final int? tmdbId;
  final int? seasonNumber;
  final int? episodeNumber;
  final DateTime? createdAt;

  factory PlaybackLogRecord.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? const {};
    return PlaybackLogRecord(
      id: doc.id,
      userId: (data['userId'] ?? '').toString(),
      contentType: (data['contentType'] ?? '').toString(),
      providerId: (data['providerId'] ?? '').toString(),
      playbackMode: (data['playbackMode'] ?? '').toString(),
      errorType: (data['errorType'] ?? '').toString(),
      errorMessageSafe: (data['errorMessageSafe'] ?? '').toString(),
      devicePlatform: (data['devicePlatform'] ?? '').toString(),
      appVersion: (data['appVersion'] ?? '').toString(),
      tmdbId: _toInt(data['tmdbId']),
      seasonNumber: _toInt(data['seasonNumber']),
      episodeNumber: _toInt(data['episodeNumber']),
      createdAt: _toDate(data['createdAt']),
    );
  }
}

class AdminDashboardStats {
  const AdminDashboardStats({
    required this.totalUsers,
    required this.activeUsers,
    required this.newUsersToday,
    required this.watchlistRecords,
    required this.continueWatchingRecords,
    required this.playbackErrors,
    required this.providerStatuses,
    required this.jellyfinStatus,
    required this.latestReports,
  });

  final String totalUsers;
  final String activeUsers;
  final String newUsersToday;
  final String watchlistRecords;
  final String continueWatchingRecords;
  final String playbackErrors;
  final String providerStatuses;
  final String jellyfinStatus;
  final String latestReports;
}

class AdminRepository {
  AdminRepository._({
    FirebaseFirestore? firestore,
    this.appConfigLoader,
    this.providersLoader,
    this.bannersLoader,
    this.featuredLoader,
    this.noticesLoader,
    this.usersSnapshotLoader,
    this.logsSnapshotLoader,
    this.requestsSnapshotLoader,
    this.providerSnapshotLoader,
    this.userSubcollectionLoader,
  }) : _firestoreOverride = firestore;

  static final AdminRepository instance = AdminRepository._();

  factory AdminRepository.test({
    FirebaseFirestore? firestore,
    Future<DocumentSnapshot<Map<String, dynamic>>> Function()? appConfigLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()? providersLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()? bannersLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()? featuredLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()? noticesLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()? usersSnapshotLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()? logsSnapshotLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()?
    requestsSnapshotLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function()?
    providerSnapshotLoader,
    Future<QuerySnapshot<Map<String, dynamic>>> Function(
      DocumentReference<Map<String, dynamic>> userRef,
      String subcollection,
    )?
    userSubcollectionLoader,
  }) {
    return AdminRepository._(
      firestore: firestore,
      appConfigLoader: appConfigLoader,
      providersLoader: providersLoader,
      bannersLoader: bannersLoader,
      featuredLoader: featuredLoader,
      noticesLoader: noticesLoader,
      usersSnapshotLoader: usersSnapshotLoader,
      logsSnapshotLoader: logsSnapshotLoader,
      requestsSnapshotLoader: requestsSnapshotLoader,
      providerSnapshotLoader: providerSnapshotLoader,
      userSubcollectionLoader: userSubcollectionLoader,
    );
  }

  final FirebaseFirestore? _firestoreOverride;
  final Future<DocumentSnapshot<Map<String, dynamic>>> Function()?
  appConfigLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()? providersLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()? bannersLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()? featuredLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()? noticesLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()?
  usersSnapshotLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()?
  logsSnapshotLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()?
  requestsSnapshotLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function()?
  providerSnapshotLoader;
  final Future<QuerySnapshot<Map<String, dynamic>>> Function(
    DocumentReference<Map<String, dynamic>> userRef,
    String subcollection,
  )?
  userSubcollectionLoader;

  static const Set<String> _safeFirestoreCodes = {
    'permission-denied',
    'not-found',
    'unavailable',
    'failed-precondition',
  };

  static const List<ProviderConfigRecord> defaultProviderConfigs = [
    ProviderConfigRecord(
      id: 'jellyfin_native',
      providerId: 'jellyfin_native',
      displayName: 'Jellyfin Native',
      enabled: false,
      priority: -101,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'jellyfin_web',
      providerId: 'jellyfin_web',
      displayName: 'Jellyfin Web',
      enabled: false,
      priority: -100,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'hindi_player',
      providerId: 'hindi_player',
      displayName: 'Hindi Player',
      enabled: false,
      priority: 500,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'videasy',
      providerId: 'videasy',
      displayName: 'Videasy',
      enabled: false,
      priority: 200,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'streamvault',
      providerId: 'streamvault',
      displayName: 'StreamVault',
      enabled: false,
      priority: 300,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: '111movies',
      providerId: '111movies',
      displayName: '111Movies',
      enabled: false,
      priority: 400,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'vidking',
      providerId: 'vidking',
      displayName: 'VidKing',
      enabled: false,
      priority: 450,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'vidsrc',
      providerId: 'vidsrc',
      displayName: 'VidSrc',
      enabled: false,
      priority: 0,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: '2embed',
      providerId: '2embed',
      displayName: '2Embed',
      enabled: false,
      priority: 100,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
    ProviderConfigRecord(
      id: 'nxsha',
      providerId: 'nxsha',
      displayName: 'HA Player',
      enabled: true,
      priority: -10,
      maintenanceMode: false,
      fallbackAllowed: true,
    ),
  ];

  FirebaseFirestore? get _firestore {
    if (_firestoreOverride != null) {
      return _firestoreOverride;
    }
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseFirestore.instance;
  }

  CollectionReference<Map<String, dynamic>> _collection(String path) {
    return _firestore!.collection(path);
  }

  DocumentReference<Map<String, dynamic>> get _appConfigDoc =>
      _firestore!.doc(AdminPaths.appConfigMain);

  AppRemoteConfig? _cachedConfig;
  DateTime? _configFetchedTime;

  Stream<AppRemoteConfig> watchPublicAppConfig() async* {
    final firestore = _firestore;
    if (firestore == null && appConfigLoader == null) {
      yield const AppRemoteConfig();
      return;
    }
    try {
      await for (final snapshot in _appConfigDoc.snapshots()) {
        final config = AppRemoteConfig.fromDoc(snapshot);
        _cachedConfig = config;
        _configFetchedTime = DateTime.now();
        yield config;
      }
    } catch (error) {
      _logFirestoreFallback('watchPublicAppConfig', error);
      yield _cachedConfig ?? const AppRemoteConfig();
    }
  }

  Future<AppRemoteConfig> loadPublicAppConfig({bool forceRefresh = false}) async {
    if (!forceRefresh &&
        _cachedConfig != null &&
        _configFetchedTime != null &&
        DateTime.now().difference(_configFetchedTime!) < const Duration(minutes: 10)) {
      return _cachedConfig!;
    }
    final firestore = _firestore;
    if (firestore == null && appConfigLoader == null) {
      return const AppRemoteConfig();
    }
    try {
      final snapshot =
          await appConfigLoader?.call() ?? await _appConfigDoc.get();
      final config = AppRemoteConfig.fromDoc(snapshot);
      _cachedConfig = config;
      _configFetchedTime = DateTime.now();
      return config;
    } catch (error) {
      _logFirestoreFallback('loadPublicAppConfig', error);
      return _cachedConfig ?? const AppRemoteConfig();
    }
  }

  Stream<List<AdminBanner>> watchBanners() async* {
    final firestore = _firestore;
    if (firestore == null) {
      yield const <AdminBanner>[];
      return;
    }
    try {
      await for (final snapshot in _collection(
        AdminPaths.banners,
      ).orderBy('order').snapshots()) {
        yield snapshot.docs.map(AdminBanner.fromDoc).toList(growable: false);
      }
    } catch (error) {
      _logFirestoreFallback('watchBanners', error);
      yield const <AdminBanner>[];
    }
  }

  Future<List<AdminBanner>> loadActiveBanners() async {
    final firestore = _firestore;
    if (firestore == null && bannersLoader == null) return const [];
    try {
      final snapshot =
          await bannersLoader?.call() ??
          await _collection(AdminPaths.banners).orderBy('order').get();
      return snapshot.docs
          .map(AdminBanner.fromDoc)
          .where((banner) => banner.isCurrentlyActive && banner.tmdbId > 0)
          .toList(growable: false);
    } catch (error) {
      _logFirestoreFallback('loadActiveBanners', error);
      return const [];
    }
  }

  Future<void> saveBanner({String? id, required AdminBanner banner}) async {
    final doc = id == null || id.trim().isEmpty
        ? _collection(AdminPaths.banners).doc()
        : _collection(AdminPaths.banners).doc(id);
    await doc.set({
      ...banner.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> deleteBanner(String id) =>
      _collection(AdminPaths.banners).doc(id).delete();

  Stream<List<FeaturedContentConfig>> watchFeaturedContent() async* {
    final firestore = _firestore;
    if (firestore == null) {
      yield const <FeaturedContentConfig>[];
      return;
    }
    try {
      await for (final snapshot in _collection(
        AdminPaths.featuredContent,
      ).orderBy('section').orderBy('order').snapshots()) {
        yield snapshot.docs
            .map(FeaturedContentConfig.fromDoc)
            .toList(growable: false);
      }
    } catch (error) {
      _logFirestoreFallback('watchFeaturedContent', error);
      yield const <FeaturedContentConfig>[];
    }
  }

  Future<List<FeaturedContentConfig>> loadEnabledFeaturedContent() async {
    final firestore = _firestore;
    if (firestore == null && featuredLoader == null) return const [];
    try {
      final snapshot =
          await featuredLoader?.call() ??
          await _collection(
            AdminPaths.featuredContent,
          ).orderBy('section').orderBy('order').get();
      return snapshot.docs
          .map(FeaturedContentConfig.fromDoc)
          .where((item) => item.enabled && item.tmdbId > 0)
          .toList(growable: false);
    } catch (error) {
      _logFirestoreFallback('loadEnabledFeaturedContent', error);
      return const [];
    }
  }

  Future<void> saveFeaturedContent({
    String? id,
    required FeaturedContentConfig item,
  }) async {
    final doc = id == null || id.trim().isEmpty
        ? _collection(AdminPaths.featuredContent).doc()
        : _collection(AdminPaths.featuredContent).doc(id);
    await doc.set({
      ...item.toJson(),
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> deleteFeaturedContent(String id) =>
      _collection(AdminPaths.featuredContent).doc(id).delete();

  Stream<List<AdminNotice>> watchNotices() async* {
    final firestore = _firestore;
    if (firestore == null) {
      yield const <AdminNotice>[];
      return;
    }
    try {
      await for (final snapshot in _collection(
        AdminPaths.notices,
      ).orderBy('updatedAt', descending: true).snapshots()) {
        yield snapshot.docs.map(AdminNotice.fromDoc).toList(growable: false);
      }
    } catch (error) {
      _logFirestoreFallback('watchNotices', error);
      yield const <AdminNotice>[];
    }
  }

  Future<List<AdminNotice>> loadActiveNotices() async {
    final firestore = _firestore;
    if (firestore == null && noticesLoader == null) return const [];
    try {
      final snapshot =
          await noticesLoader?.call() ??
          await _collection(
            AdminPaths.notices,
          ).orderBy('updatedAt', descending: true).get();
      return snapshot.docs
          .map(AdminNotice.fromDoc)
          .where((notice) => notice.isCurrentlyActive)
          .toList(growable: false);
    } catch (error) {
      _logFirestoreFallback('loadActiveNotices', error);
      return const [];
    }
  }

  Future<void> saveNotice({String? id, required AdminNotice notice}) async {
    final isNew = id == null || id.trim().isEmpty;
    final doc = isNew
        ? _collection(AdminPaths.notices).doc()
        : _collection(AdminPaths.notices).doc(id);
    final data = notice.toJson();
    if (isNew) {
      data['createdAt'] = FieldValue.serverTimestamp();
    }
    await doc.set(data, SetOptions(merge: true));
  }

  Future<void> deleteNotice(String id) =>
      _collection(AdminPaths.notices).doc(id).delete();

  Stream<List<ProviderConfigRecord>> watchProviders() async* {
    final firestore = _firestore;
    if (firestore == null) {
      yield defaultProviderConfigs;
      return;
    }
    try {
      await for (final snapshot in _collection(
        AdminPaths.providers,
      ).orderBy('priority').snapshots()) {
        final providers = snapshot.docs
            .map(ProviderConfigRecord.fromDoc)
            .toList(growable: false);
        yield _mergeDefaultProviderConfigs(providers);
      }
    } catch (error) {
      _logFirestoreFallback('watchProviders', error);
      yield defaultProviderConfigs;
    }
  }

  Future<List<ProviderConfigRecord>> loadProviders() async {
    final firestore = _firestore;
    if (firestore == null &&
        providersLoader == null &&
        providerSnapshotLoader == null) {
      return defaultProviderConfigs;
    }
    try {
      final snapshot =
          await providersLoader?.call() ??
          await (providerSnapshotLoader?.call() ??
              _collection(AdminPaths.providers).orderBy('priority').get());
      final providers = snapshot.docs
          .map(ProviderConfigRecord.fromDoc)
          .toList(growable: false);
      return _mergeDefaultProviderConfigs(providers);
    } catch (error) {
      _logFirestoreFallback('loadProviders', error);
      return defaultProviderConfigs;
    }
  }

  Future<void> saveProviderConfig(ProviderConfigRecord config) async {
    await _collection(
      AdminPaths.providers,
    ).doc(config.providerId).set(config.toJson(), SetOptions(merge: true));
  }

  static List<ProviderConfigRecord> _mergeDefaultProviderConfigs(
    List<ProviderConfigRecord> providers,
  ) {
    if (providers.isEmpty) {
      return defaultProviderConfigs;
    }
    final byProvider = {
      for (final provider in defaultProviderConfigs)
        provider.providerId: provider,
      for (final provider in providers) provider.providerId: provider,
    };
    final merged = byProvider.values.toList(growable: false);
    merged.sort((a, b) => a.priority.compareTo(b.priority));
    return List.unmodifiable(merged);
  }

  Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>> watchUsers() {
    final firestore = _firestore;
    if (firestore == null) {
      return Stream<List<QueryDocumentSnapshot<Map<String, dynamic>>>>.value(
        const [],
      );
    }
    return firestore
        .collection('users')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }

  Stream<List<ContentRequestRecord>> watchContentRequests() {
    final firestore = _firestore;
    if (firestore == null) {
      return Stream<List<ContentRequestRecord>>.value(const []);
    }
    return _collection(AdminPaths.contentRequests)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map(ContentRequestRecord.fromDoc).toList(),
        );
  }

  Future<void> createContentRequest(ContentRequestRecord record) {
    return _collection(AdminPaths.contentRequests).add(record.toCreateJson());
  }

  Future<void> updateContentRequestStatus({
    required String id,
    required ContentRequestStatus status,
    String? adminNote,
  }) {
    return _collection(AdminPaths.contentRequests).doc(id).set({
      'status': switch (status) {
        ContentRequestStatus.pending => 'pending',
        ContentRequestStatus.inProgress => 'in_progress',
        ContentRequestStatus.resolved => 'resolved',
        ContentRequestStatus.rejected => 'rejected',
      },
      'adminNote': adminNote?.trim().isNotEmpty == true
          ? adminNote!.trim()
          : null,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Stream<List<PlaybackLogRecord>> watchPlaybackLogs() {
    final firestore = _firestore;
    if (firestore == null) {
      return Stream<List<PlaybackLogRecord>>.value(const []);
    }
    return _collection(AdminPaths.playbackLogs)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(PlaybackLogRecord.fromDoc).toList(),
        );
  }

  Future<void> logPlaybackError({
    required User? user,
    required String contentType,
    required String providerId,
    required String playbackMode,
    required String errorType,
    required String errorMessageSafe,
    required String devicePlatform,
    required String appVersion,
    int? tmdbId,
    int? seasonNumber,
    int? episodeNumber,
  }) async {
    final firestore = _firestore;
    if (firestore == null || user == null) {
      return;
    }
    await _collection(AdminPaths.playbackLogs).add({
      'userId': user.uid,
      'contentType': contentType,
      'tmdbId': tmdbId,
      'seasonNumber': seasonNumber,
      'episodeNumber': episodeNumber,
      'providerId': providerId.trim(),
      'playbackMode': playbackMode.trim(),
      'errorType': errorType.trim(),
      'errorMessageSafe': errorMessageSafe.trim(),
      'devicePlatform': devicePlatform.trim(),
      'appVersion': appVersion.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> saveAppConfig(AppRemoteConfig config) {
    return _appConfigDoc.set(config.toJson(), SetOptions(merge: true));
  }

  Future<AdminDashboardStats> loadDashboardStats() async {
    final firestore = _firestore;
    if (firestore == null &&
        usersSnapshotLoader == null &&
        logsSnapshotLoader == null &&
        requestsSnapshotLoader == null &&
        providerSnapshotLoader == null &&
        providersLoader == null &&
        appConfigLoader == null) {
      return const AdminDashboardStats(
        totalUsers: '0',
        activeUsers: '0',
        newUsersToday: '0',
        watchlistRecords: '0',
        continueWatchingRecords: '0',
        playbackErrors: '0',
        providerStatuses: '4',
        jellyfinStatus: 'Unavailable',
        latestReports: '0',
      );
    }
    final usersSummary = await _loadUsersSummary(firestore);
    final contentSummary = await _loadUserContentSummary(firestore);
    final providerStatuses = await _safeValue<String>(
      'loadDashboardStats.providers',
      () async => '${(await loadProviders()).length}',
      fallback: '${defaultProviderConfigs.length}',
    );
    final playbackErrors = await _safeValue<String>(
      'loadDashboardStats.playbackLogs',
      () async {
        final snapshot =
            await logsSnapshotLoader?.call() ??
            await _collection(AdminPaths.playbackLogs).get();
        return '${snapshot.size}';
      },
      fallback: 'Unavailable',
    );
    final latestReports = await _safeValue<String>(
      'loadDashboardStats.requests',
      () async {
        final snapshot =
            await requestsSnapshotLoader?.call() ??
            await _collection(AdminPaths.contentRequests).get();
        return '${snapshot.size}';
      },
      fallback: 'Unavailable',
    );
    final jellyfinStatus = await _safeValue<String>(
      'loadDashboardStats.appConfig',
      () async {
        final config = await loadPublicAppConfig();
        return config.jellyfinEnabled && config.jellyfinNativeEnabled
            ? 'Enabled'
            : 'Disabled';
      },
      fallback: 'Unavailable',
    );
    return AdminDashboardStats(
      totalUsers: usersSummary.totalUsers,
      activeUsers: usersSummary.activeUsers,
      newUsersToday: usersSummary.newUsersToday,
      watchlistRecords: contentSummary.watchlistRecords,
      continueWatchingRecords: contentSummary.continueWatchingRecords,
      playbackErrors: playbackErrors,
      providerStatuses: providerStatuses,
      jellyfinStatus: jellyfinStatus,
      latestReports: latestReports,
    );
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    final firestore = _firestore;
    if (firestore == null) return;
    await firestore.collection('users').doc(uid).update(data);
  }

  Future<_UsersSummary> _loadUsersSummary(FirebaseFirestore? firestore) {
    return _safeValue<_UsersSummary>('loadDashboardStats.users', () async {
      final usersSnapshot =
          await usersSnapshotLoader?.call() ??
          await firestore!.collection('users').get();
      var activeUsers = 0;
      var newUsersToday = 0;
      final today = DateTime.now();
      final todayStart = DateTime(today.year, today.month, today.day);
      for (final userDoc in usersSnapshot.docs) {
        final data = userDoc.data();
        if ((data['status'] ?? 'active').toString() != 'blocked') {
          activeUsers++;
        }
        final createdAt = _toDate(data['createdAt']);
        if (createdAt != null && !createdAt.isBefore(todayStart)) {
          newUsersToday++;
        }
      }
      return _UsersSummary(
        totalUsers: '${usersSnapshot.size}',
        activeUsers: '$activeUsers',
        newUsersToday: '$newUsersToday',
      );
    }, fallback: const _UsersSummary.unavailable());
  }

  Future<_ContentSummary> _loadUserContentSummary(
    FirebaseFirestore? firestore,
  ) {
    return _safeValue<_ContentSummary>(
      'loadDashboardStats.userContent',
      () async {
        final usersSnapshot =
            await usersSnapshotLoader?.call() ??
            await firestore!.collection('users').get();
        var watchlistRecords = 0;
        var activityRecords = 0;
        for (final userDoc in usersSnapshot.docs) {
          final watchlist =
              await userSubcollectionLoader?.call(
                userDoc.reference,
                'watchlist',
              ) ??
              await userDoc.reference.collection('watchlist').get();
          watchlistRecords += watchlist.size;
          final activity =
              await userSubcollectionLoader?.call(
                userDoc.reference,
                'activity',
              ) ??
              await userDoc.reference.collection('activity').get();
          activityRecords += activity.size;
        }
        return _ContentSummary(
          watchlistRecords: '$watchlistRecords',
          continueWatchingRecords: '$activityRecords',
        );
      },
      fallback: const _ContentSummary.unavailable(),
    );
  }

  Future<T> _safeValue<T>(
    String label,
    Future<T> Function() action, {
    required T fallback,
  }) async {
    try {
      return await action();
    } catch (error) {
      _logFirestoreFallback(label, error);
      return fallback;
    }
  }

  void _logFirestoreFallback(String label, Object error) {
    if (!kDebugMode) {
      return;
    }
    if (error is FirebaseException &&
        _safeFirestoreCodes.contains(error.code)) {
      debugPrint('AdminRepository fallback $label: ${error.code}');
      return;
    }
    debugPrint('AdminRepository fallback $label: ${error.runtimeType}');
  }
}

class _UsersSummary {
  const _UsersSummary({
    required this.totalUsers,
    required this.activeUsers,
    required this.newUsersToday,
  });

  const _UsersSummary.unavailable()
    : totalUsers = 'Unavailable',
      activeUsers = 'Unavailable',
      newUsersToday = 'Unavailable';

  final String totalUsers;
  final String activeUsers;
  final String newUsersToday;
}

class _ContentSummary {
  const _ContentSummary({
    required this.watchlistRecords,
    required this.continueWatchingRecords,
  });

  const _ContentSummary.unavailable()
    : watchlistRecords = 'Unavailable',
      continueWatchingRecords = 'Unavailable';

  final String watchlistRecords;
  final String continueWatchingRecords;
}
