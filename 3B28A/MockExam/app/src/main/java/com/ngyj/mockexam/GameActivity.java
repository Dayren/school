package com.ngyj.mockexam;

import android.content.Context;
import android.content.Intent;
import android.icu.lang.UCharacter;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import org.w3c.dom.Text;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.lang.reflect.Array;
import java.util.ArrayList;

public class GameActivity extends AppCompatActivity {
    public static final boolean TESTING = false;

    public static final String FILENAME = "com.ngyj.mockexam.save";
    public static final String FILE_EXISTS = "com.ngyj.mockexam.fileExists";
    public static final String GAME_RESULT = "com.ngyj.mockexam.gameResult";
    public static final String GAME_WORD = "com.ngyj.mockexam.gameWord";

    private static final String CURRENT_WORD = "com.ngyj.mockexam.currentWord";
    private static final String CURRENT_CORRECT= "com.ngyj.mockexam.currentCorrect";
    private static final String CURRENT_WRONG = "com.ngyj.mockexam.currentWrong";
    private static final String CURRENT_LEFT = "com.ngyj.mockexam.currentLeft";

    private String word;
    private String correct;
    private String wrong;
    private int tries_left;

    /* disabled buttons "list" */
    private String disabled;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        if(savedInstanceState != null) {
            word = savedInstanceState.getString(CURRENT_WORD);
            correct = savedInstanceState.getString(CURRENT_CORRECT);
            wrong = savedInstanceState.getString(CURRENT_WRONG);
        } else if (getIntent().getBooleanExtra(FILE_EXISTS, false)) {
            getGame();
        } else {
            correct = "";
            wrong = "";
            getWord();
        }
        tries_left = 10 - wrong.length();

        /* debug */
        if(TESTING)
            word = "POMME";

        display();
        alphabet();

    }
    @Override
    protected void onDestroy() {
        super.onDestroy();
        deleteFile(FILENAME);
        Log.v("I/O", "filed saved");
    }
    @Override
    protected void onStop() {
        super.onStop();
        saveGame();
        Log.v("I/O", "filed saved");
    }
    @Override
    protected void onSaveInstanceState(Bundle state) {
        super.onSaveInstanceState(state);
        state.putSerializable(CURRENT_WORD, word);
        state.putSerializable(CURRENT_LEFT, tries_left);
        state.putSerializable(CURRENT_WRONG, wrong);
        state.putSerializable(CURRENT_CORRECT, correct);
    }

    private void alphabet() {
        TableLayout tl=findViewById(R.id.table);
        tl.setStretchAllColumns(true);
        tl.setShrinkAllColumns(true);
        TableRow tr = null;
        for(char a = 'A'; a <= 'Z'; a++) {
            if((a-'A')%6 ==  0)
                tl.addView(tr = new TableRow(this));

            Button btn = new Button(this);
            btn.setText(""+a);
            btn.setOnClickListener(new clickHandler());
            tr.addView(btn);
            if(wrong.contains(""+a) || correct.contains(""+a)) {
                btn.setAlpha(0.4F);
                btn.setEnabled(false);
            }
        }
    }

    private void display() {
        int len = word.length();
        String str = "";
        for(int i =0; i < len; i++) {
            if (correct.contains(""+ word.charAt(i))) {
                str += word.charAt(i);
            } else {
                str += "_";
            }
        }
        ((TextView) findViewById(R.id.tv_word)).setText(str);
        ((TextView) findViewById(R.id.tv_left)).setText(""+tries_left);
        ((TextView) findViewById(R.id.tv_wrong)).setText(""+wrong);
    }
    
    private class clickHandler implements View.OnClickListener {
        public void onClick(View view) {
            Button btn = (Button)view;

            btn.setAlpha(0.4f);
            btn.setEnabled(false);
            verify(btn.getText().toString());
            display();
            if(!((TextView) findViewById(R.id.tv_word)).getText().toString().contains("_"))
                end(true);
            else if(tries_left == 0)
                end(false);
        }
    }

    private void verify(String c) {
        if(word.contains(c))
            correct += c;
        else {
            wrong += c;
            --tries_left;
        }
    }

    private void end(boolean r) {
        Intent i = new Intent(this, ResultActivity.class);
        if(r) {
            i.putExtra(GAME_RESULT, true);
        } else{
            i.putExtra(GAME_RESULT, false);
            i.putExtra(GAME_WORD, word);
        }
        finish();
        startActivity(i);
    }

    private void getWord() {
        InputStream instream = null;
        try {
            instream = getResources().openRawResource(R.raw.wordlist);
        } catch (Exception e) {
            Log.e("MockExam I/O", "failed opening InputStream");
            e.printStackTrace();
        }
        if (instream == null) {
            Log.e("MockExam I/O", "Cannot open raw/wordlist.txt as stream");
            return;
        }
        BufferedReader br = new BufferedReader(new InputStreamReader(instream));
        ArrayList<String> wordlist = new ArrayList<String>();
        String line = "";

        while((line = getLine(br)) != null)
            wordlist.add(line);
        word = wordlist.get((int)(Math.random() * wordlist.size())).toUpperCase();
        try {
            br.close();
            instream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String getLine(BufferedReader br) {
        String line = "";
        try {
            line = br.readLine();
        } catch (IOException e) {
            Log.e("MockExam I/O", "IOException: failed to read buffer");
        }
        return line;
    }

    private void saveGame() {
        try {
            OutputStreamWriter osw = new OutputStreamWriter(openFileOutput(FILENAME, Context.MODE_PRIVATE));
            osw.write(String.format("%s\n%s\n%s\n", word, correct, wrong));
            osw.flush();
            osw.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void getGame() {
        try {
            BufferedReader br = new BufferedReader(new FileReader(new File(getApplicationContext().getFilesDir(), FILENAME)));
            if((word = br.readLine()).isEmpty()) word = "";
            if((correct = br.readLine()).isEmpty()) correct = "";
            if((wrong = br.readLine()) == null) wrong = "";
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
