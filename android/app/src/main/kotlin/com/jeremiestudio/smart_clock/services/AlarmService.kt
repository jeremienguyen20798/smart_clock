package com.jeremiestudio.smart_clock.services

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.MediaPlayer
import android.os.IBinder
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import com.jeremiestudio.smart_clock.R
import com.jeremiestudio.smart_clock.receivers.DeleteAlarmReceiver

class AlarmService : Service() {

    private var mediaPlayer: MediaPlayer? = null

    override fun onCreate() {
        super.onCreate()
        mediaPlayer = MediaPlayer.create(this, R.raw.sound)
        mediaPlayer?.isLooping = true
    }

    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
    }

    @SuppressLint("DefaultLocale")
    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val notificationId : Long = intent.getLongExtra("notification_id", 0)
        val hour: Int = intent.getIntExtra("hour", 0)
        val minute: Int = intent.getIntExtra("minute", 0)
        val noteAlarm: String = intent.getStringExtra("note").toString()
        showNotification(
            notificationId.toInt(),
            this,
            "$noteAlarm - ${String.format("%02d", hour)}:${String.format("%02d", minute)}"
        )
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        mediaPlayer?.stop()
        mediaPlayer?.release()
    }

    private fun showNotification(id: Int, context: Context, message: String) {
        val intent = Intent(context, DeleteAlarmReceiver::class.java).apply {
            action = "TURN_OFF_ALARM"
            putExtra("EXTRA_NOTIFICATION_ID", id)
        }
        val deleteAlarmIntent: PendingIntent =
            PendingIntent.getBroadcast(context, id, intent, PendingIntent.FLAG_MUTABLE)
        val notification =
            NotificationCompat.Builder(
                context,
                ContextCompat.getString(context, R.string.channel_id)
            )
                .setSmallIcon(R.drawable.baseline_notifications_active_24)
                .setContentTitle(ContextCompat.getString(context, R.string.alarm_title))
                .setContentText(message)
                .setCategory(NotificationCompat.CATEGORY_ALARM)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setOngoing(true)
                .addAction(
                    R.drawable.baseline_access_alarm_24, ContextCompat.getString(
                        context,
                        R.string.delete_alarm
                    ), deleteAlarmIntent
                )
                .build()

        with(NotificationManagerCompat.from(context)) {
            if (ActivityCompat.checkSelfPermission(
                    context, android.Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return@with
            }
            startForeground(1, notification)
            mediaPlayer?.start()
        }
    }

}