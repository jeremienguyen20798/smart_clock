package com.jeremiestudio.smart_clock.receivers

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import com.jeremiestudio.smart_clock.activities.MainActivity.AlarmType
import com.jeremiestudio.smart_clock.services.AlarmService
import io.flutter.embedding.android.FlutterActivity.ALARM_SERVICE
import java.util.Calendar

class AlarmReceiver : BroadcastReceiver() {

    @SuppressLint("DefaultLocale", "NewApi")
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: AlarmReceiver is started")
        val alarmId = intent.getStringExtra("alarm_id")
        val notificationId: Long = intent.getLongExtra("notification_id", 0)
        val hour: Int = intent.getIntExtra("hour", 0)
        val minute: Int = intent.getIntExtra("minute", 0)
        val noteAlarm: String = intent.getStringExtra("note").toString()
        val isDailyRepeat: String = intent.getStringExtra("repeat").toString()
        val alarmIntent = Intent(context, AlarmService::class.java)
        alarmIntent.putExtra("alarm_id", alarmId)
        alarmIntent.putExtra("notification_id", notificationId)
        alarmIntent.putExtra("hour", hour)
        alarmIntent.putExtra("minute", minute)
        alarmIntent.putExtra("note", noteAlarm)
        if (isDailyRepeat == AlarmType.daily.toString()) {
            setDailyAlarm(context, notificationId.toInt(), hour, minute, noteAlarm)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(alarmIntent)
        } else {
            context.startService(alarmIntent)
        }
    }

    @SuppressLint("NewApi")
    private fun setDailyAlarm(
        context: Context,
        notificationId: Int,
        hour: Int,
        minute: Int,
        note: String
    ) {
        val alarmManager = context.getSystemService(ALARM_SERVICE) as AlarmManager
        val calendar = Calendar.getInstance()
        calendar.add(Calendar.DAY_OF_YEAR, 1)
        calendar.set(Calendar.HOUR_OF_DAY, hour)
        calendar.set(Calendar.MINUTE, minute)
        calendar.set(Calendar.SECOND, 0)
        calendar.set(Calendar.MILLISECOND, 0)
        val intent = Intent(context, AlarmReceiver::class.java)
        intent.putExtra("notification_id", notificationId)
        intent.putExtra("hour", hour)
        intent.putExtra("minute", minute)
        intent.putExtra("note", note)
        intent.putExtra("repeat", AlarmType.daily.toString())
        val pendingIntent = PendingIntent.getBroadcast(
            context,
            notificationId,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            calendar.timeInMillis,
            pendingIntent
        )
    }
}