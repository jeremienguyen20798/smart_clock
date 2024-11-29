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
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import androidx.core.content.ContextCompat.getString
import com.jeremiestudio.smart_clock.R
import com.jeremiestudio.smart_clock.receivers.AlarmReceiver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.text.SimpleDateFormat
import java.util.Calendar

class MainActivity : FlutterActivity() {

    private var calendar: Calendar? = null
    private var alarmManager: AlarmManager? = null
    private val channel = "com.jeremiestudio.smart_clock/createAlarmBySpeech"

    @RequiresApi(Build.VERSION_CODES.O_MR1)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        createNotificationChannel()
        initInstance()
    }

    @SuppressLint("SimpleDateFormat")
    @RequiresApi(Build.VERSION_CODES.M)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, channel
        ).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            if (call.method == "setAlarm") {
                val data = call.arguments as Map<*, *>
                Log.d("TAG", "configureFlutterEngine: $data")
                val note: String = data["note"].toString()
                val dateStr = data["dateTime"] as String
                val simpleDateFormat = SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                val dateTime = simpleDateFormat.parse(dateStr)
                if (dateTime != null) {
                    val hour = dateTime.hours
                    val minute = dateTime.minutes
                    val date = dateTime.date
                    val month = dateTime.month
                    calendar?.set(Calendar.MONTH, month)
                    calendar?.set(Calendar.DAY_OF_MONTH, date)
                    calendar?.set(Calendar.HOUR_OF_DAY, hour)
                    calendar?.set(Calendar.MINUTE, minute)
                    calendar?.set(Calendar.SECOND, 0)
                    val intent = Intent(this@MainActivity, AlarmReceiver::class.java)
                    intent.putExtra("hour", hour)
                    intent.putExtra("minute", minute)
                    intent.putExtra("note", note)
                    val pendingIntent = PendingIntent.getBroadcast(
                        this@MainActivity, hour + minute, intent, PendingIntent.FLAG_MUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
                    )
                    alarmManager?.setExactAndAllowWhileIdle(
                        AlarmManager.RTC_WAKEUP, calendar!!.timeInMillis, pendingIntent
                    )
                }
                result.success("success")
            }
        }
    }

    private fun initInstance() {
        calendar = Calendar.getInstance()
        alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
    }

    @RequiresApi(Build.VERSION_CODES.O_MR1)
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
                setShowWhenLocked(true)
                lockscreenVisibility = NotificationCompat.VISIBILITY_PUBLIC
            }
            val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }
}




