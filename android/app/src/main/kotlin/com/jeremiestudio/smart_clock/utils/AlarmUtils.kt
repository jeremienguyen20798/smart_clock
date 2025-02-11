package com.jeremiestudio.smart_clock.utils

import android.annotation.SuppressLint
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.util.Log
import com.jeremiestudio.smart_clock.activities.MainActivity.AlarmType
import com.jeremiestudio.smart_clock.receivers.AlarmReceiver
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.util.Calendar
import java.util.Date

class AlarmUtils(private val context: Context, private val alarmManager: AlarmManager?) {

    @SuppressLint("NewApi")
    fun convertDateToStr(str: String): Date {
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
    fun setOnlyOnceAlarm(date: Date?, note: String, alarmId: String) {
        Log.d("TAG", "setOnlyOnceAlarm: $date - $note")
        val calendar = Calendar.getInstance()
        if (date != null) {
            calendar.time = date
            val month = calendar.get(Calendar.MONTH)
            val dayOfMonth = calendar.get(Calendar.DAY_OF_MONTH)
            val hourOfDay = calendar.get(Calendar.HOUR_OF_DAY)
            val minute = calendar.get(Calendar.MINUTE)
            calendar.set(Calendar.MONTH, month)
            calendar.set(Calendar.DAY_OF_MONTH, dayOfMonth)
            calendar.set(Calendar.HOUR_OF_DAY, hourOfDay)
            calendar.set(Calendar.MINUTE, minute)
            calendar.set(Calendar.SECOND, 0)
            val intent = Intent(context, AlarmReceiver::class.java)
            intent.putExtra("notification_id", date.time)
            intent.putExtra("alarm_id", alarmId)
            intent.putExtra("hour", hourOfDay)
            intent.putExtra("minute", minute)
            intent.putExtra("note", note)
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                date.time.toInt(),
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            alarmManager?.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP, calendar.timeInMillis, pendingIntent
            )
        }
    }

    @SuppressLint("NewApi")
    fun setDailyAlarm(date: Date?, note: String) {
        Log.d("TAG", "setDailyAlarm: $date - $note")
        val calendar = Calendar.getInstance()
        if (date != null) {
            calendar.time = date
            val hour = calendar.get(Calendar.HOUR_OF_DAY)
            val minute = calendar.get(Calendar.MINUTE)
            if (date.time <= System.currentTimeMillis()) {
                calendar.add(Calendar.DAY_OF_YEAR, 1)
            }
            calendar.set(Calendar.HOUR_OF_DAY, hour)
            calendar.set(Calendar.MINUTE, minute)
            calendar.set(Calendar.SECOND, 0)
            calendar.set(Calendar.MILLISECOND, 0)
            val intent = Intent(context, AlarmReceiver::class.java)
            intent.putExtra("notification_id", date.time)
            intent.putExtra("date", date.toString())
            intent.putExtra("note", note)
            intent.putExtra("repeat", AlarmType.daily.toString())
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                date.time.toInt(),
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            alarmManager?.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                calendar.timeInMillis,
                pendingIntent
            )
        }
    }

    @SuppressLint("NewApi")
    fun setWeeklyAlarm(date: Date?, note: String) {
        val calendar = Calendar.getInstance()
        if (date != null) {
            calendar.time = date
            val hour = calendar.get(Calendar.HOUR_OF_DAY)
            val minute = calendar.get(Calendar.MINUTE)
            calendar.set(Calendar.HOUR_OF_DAY, hour)
            calendar.set(Calendar.MINUTE, minute)
            calendar.set(Calendar.SECOND, 0)
            val intent = Intent(context, AlarmReceiver::class.java)
            intent.putExtra("notification_id", date.time)
            intent.putExtra("hour", hour)
            intent.putExtra("minute", minute)
            intent.putExtra("note", note)
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                date.time.toInt(),
                intent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            alarmManager?.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                calendar.timeInMillis,
                pendingIntent
            )
        }
    }

    @SuppressLint("NewApi")
    fun cancelAlarm(data: Map<*, *>) {
        var dateStr = data["dateTime"] as String
        if (dateStr.length != 26) {
            dateStr += "000"
        }
        val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSSSS")
        val localDateTime = LocalDateTime.parse(dateStr, formatter)
        val dateTime = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant())
        if (dateTime != null) {
            val intent = Intent(context, AlarmReceiver::class.java)
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                dateTime.time.toInt(),
                intent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )
            alarmManager?.cancel(pendingIntent)
        }
    }

    fun cancelRingAlarms(dataList: List<*>) {
        Log.d("TAG", "Cancel Alarm By ID")
        for (item in dataList) {
            val date = convertDateToStr(item.toString())
            val intent = Intent(context, AlarmReceiver::class.java)
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                date.time.toInt(),
                intent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
            )
            alarmManager?.cancel(pendingIntent)
        }
    }
}