package com.juanito21.simpleshare

import android.util.Log
import com.juanito21.simpleshare.src.ShareHelper
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class SimpleSharePlugin(registrar: Registrar) : MethodCallHandler {

  var shareHelper : ShareHelper = ShareHelper(registrar)

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "com.juanito21.simpleShare/share")
      channel.setMethodCallHandler(SimpleSharePlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "share") {
      if (call.arguments !is Map<*, *>) {
        throw IllegalArgumentException()
      }
      val args = call.arguments as Map<*, *>
      try {
        if (call.argument<Any>("uri") != null || call.argument<Any>("msg") != null) {
          shareHelper.share(args)
        }
        result.success(true)
      } catch (e: Exception) {
        Log.d("error", e.localizedMessage.toString())
        result.success(e.localizedMessage)
      }
    } else {
      result.notImplemented()
    }
  }
}
