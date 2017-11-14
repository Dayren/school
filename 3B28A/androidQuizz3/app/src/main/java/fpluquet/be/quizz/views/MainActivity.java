package fpluquet.be.quizz.views;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.nio.Buffer;
import java.util.ArrayList;

import fpluquet.be.quizz.R;
import fpluquet.be.quizz.models.QuestionModel;

public class MainActivity extends AppCompatActivity {

    private static final int QUESTION_RESULT = 1;
    private ArrayList<QuestionModel> questions;
    private int currentQuestionIndex = -1;
    /* [1] */
    private static final String CURRENT_QUESTION_INDEX = "fpluquet.be.quizz.currentQuestionIndex";
    /* [2] */
    private static final String FILENAME = "qnum-score";
    /* [3] */
    private int currentScore = 0;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setQuestionsTxt();
        Log.d("androquizz", "on create with "+currentQuestionIndex);
        loadfromfile();
        if(savedInstanceState != null) {
            currentQuestionIndex = savedInstanceState.getInt(CURRENT_QUESTION_INDEX);
            Log.d("androquizz", "got "+currentQuestionIndex);
        }
        launchNextQuestion();
    }
    @Override
    protected void onStart() {
        super.onResume();
        TextView score = (TextView) findViewById(R.id.tv_score);
        score.setText(currentScore + "/" + questions.size());
        Log.v("androQuizz", "onResume() called");
    }
    private void setQuestions() {
        questions = new ArrayList<>();
        // add a first question
        QuestionModel question = new QuestionModel();
        question.setText("Quelle est la capitale de la Belgique ?");
        question.addAnswer("Bruxelles");
        question.addAnswer("Paris");
        question.addAnswer("Montréal");
        question.addAnswer("Djibouti");
        questions.add(question);

        // add a second question
        QuestionModel question2 = new QuestionModel();
        question2.setText("Le cours d'Android est :");
        question2.addAnswer("On verra à l'examen");
        question2.addAnswer("Simple");
        question2.addAnswer("A l'aise");
        question2.addAnswer("Quel cours d'Android ?");
        questions.add(question2);

        // initialize the current question index
        currentQuestionIndex = -1;
    }
    private void launchNextQuestion() {
        if (currentQuestionIndex < 0) {
            Toast.makeText(this, "Erreur question < 0", Toast.LENGTH_LONG).show();
            return;
        }
        if(currentQuestionIndex >= questions.size()) {
            Toast.makeText(this, "Plus de questions...", Toast.LENGTH_SHORT).show();
            return;
        }
        QuestionModel question = questions.get(currentQuestionIndex);
        Intent intent = new Intent(this, QuestionActivity.class);
        intent.putExtra(QuestionActivity.QUESTION, question);


        startActivityForResult(intent, QUESTION_RESULT);
            // ???? question : pourquoi avoir placé currentQuestionIndex au début de la fonction et init avec -1 todo
        saveinfile();
        currentQuestionIndex++;
        Log.d("androQuizz", "start question " + (currentQuestionIndex - 1));

    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == QUESTION_RESULT && resultCode == RESULT_OK) {
            boolean isCorrect = data.getBooleanExtra(QuestionActivity.IS_CORRECT, false);
            String toShow;
            if(isCorrect){
                toShow = "Bravo !";
                currentScore++;
            } else {
                toShow = "Perdu :(";
            }
            Toast.makeText(this, toShow, Toast.LENGTH_SHORT).show();
            launchNextQuestion();
        }
    }


    // todo[0] (done) : au lieu de ces questions, lisez les questions depuis le fichier questions.txt dans le dossier raw des ressources
    private void setQuestionsTxt() {
        questions = new ArrayList<>();

        InputStream ins = null;
        try {
            ins = getResources().openRawResource(R.raw.questions);
            /* ins = getResources().openRawResource(getResources().getIdentifier(
                    "questions.txt", "raw", getPackageName()));*/
        } catch (Exception e) {
            Log.e("androquizz", "failed opening InputStream");
            e.printStackTrace();
        }

        if (ins == null) {
            Log.e("androquizz", "Cannot open raw/questions.txt as stream");
            return;
        }
        BufferedReader br = new BufferedReader(new InputStreamReader(ins));
        QuestionModel qm;
        while((qm = getQuestion(br)) != null)
            questions.add(qm);

        currentQuestionIndex = 0;
    }
    private QuestionModel getQuestion(BufferedReader br) {
        QuestionModel qm = new QuestionModel();
        String answer = "";

        qm.setText(getLine(br));
        if(qm.getText()=="" || qm.getText()==null) return null;

        while((answer = getLine(br))!= null && !answer.isEmpty()) {
            qm.addAnswer(answer);
            if(qm.isCorrectAnswer(null)|| qm.isCorrectAnswer("")) {
                qm.setCorrectAnswer(answer);
            }
        }
        Log.v("androQuizz", "added: " + qm.getText());

        return qm;
    }
    private String getLine(BufferedReader br) {
        String line = "";
        try {
            line = br.readLine();
            //Log.d("androQuizz", line);
        } catch (IOException e) {
            Log.e("androquizz", "IOException: failed to read buffer");
        }
        return line;
    }




    // done todo[1] : retenez la question courante au cas où l'activité est relancée (rotation) (fonction sans rien faire)
    @Override
    protected void onSaveInstanceState(Bundle outState) {
        outState.putInt(CURRENT_QUESTION_INDEX, currentQuestionIndex);
    }

    // todo[2] : ajoutez une fonctionnalité "continuer la dernière partie" (le numéro de la question courante est alors sauvé dans un fichier)
    // todo[3] : ajoutez le score courant (à sauver dans le fichier)
    private void saveinfile() {
        File file = new File(getApplicationContext().getFilesDir(), FILENAME);
        try{
            OutputStreamWriter ostw = new OutputStreamWriter(new FileOutputStream(file));
            if (ostw != null) {
                BufferedWriter bw = new BufferedWriter(ostw);
                try {
                    bw.write(currentQuestionIndex);
                    bw.write(currentScore);
                    bw.flush();
                    bw.close();
                }catch (IOException ioe) {
                    Log.e("androQuizz", "file: error on writing in buffer");
                    ioe.printStackTrace();
                }
            } else {
                Log.e("androQuizz", "file: error streamwriter is null");
            }
            ostw.close();
        } catch (IOException ioe) {
            Log.e("androQuizz", "file: error on writing stream");
            ioe.printStackTrace();
        }
    }
    private void loadfromfile() {
        File file = new File(getApplicationContext().getFilesDir(), FILENAME);
        if (!file.exists()) Log.d("androQuizz", "file doesn't exist");
        try{
            InputStreamReader istr = new InputStreamReader(new FileInputStream(file));
            int i = 0;
            if (istr != null) {
                BufferedReader br = new BufferedReader(istr);
                try {
                    if ((i = br.read()) < 0) {
                        i =0;
                    }
                    currentQuestionIndex = i;
                    if ((i = br.read()) < 0) {
                        i = 0;
                    }
                    currentScore = i;

                } catch (IOException ioe) {
                    Log.e("androQuizz", "file: error on reading from buffer");
                    ioe.printStackTrace();
                }
                br.close();
            }
            istr.close();
        } catch (IOException ioe) {
            Log.e("androQuizz", "file: error on read stream");
            ioe.printStackTrace();
        }
        Log.v("androQuizz", "saveqnum: loaded " + currentQuestionIndex + " & " + currentScore);
    }

    // todo[4] : retenez dans la base de données toutes les parties (la date et le score obtenu)


}
