package com.ngyj.accel_play;

import android.app.ActionBar;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.support.constraint.ConstraintLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity implements SensorEventListener {
    private SensorManager sm;
    private Sensor accelSensor;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        sm = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        accelSensor = sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        System.out.print("on create");
    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        double x = event.values[0];
        double y = event.values[1] - 9.81;
        ((TextView)findViewById(R.id.tv_x)).setText(""+x);
        ((TextView)findViewById(R.id.tv_y)).setText(""+y);

        Button b = findViewById(R.id.btn);
        ConstraintLayout.LayoutParams clp = new ConstraintLayout.LayoutParams(b.getLayoutParams());
        clp.bottomMargin += y; clp.topMargin -= y;
        clp.rightMargin += x; clp.leftMargin -= x;

    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
        Log.i("sensor", "accuracy changed");
    }

    @Override
    protected void onResume(){
        Log.i("sensor", "onResume");
        super.onResume();
        sm.registerListener(this, accelSensor, SensorManager.SENSOR_DELAY_GAME);
    }
    @Override
    protected void onPause(){
        super.onPause();
        sm.unregisterListener(this);
    }
}