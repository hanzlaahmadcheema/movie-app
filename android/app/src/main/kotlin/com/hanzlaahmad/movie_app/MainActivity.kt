package com.hanzlaahmad.movie_app

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "movie_app/share")
            .setMethodCallHandler { call, result ->
                if (call.method != "shareText") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                val text = call.argument<String>("text")?.trim().orEmpty()
                if (text.isEmpty()) {
                    result.success(false)
                    return@setMethodCallHandler
                }

                val intent = Intent(Intent.ACTION_SEND).apply {
                    type = "text/plain"
                    putExtra(Intent.EXTRA_TEXT, text)
                }
                val chooser = Intent.createChooser(intent, "Share MovieApp title")
                runCatching {
                    startActivity(chooser)
                }.onSuccess {
                    result.success(true)
                }.onFailure {
                    result.success(false)
                }
            }
    }
}
