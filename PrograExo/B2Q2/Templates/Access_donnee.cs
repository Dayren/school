using System;
using System.Data;
using System.Data.SqlClient;



// Start by assigning a connection string
string sqlconnstr = "Server=HOSTNAME\\SQLEXPRESS;Database=DatabaseName;User Id=user;Password=password;";
string sqlconnstr = Properties.Settings.Default.SqlConnectionString;    // IN SETTINGS, not resources


public DataSet getDataSet(string condition) {
    // init values
    SqlDataAdapter dtad;
    SqlCommand cmd;
    DataSet ds = new DataSet();
    SqlConnection conn = new SqlConnection();
    string cmdstr;

    // connect to db
    conn.ConnectionString = sqlconnstr;
    conn.Open();

    // configure your command
    cmdstr = "SELECT * FROM Table WHERE name like @nom";
    cmd = new SqlCommand(cmdstr, conn);
    cmd.Parameters.AddWithValue("@nom", "%" + "name" + "%");    // do not add '' in cmdstr, if you add % in Params.

    // request > adaptater > dataset
    dtad = new SqlDataAdapter(cmd);
    dtad.Fill(ds, "Table");

    // Debug, close and return
    Debug.WriteLine(ds.GetXml());
    conn.Close();
    return ds;
}

public bool addEntry(int K, string name) {
    SqlConnection conn;
    SqlCommand cmd;
    string cmdstr;
    bool success;

    // connect
    conn.ConnectionString = sqlconnstr;
    conn.Open();

    // set command
    cmdstr = "INSERT [Table] (Param1, Param2)" +
             "VALUES (@p1, @p2)";
    cmd = new SqlCommand(cmdstr, conn);
    cmd.Parameters.AddWithValue("@p1", K);
    cmd.Parameters.AddWithValue("@p2", name);

    // try & debug
    try {
        cmd.ExecuteNonQuery();
        success = true;
    } catch (SqlException sex) {
        success = false;
        Debug.WriteLine(sex.Message.ToString());
        foreach (SqlError se in sex.Errors) {
            Debug.WriteLine("{0}: L{1}- {2}", se.Number, se.LineNumber, se.Message.ToString()));
        } throw sex;
    }

    // close and return
    conn.Close();
    return success;    
}


public DataRow getDR(DataSet ds) {
    DataRow dr = null;
    // if ds doesn't  exist or is empty
    if (ds != null || ds.Tables.Count < 1) {
        return dr;
    // if content of DS isn't the right one
    } else if (!DataSet.Tables.Contains("Table")) {
        return dr;
    // if Table doesn't have any entries
    } else if (!ds.Tables.Rows.Count < 1) {
        return dr;
    } else
        dr = ds.Tables.Rows[0];

    return dr;
}