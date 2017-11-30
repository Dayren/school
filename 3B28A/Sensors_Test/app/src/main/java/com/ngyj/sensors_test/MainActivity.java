package com.ngyj.sensors_test;

import android.content.ContentValues;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

import org.w3c.dom.Text;

public class MainActivity extends AppCompatActivity implements SensorEventListener{
    private SensorManager sm;
    private Sensor accel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        sm = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        accel = sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
    }
    @Override
    protected void onResume(){
        super.onResume();
        sm.registerListener(this, accel, SensorManager.SENSOR_DELAY_GAME);
    }
    @Override
    protected void onPause() {
        super.onPause();
        sm.unregisterListener(this);
    }


    @Override
    public void onSensorChanged(SensorEvent event) {
        float x = event.values[0] * 10;
        /* event.values[2] si l'on veut que le mobile soit au repos verticallement */
        float y = event.values[1] * 10;
        ((TextView)findViewById(R.id.tv_x)).setText(String.format("%s", x));
        ((TextView)findViewById(R.id.tv_y)).setText(String.format("%s", y));

        MoveButton(x,y);
    }

    private void MoveButton(float x, float y) {
        TextView tv = findViewById(R.id.hello);
        float newX = tv.getX() - x;
        float newY = tv.getY() + y;
        tv.setX(newX);
        tv.setY(newY);
        ((TextView) findViewById(R.id.tv_bx)).setText(String.format("%s", newX));
        ((TextView) findViewById(R.id.tv_by)).setText(String.format("%s", newY));
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
        Log.v("sensors", "accur changed");
    }
}
