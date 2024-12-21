package com.jeremiestudio.smart_clock.receivers

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.jeremiestudio.smart_clock.activities.MainActivity


class DeleteAlarmReceiver : BroadcastReceiver() {
    @SuppressLint("NewApi")
    override fun onReceive(context: Context, intent: Intent) {
        Log.d("TAG", "onReceive: Delete Alarm Started")
        val action = intent.action
        val notificationId: Int = intent.getIntExtra("EXTRA_NOTIFICATION_ID", 0)
        val alarmId: String = intent.getStringExtra("ALARM_ID").toString()
        if (action == "TURN_OFF_ALARM") {
            val mainIntent = Intent(context, MainActivity::class.java).apply {
                putExtra("EXTRA_NOTIFICATION_ID", notificationId)
                putExtra("ALARM_ID", alarmId)
            }
            context.startActivity(mainIntent)
        }
    }
}