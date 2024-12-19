package com.jeremiestudio.smart_clock

import androidx.appcompat.app.AppCompatActivity
import android.annotation.SuppressLint
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import com.jeremiestudio.smart_clock.databinding.ActivityFullscreenBinding

/**
 * An example full-screen activity that shows and hides the system UI (i.e.
 * status bar and navigation/system bar) with user interaction.
 */
class FullscreenActivity : AppCompatActivity() {

    private lateinit var binding: ActivityFullscreenBinding
    private lateinit var alarmContent: TextView
    private lateinit var cancelAlarm: Button

    @SuppressLint("ClickableViewAccessibility")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityFullscreenBinding.inflate(layoutInflater)
        setContentView(binding.root)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        // Set up the user interaction to manually show or hide the system UI.
        alarmContent = binding.alarmContent
        cancelAlarm = binding.cancelAlarm

        cancelAlarm.setOnClickListener {
            intent.apply {
                val notificationId = intent.getIntExtra("notification_id", 0)

            }
        }
    }


}