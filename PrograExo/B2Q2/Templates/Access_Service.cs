class Access_Service
{
    ////////////////////////////////////////////////////////
    //  right-click on Projet > Add > Service Reference   //
    ////////////////////////////////////////////////////////

    static ServiceReference1.ServiceSoapClient wsr = new ServiceReference1.ServiceSoapClient("ServiceSoap");

    public string Test() {
        // test the helloWorld function on service
        string str = wsr.HelloWorld();
        Debug.WriteLine(str);
        return str;
    }

    public int getIntFromDataSet() {
        DataSet ds = new DataSet();
        ds = wsr.getDataSet();
        int i;
        if (ds.Tables.Contains["Table"]) { 
            DataRow dr = ds[Table].Rows[0];
            i = (int)dr["Collumn"];
            Debug.WriteLien("i=" + i.ToString());
        }
        else {
            Debug.WriteLine("failed to find Table");
            i = -1;
        }
        return i;
    }


    public void loadTournoi() {
        Main.Tournois.Clear();
        refreshCount();
        DataTable dt = new DataTable();
        dt = wsr.getOrgaTournoiID().Tables["OrgaTour"];

        foreach (DataRow dr in dt.Rows) {
            Tournoi t = getTournoi((int)dr["TournoiID"]);
            Main.Tournois.Add(t);
            Debug.WriteLine(t.Nom + " - " + t.Jeu);
        }
    }
}

class Service
{
    [WebMethod]
    public string HelloWorld() {
        return "Hello World!";
    }
}