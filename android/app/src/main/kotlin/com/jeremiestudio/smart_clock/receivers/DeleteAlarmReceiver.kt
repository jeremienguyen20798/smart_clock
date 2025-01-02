package com.jeremiestudio.smart_clock.receivers

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.jeremiestudio.smart_clock.services.AlarmService
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class DeleteAlarmReceiver : BroadcastReceiver() {

    private val channel: String = "alarm_channel"

    @SuppressLint("NewApi")
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: Delete Alarm Started")
        val action = intent.action
        val alarmId: String = intent.getStringExtra("ALARM_ID").toString()
        if (action == "TURN_OFF_ALARM") {
            val serviceIntent = Intent(context, AlarmService::class.java)
            context.stopService(serviceIntent)
            val flutterEngine = FlutterEngineCache.getInstance()["flutter_engine_id"]
            if (flutterEngine != null) {
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
                    .invokeMethod("updateAlarmStatus", object : HashMap<String?, Any?>() {
                        init {
                            put("alarmId", alarmId)
                        }
                    })
            }
        }
    }
}