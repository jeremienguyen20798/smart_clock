package com.jeremiestudio.smart_clock.services

import android.annotation.SuppressLint
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.media.MediaPlayer
import android.net.Uri
import android.os.Environment
import android.os.IBinder
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import com.jeremiestudio.smart_clock.AlarmActivity
import com.jeremiestudio.smart_clock.R
import com.jeremiestudio.smart_clock.receivers.DeleteAlarmReceiver
import java.io.File

class AlarmService : Service() {

    private var mediaPlayer: MediaPlayer? = null

    override fun onCreate() {
        super.onCreate()
        MediaPlayer.create(this, R.raw.sound)
//        val ringtoneFiles = getInternalFile()
//        if (ringtoneFiles.exists()) {
//            if (ringtoneFiles.listFiles() != null) {
//                val ringtoneFile = ringtoneFiles.listFiles()?.last()
//                MediaPlayer.create(this, Uri.fromFile(ringtoneFile))
//            } else {
//                MediaPlayer.create(this, R.raw.sound)
//            }
//        } else {
//            MediaPlayer.create(this, R.raw.sound)
//        }
        mediaPlayer?.isLooping = true
        mediaPlayer?.setVolume(0.0F, 1.0F)
    }

    override fun onBind(intent: Intent?): IBinder? {
        TODO("Not yet implemented")
    }

    @SuppressLint("DefaultLocale")
    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val alarmId = intent.getStringExtra("alarm_id")
        val notificationId: Long = intent.getLongExtra("notification_id", 0)
        val hour: Int = intent.getIntExtra("hour", 0)
        val minute: Int = intent.getIntExtra("minute", 0)
        val noteAlarm: String = intent.getStringExtra("note").toString()
        showNotification(
            notificationId.toInt(),
            this,
            "$noteAlarm - ${String.format("%02d", hour)}:${String.format("%02d", minute)}",
            alarmId,
        )
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        mediaPlayer?.stop()
        mediaPlayer?.release()
    }

    @SuppressLint("NewApi")
    private fun showNotification(id: Int, context: Context, message: String, alarmId: String?) {
        var fullScreenPendingIntent: PendingIntent? = null
        val intent = Intent(context, DeleteAlarmReceiver::class.java).apply {
            action = "TURN_OFF_ALARM"
            putExtra("ALARM_ID", alarmId)
        }
        val deleteAlarmIntent: PendingIntent =
            PendingIntent.getBroadcast(context, id, intent, PendingIntent.FLAG_IMMUTABLE)
//        val notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
//        if (notificationManager.canUseFullScreenIntent()) {
//            val fullScreenIntent = Intent(context, AlarmActivity::class.java).apply {
//                setFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
//                putExtra("note", message)
//                putExtra("alarmId", alarmId)
//            }
//            fullScreenPendingIntent =
//                PendingIntent.getActivity(
//                    context, 0, fullScreenIntent,
//                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
//                )
//        }

        val notification =
            NotificationCompat.Builder(
                context,
                ContextCompat.getString(context, R.string.channel_id)
            )
                .setSmallIcon(R.drawable.baseline_notifications_active_24)
                .setContentTitle(ContextCompat.getString(context, R.string.alarm_title))
                .setContentText(message)
                .setOngoing(true)
                //.setFullScreenIntent(fullScreenPendingIntent, true)
                .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setAutoCancel(true)
                .addAction(
                    R.drawable.baseline_access_alarm_24, ContextCompat.getString(
                        context,
                        R.string.delete_alarm
                    ), deleteAlarmIntent
                )
                .addAction(
                    R.drawable.baseline_access_alarm_24, ContextCompat.getString(
                        context,
                        R.string.create_new_alarm
                    ), deleteAlarmIntent
                )
                .build()
        with(NotificationManagerCompat.from(context)) {
            if (ActivityCompat.checkSelfPermission(
                    context, android.Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                    context,
                    android.Manifest.permission.FOREGROUND_SERVICE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                return@with
            }
            startForeground(1, notification)
            mediaPlayer?.start()
        }
    }

    private fun getInternalFile(): File {
        return File("/storage/emulated/0/Android/data/com.jeremiestudio.smart_clock.dev/files/data/user/0/com.jeremiestudio.smart_clock.dev/files/")
    }
}