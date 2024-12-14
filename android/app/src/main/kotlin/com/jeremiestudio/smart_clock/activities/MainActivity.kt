package com.jeremiestudio.smart_clock.activities

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat.getString
import com.jeremiestudio.smart_clock.R
import com.jeremiestudio.smart_clock.receivers.AlarmReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.util.Calendar
import java.util.Date

class MainActivity : FlutterActivity() {

    private var calendar: Calendar? = null
    private var alarmManager: AlarmManager? = null
    private val channel = "create_alarm_by_speech"

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
                    val dateTime = convertDateToStr(dateStr)
                    setAlarm(dateTime, note)
                    result.success("success")
                }
                "cancelAlarm" -> {
                    val data = call.arguments as Map<*, *>
                    Log.d("TAG", "Cancel Alarm: $data")
                    cancelAlarm(data)
                    result.success("cancel_success")
                }
                "resetAlarm" -> {
                    val data = call.arguments as Map<*, *>
                    Log.d("TAG", "Reset Alarm: $data")
                    val note: String = data["note"].toString()
                    val dateStr = data["dateTime"] as String
                    val dateTime = convertDateToStr(dateStr)
                    setAlarm(dateTime, note)
                    result.success("reset_success")
                }
            }
        }
    }

    @SuppressLint("NewApi")
    private fun convertDateToStr(str: String): Date {
        var dateTimeStr = str
        if (dateTimeStr.length != 26) {
            dateTimeStr += "000"
        }
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
        val localDateTime = LocalDateTime.parse(dateTimeStr, formatter)
        val dateTime = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant())
        return dateTime
    }

    @SuppressLint("NewApi")
    private fun setAlarm(dateTime: Date, note: String) {
        val hour = dateTime.hours
        val minute = dateTime.minutes
        val date = dateTime.date
        val month = dateTime.month
        calendar?.set(Calendar.MONTH, month)
        calendar?.set(Calendar.DAY_OF_MONTH, date)
        calendar?.set(Calendar.HOUR_OF_DAY, hour)
        calendar?.set(Calendar.MINUTE, minute)
        calendar?.set(Calendar.SECOND, 0)
        calendar?.set(Calendar.MILLISECOND, 0)
        val intent = Intent(this@MainActivity, AlarmReceiver::class.java)
        intent.putExtra("notification_id", dateTime.time)
        intent.putExtra("hour", hour)
        intent.putExtra("minute", minute)
        intent.putExtra("note", note)
        val pendingIntent = PendingIntent.getBroadcast(
            this@MainActivity,
            dateTime.time.toInt(),
            intent,
            PendingIntent.FLAG_MUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
        alarmManager?.setInexactRepeating(
            AlarmManager.RTC_WAKEUP, calendar!!.timeInMillis, AlarmManager.INTERVAL_DAY, pendingIntent
        )
    }

    @SuppressLint("NewApi")
    private fun cancelAlarm(data: Map<*, *>) {
        var dateStr = data["dateTime"] as String
        if (dateStr.length != 26) {
            dateStr += "000"
        }
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
        val localDateTime = LocalDateTime.parse(dateStr, formatter)
        val dateTime = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant())
        if (dateTime != null) {
            val intent = Intent(this@MainActivity, AlarmReceiver::class.java)
            val pendingIntent = PendingIntent.getBroadcast(
                this@MainActivity,
                dateTime.time.toInt(),
                intent,
                PendingIntent.FLAG_MUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )
            alarmManager?.cancel(pendingIntent)
        }
    }

    private fun initInstance() {
        calendar = Calendar.getInstance()
        alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
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
            }
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
}




