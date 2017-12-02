package com.ngyj.mockexam;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import static com.ngyj.mockexam.GameActivity.FILENAME;
import static com.ngyj.mockexam.GameActivity.FILE_EXISTS;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        searchSaving();
    }

    protected void newGame(View view) {
        Intent i = new Intent(this, GameActivity.class);
        i.putExtra(FILE_EXISTS, false);
        startActivity(i);
    }

    private void searchSaving() {
        try {
            FileInputStream file = new FileInputStream(new File(getApplicationContext().getFilesDir(), FILENAME));
            file.close();
            Intent i = new Intent(this, GameActivity.class);
            i.putExtra(FILE_EXISTS, true);
            startActivity(i);
        } catch (IOException e) {}
    }
}
