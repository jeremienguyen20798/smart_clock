package com.jeremiestudio.smart_clock.receivers

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.util.Log
import com.jeremiestudio.smart_clock.services.AlarmService

class AlarmReceiver : BroadcastReceiver() {

    @SuppressLint("DefaultLocale", "NewApi")
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: AlarmReceiver is started")
        val notificationId: Long = intent.getLongExtra("notification_id", 0)
        val hour: Int = intent.getIntExtra("hour", 0)
        val minute: Int = intent.getIntExtra("minute", 0)
        val noteAlarm: String = intent.getStringExtra("note").toString()
        val alarmIntent = Intent(context, AlarmService::class.java)
        alarmIntent.putExtra("notification_id", notificationId)
        alarmIntent.putExtra("hour", hour)
        alarmIntent.putExtra("minute", minute)
        alarmIntent.putExtra("note", noteAlarm)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            context.startForegroundService(alarmIntent)
        } else {
            context.startService(alarmIntent)
        }
    }
}