package com.jeremiestudio.smart_clock

import android.content.Intent
import android.os.Bundle
import android.view.WindowManager
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.jeremiestudio.smart_clock.services.AlarmService
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel


class AlarmActivity : AppCompatActivity() {

    private var stopAlarmButton: Button? = null
    private var noteAlarmTextView: TextView? = null
    private val channel: String = "alarm_channel"
    private var alarmId: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        setTheme(R.style.AppTheme)
        super.onCreate(savedInstanceState)
        // Bật màn hình
        window.addFlags(
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
                    WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON or
                    WindowManager.LayoutParams.FLAG_FULLSCREEN
        )
        setContentView(R.layout.activity_alarm)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        initView()
        if (intent != null) {
            val noteAlarm = intent.getStringExtra("note")
            alarmId = intent.getStringExtra("alarmId")
            noteAlarmTextView?.text = noteAlarm
        }
        stopAlarmButton?.setOnClickListener {
            val stopAlarmIntent = Intent(this@AlarmActivity, AlarmService::class.java)
            stopService(stopAlarmIntent)
            val flutterEngine = FlutterEngineCache.getInstance()["flutter_engine_id"]
            if (flutterEngine != null) {
                MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
                    .invokeMethod("updateAlarmStatus", object : HashMap<String?, Any?>() {
                        init {
                            put("alarmId", alarmId)
                        }
                    })
            }
            finish()
        }
    }

    private fun initView() {
        stopAlarmButton = findViewById(R.id.stopAlarm)
        noteAlarmTextView = findViewById(R.id.noteAlarm)
    }
}