package com.ngyj.mockexam;

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
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Array;
import java.util.ArrayList;

public class GameActivity extends AppCompatActivity {
    private static final String CURRENT_WORD = "com.ngyj.mockexam.currentWord";
    private static final String CURRENT_CORRECT= "com.ngyj.mockexam.currentCorrect";
    private static final String CURRENT_WRONG = "com.ngyj.mockexam.currentWrong";
    private static final String CURRENT_LEFT = "com.ngyj.mockexam.currentLeft";
    private static final String CURRENT_DISABLED = "com.ngyj.mockexam.currentDisabled";

    private String word;
    private String correct;
    private String wrong;
    private int tries_left;
    private ArrayList<String> wordlist;

    /* disabled buttons "list" */
    private String disabled;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);

        tries_left = 10;
        word = "";
        /* todo: liste dynamique de type primitif char ???? */
        correct = "";
        wrong = "";
        disabled = "";
        setWord();
        /* todo : make a list of all buttons and save their state */
        if(savedInstanceState != null) {
            word = savedInstanceState.getString(CURRENT_WORD);
            correct = savedInstanceState.getString(CURRENT_CORRECT);
            wrong = savedInstanceState.getString(CURRENT_WRONG);
            tries_left = savedInstanceState.getInt(CURRENT_LEFT);
            disabled = savedInstanceState.getString(CURRENT_DISABLED);
        }
        display();
        ((TextView) findViewById(R.id.tv_wrong)).setText(wrong);

        TableLayout tl=findViewById(R.id.table);
        tl.setStretchAllColumns(true);
        tl.setShrinkAllColumns(true);
        // pourquoi l'aréthmique sur char ne fonctionne pas ?
        String[] a = {"A", "B", "C", "D", "E","F","G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
                "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" };
        int adx=0;
        /* todo: create Rows dynamically too */
        ArrayList<TableRow> trlist = new ArrayList<>();
        trlist.add((TableRow) findViewById(R.id.tr1));
        trlist.add((TableRow) findViewById(R.id.tr2));
        trlist.add((TableRow) findViewById(R.id.tr3));
        trlist.add((TableRow) findViewById(R.id.tr4));
        trlist.add((TableRow) findViewById(R.id.tr5));

        for(int j = 0; j < 5; j++) {
            int max = 6;
            if(j == 4) max = 2;
            for (int i = 0; i < max; i++) {
                Button btn = new Button(this);
                btn.setText(a[adx]);
                btn.setOnClickListener(new clickHandler());
                trlist.get(j).addView(btn);
                if(disabled.contains(a[adx])) {
                    btn.setAlpha(0.4F);
                    btn.setEnabled(false);
                }
                adx++;
            }
        }



    }
    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onSaveInstanceState(Bundle state) {
        super.onSaveInstanceState(state);
        state.putSerializable(CURRENT_WORD, word);
        state.putSerializable(CURRENT_LEFT, tries_left);
        state.putSerializable(CURRENT_WRONG, wrong);
        state.putSerializable(CURRENT_CORRECT, correct);
        state.putSerializable(CURRENT_DISABLED, disabled);
    }


    private class clickHandler implements View.OnClickListener {
        public void onClick(View view) {
            Button btn = (Button)view;
            TextView tvf = findViewById(R.id.tv_wrong);
            TextView tvl = findViewById(R.id.tv_left);

            Toast.makeText(GameActivity.this, ""+btn.getId(), Toast.LENGTH_SHORT).show();
            if(!Verify(btn.getText())) {
                --tries_left;
                if(tries_left == 0) {

                }
            }
            display();
            btn.setAlpha(0.4f);
            btn.setEnabled(false);
            disabled += btn.getText();
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
    /* todo : use a char */
    private boolean Verify(CharSequence ch) {
        String c = (String)ch;
        if(word.contains(c.toUpperCase())) {
            correct += c.toUpperCase();
            return true;
        } else {
            wrong += c.toUpperCase();
            return false;
        }
    }

    private void setWord() {
        InputStream instream = null;
        try {
            instream = getResources().openRawResource(R.raw.wordlist);
            /* ins = getResources().openRawResource(getResources().getIdentifier(
                    "questions.txt", "raw", getPackageName()));*/
        } catch (Exception e) {
            Log.e("MockExam I/O", "failed opening InputStream");
            e.printStackTrace();
        }

        if (instream == null) {
            Log.e("MockExam I/O", "Cannot open raw/wordlist.txt as stream");
            return;
        }
        BufferedReader br = new BufferedReader(new InputStreamReader(instream));
        wordlist = new ArrayList<String>();
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

}
