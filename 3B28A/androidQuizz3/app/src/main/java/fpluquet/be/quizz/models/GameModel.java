package fpluquet.be.quizz.models;

/**
 * Created by Touko on 11/14/2017.
 */

public class GameModel {
    private int id;
    private String date;
    private String score;

    public GameModel() {}

    public GameModel(String date, String score) {
        super();
        this.date = date;
        this.score = score;
    }
    public GameModel(int id, String date, String score) {
        super();
        this.date = date;
        this.score = score;
    }

    public String getDate() {
        return date;
    }

    public String getScore() {
        return score;
    }

    @Override
    public String toString() {
        return score + " [" + date + "]";
    }

}