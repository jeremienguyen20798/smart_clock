package com.jeremiestudio.smart_clock.receivers

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import com.jeremiestudio.smart_clock.activities.MainActivity.AlarmType
import com.jeremiestudio.smart_clock.services.AlarmService
import com.jeremiestudio.smart_clock.utils.AlarmUtils
import io.flutter.embedding.android.FlutterActivity.ALARM_SERVICE

class AlarmReceiver : BroadcastReceiver() {

    @SuppressLint("DefaultLocale", "NewApi")
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: AlarmReceiver is started")
        val alarmManager = context.getSystemService(ALARM_SERVICE) as AlarmManager
        val alarmUtils = AlarmUtils(context, alarmManager)
        val alarmId = intent.getStringExtra("alarm_id")
        val notificationId: Long = intent.getLongExtra("notification_id", 0)
        val date = intent.getLongExtra("date", 0)
        val noteAlarm: String = intent.getStringExtra("note").toString()
        val isDailyRepeat: String = intent.getStringExtra("repeat").toString()
        val alarmIntent = Intent(context, AlarmService::class.java)
        val hour: Int = (date / 3600000).toInt()
        val minute: Int = (date / 60000).toInt()
        alarmIntent.putExtra("hour", hour)
        alarmIntent.putExtra("minute", minute)
        alarmIntent.putExtra("alarm_id", alarmId)
        alarmIntent.putExtra("notification_id", notificationId)
        alarmIntent.putExtra("note", noteAlarm)
        if (isDailyRepeat == AlarmType.daily.toString()) {
            val dateAlarm = alarmUtils.convertLongToTime(date)
            alarmUtils.setDailyAlarm(dateAlarm, noteAlarm)
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(alarmIntent)
        } else {
            context.startService(alarmIntent)
        }
    }
}