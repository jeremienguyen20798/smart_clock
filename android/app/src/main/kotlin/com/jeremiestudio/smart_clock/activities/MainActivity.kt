package com.jeremiestudio.smart_clock.activities

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat.getString
import com.jeremiestudio.smart_clock.R
import com.jeremiestudio.smart_clock.utils.AlarmUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.Calendar
import java.util.Date

class MainActivity : FlutterActivity() {

    private var calendar: Calendar? = null
    private var alarmManager: AlarmManager? = null
    private val channel = "smart_lock_channel"
    private var alarmUtils: AlarmUtils? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
        initInstance()
    }

    @SuppressLint("SimpleDateFormat")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        ).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "setAlarm" -> {
                    val data = call.arguments as Map<*, *>
                    Log.d("TAG", "Set Alarm: $data")
                    val note: String = data["note"].toString()
                    val dateStr = data["dateTime"] as String
                    val dateTime = alarmUtils?.convertDateToStr(dateStr)
                    val typeAlarm = enumValueOf<AlarmType>(data["repeat"].toString())
                    val alarmId = data["alarm_id"].toString()
                    setAlarm(dateTime, note, alarmId, typeAlarm)
                    result.success("success")
                }

                "cancelAlarm" -> {
                    val data = call.arguments as Map<*, *>
                    Log.d("TAG", "Cancel Alarm: $data")
                    alarmUtils?.cancelAlarm(data)
                    result.success("cancel_success")
                }

                "resetAlarm" -> {
                    val data = call.arguments as Map<*, *>
                    Log.d("TAG", "Reset Alarm: $data")
                    val note: String = data["note"].toString()
                    val dateStr = data["dateTime"] as String
                    val dateTime = alarmUtils?.convertDateToStr(dateStr)
                    val typeAlarm = enumValueOf<AlarmType>(data["repeat"].toString())
                    val alarmId = data["alarm_id"].toString()
                    setAlarm(dateTime, note, alarmId, typeAlarm)
                    result.success("reset_success")
                }

                "cancelRingAlarmById" -> {
                    val data = call.arguments as List<*>
                    alarmUtils?.cancelRingAlarms(data)
                }
            }
        }
    }

    private fun setAlarm(dateTime: Date?, note: String, alarmId: String, typeAlarmType: AlarmType) {
        when (typeAlarmType) {
            AlarmType.justonce -> {
                alarmUtils?.setOnlyOnceAlarm(dateTime, note, alarmId)
            }

            AlarmType.daily -> {
                alarmUtils?.setDailyAlarm(dateTime, note)
            }

            AlarmType.mondaytofriday -> {
                alarmUtils?.setWeeklyAlarm(dateTime, note)
            }
        }
    }

    private fun initInstance() {
        calendar = Calendar.getInstance()
        alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
        alarmUtils = AlarmUtils(this, alarmManager)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val importance = NotificationManager.IMPORTANCE_HIGH
            val channel = NotificationChannel(
                getString(context, R.string.channel_id),
                getString(context, R.string.channel_name),
                importance
            ).apply {
                description = getString(context, R.string.desc_channel)
                setSound(null, null)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
                    setShowWhenLocked(true)
                }
                lockscreenVisibility = NotificationCompat.VISIBILITY_PUBLIC
                enableLights(true)
                enableVibration(true)
            }
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    enum class AlarmType { justonce, daily, mondaytofriday }
}




