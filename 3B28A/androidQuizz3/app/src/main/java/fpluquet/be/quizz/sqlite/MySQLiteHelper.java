package fpluquet.be.quizz.sqlite;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;

import fpluquet.be.quizz.models.GameModel;

/**
 * Created by Touko on 11/14/2017.
 * source : http://hmkcode.com/android-simple-sqlite-database-tutorial/
 */

public class MySQLiteHelper extends SQLiteOpenHelper {
    private static final String DB_NAME = "ScoreDB";
    private static final int DB_VERSION = 1;

    /* column names */
    private static final String SCORES_T = "scores";
    private static final String KEY_C = "id";
    private static final String DATE_C = "date";
    private static final String SCORE_C = "score";

    private static final String[] COLUMNS = {KEY_C, DATE_C, SCORE_C };


    public MySQLiteHelper(Context context) {
        super(context,DB_NAME, null, DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        // create the table
        String createstr = "CREATE TABLE scores ( " +
                "id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                "date TEXT, " +
                "score TEXT )";
        db.execSQL(createstr);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // Drop old table
        db.execSQL("DROP TABLE IF EXISTS scores");
        this.onCreate(db);
    }

    public void addScore(GameModel gm) {
        Log.v("SQLquizz", gm.toString());

        // get reference to writable DB
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put(DATE_C, gm.getDate());
        values.put(SCORE_C, gm.getScore());

        db.insert(SCORES_T, null, values);

        db.close();
    }

    // todo : getHighest Score instead
    // but it's late, and I already drank too much wine to bother with SQL.
    public GameModel getLastScore() {
        SQLiteDatabase db = this.getReadableDatabase();
        Cursor c = db.query(SCORES_T, COLUMNS, null, null, null,
                                             null, KEY_C + " DESC", null);

        Log.d("getLastScore", c.toString());

        if( c == null) return null;
        c.moveToFirst();

        GameModel gm = new GameModel(Integer.parseInt(c.getString(0)),
                                     c.getString(1), c.getString(2));

        Log.v("getLastScore", gm.toString());
        return gm;

    }
}


















