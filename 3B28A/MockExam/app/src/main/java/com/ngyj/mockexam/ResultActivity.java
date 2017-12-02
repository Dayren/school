package com.ngyj.mockexam;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import static com.ngyj.mockexam.GameActivity.GAME_RESULT;
import static com.ngyj.mockexam.GameActivity.GAME_WORD;

public class ResultActivity extends AppCompatActivity {
    private boolean isVictory;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);
        Intent i = getIntent();
        TextView tv_result = findViewById(R.id.tv_result);
        TextView tv_word = findViewById(R.id.tv_cword);

        if(isVictory = i.getBooleanExtra(GAME_RESULT, false)){
            tv_result.setText(R.string.won);
        } else {
            tv_result.setText(R.string.lost);
            tv_word.setText(String.format("Le mot était : %s", i.getStringExtra(GAME_WORD)));
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {}
                if(isVictory){
                    Intent i = new Intent(ResultActivity.this, GameActivity.class);
                    startActivity(i);
                }
                finish();
            }
        }).start();

    }
}
