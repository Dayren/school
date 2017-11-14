package fpluquet.be.quizz.models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import fpluquet.be.quizz.exceptions.InternalGameException;

/**
 * Created by fpluquet on 26/10/17.
 */

public class QuestionModel implements Serializable {

    private String text;
    private ArrayList<String> answers;
    private String correctAnswer;


    public QuestionModel(){
        answers = new ArrayList<>();
    }

    public boolean isCorrectAnswer(String answer) {
        return correctAnswer.equals(answer);
    }

    public void setCorrectAnswer(String correctAnswer) {
        if(!answers.contains(correctAnswer))
            throw new InternalGameException("Correct answer must be in current answers");
        this.correctAnswer = correctAnswer;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public void addAnswer(String answer){
        answers.add(answer);
        if(correctAnswer == null){
            setCorrectAnswer(answer);
        }
    }

    public ArrayList<String> getRandomizedAnswers(){
        ArrayList<String> answersClone = (ArrayList<String>) answers.clone();
        Collections.shuffle(answersClone);
        return answersClone;
    }
}
