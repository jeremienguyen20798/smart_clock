package com.jeremiestudio.smart_clock.receivers

import android.annotation.SuppressLint
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.jeremiestudio.smart_clock.services.AlarmService


class DeleteAlarmReceiver : BroadcastReceiver() {
    @SuppressLint("NewApi")
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: Delete Alarm Started")
        val action = intent.action
        val notificationId: Int = intent.getIntExtra("EXTRA_NOTIFICATION_ID", 0)
        if (action == "TURN_OFF_ALARM") {
            val notificationManager =
                context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.cancel(notificationId)
            val stopAlarmIntent = Intent(context, AlarmService::class.java)
            context.stopService(stopAlarmIntent)
        }
    }
}