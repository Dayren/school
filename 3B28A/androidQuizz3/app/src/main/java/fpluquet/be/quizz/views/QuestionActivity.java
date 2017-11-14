package fpluquet.be.quizz.views;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

import fpluquet.be.quizz.R;
import fpluquet.be.quizz.exceptions.InternalGameException;
import fpluquet.be.quizz.models.QuestionModel;


public class QuestionActivity extends AppCompatActivity {

    public static final String QUESTION = "be.helha.android.QUESTION";
    public static final String IS_CORRECT = "be.helha.android.IS_CORRECT";

    private QuestionModel question;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_question);

        question = (QuestionModel) getIntent().getSerializableExtra(QUESTION);

        if(question == null){
            throw new InternalGameException("No question passed to QuestionModel activity");
        }

        setQuestion(question);
    }

    private void setQuestion(QuestionModel question) {

        TextView questionTV = (TextView) findViewById(R.id.question);
        questionTV.setText(question.getText());

        RadioGroup radioGroup = getRadioGroup();
        for(String answer: question.getRandomizedAnswers()){
            RadioButton rb = new RadioButton(this);
            rb.setText(answer);
            rb.setPadding(0,0,0, 20);
            rb.setTextAppearance(this, android.R.style.TextAppearance_Large);
            radioGroup.addView(rb);
        }
    }

    private RadioGroup getRadioGroup() {
        return (RadioGroup) findViewById(R.id.answersRG);
    }

    public void onValidateClick(View view){
        RadioButton radioButton = (RadioButton) findViewById(getRadioGroup().getCheckedRadioButtonId());
        if(radioButton == null){
            Toast.makeText(this, "Vous devez sélectionner une réponse", Toast.LENGTH_SHORT).show();
            return;
        }
        Intent intent = new Intent();
        boolean isCorrect = question.isCorrectAnswer(radioButton.getText().toString());
        intent.putExtra(IS_CORRECT, isCorrect);
        setResult(RESULT_OK, intent);
        finish();
    }


}
