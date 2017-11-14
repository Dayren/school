package fpluquet.be.quizz.views;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.nio.Buffer;
import java.util.ArrayList;

import fpluquet.be.quizz.R;
import fpluquet.be.quizz.models.QuestionModel;

public class MainActivity extends AppCompatActivity {

    private static final int QUESTION_RESULT = 1;
    private ArrayList<QuestionModel> questions;
    private int currentQuestionIndex = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        setQuestionsTxt();
        launchNextQuestion();
    }

    private void setQuestions() {
        questions = new ArrayList<>();

        // todo : au lieu de ces questions, lisez les questions depuis le fichier questions.txt dans le dossier raw des ressources
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
        currentQuestionIndex ++;
        if(currentQuestionIndex >= questions.size()) {
            Toast.makeText(this, "Plus de questions...", Toast.LENGTH_SHORT).show();
            return;
        }
        QuestionModel question = questions.get(currentQuestionIndex);
        Intent intent = new Intent(this, QuestionActivity.class);
        intent.putExtra(QuestionActivity.QUESTION, question);

        startActivityForResult(intent, QUESTION_RESULT);
    }

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

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == QUESTION_RESULT && resultCode == RESULT_OK) {
            boolean isCorrect = data.getBooleanExtra(QuestionActivity.IS_CORRECT, false);
            String toShow;
            if(isCorrect){
                toShow = "Bravo !";
            } else {
                toShow = "Perdu :(";
            }
            Toast.makeText(this, toShow, Toast.LENGTH_SHORT).show();
            launchNextQuestion();
        }
    }

    // todo : retenez la question courante au cas où l'activité est relancée (rotation)
    // todo : ajoutez une fonctionnalité "continuer la dernière partie" (le numéro de la question courante est alors sauvé dans un fichier)
    // todo : ajoutez le score courant (à sauver dans le fichier)
    // todo : retenez dans la base de données toutes les parties (la date et le score obtenu)

}
