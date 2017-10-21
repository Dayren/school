 private void CreateList()
{
    listView1.View = View.Details;

    listView1.Columns.Add("Icon", -2, HorizontalAlignment.Center);

    listView1.Columns.Add("Name", -2, HorizontalAlignment.Left);

    imageList1.ImageSize = new Size(32, 32);

    for (int i = 0; i < subKeys.Length; i++)
    {
        if (subKeys[i].Contains("App"))
        {
            imagePath = subKeys[i];

            if (System.IO.File.Exists(imagePath))
            {
                imageList1.Images.Add(Image.FromFile(imagePath));
            }

            numberOfImages++;
        }
    }

    listView1.StateImageList = this.imageList1;
}


-------
Change

listView1.StateImageList = this.imageList1;

To

listView1.SmallImageList = this.imageList1;

And make sure that you are setting the ImageIndex, or ImageKey properties for each ListItem.

listItem.ImageIndex = 0; // or,
listItem.ImageKey = "myImage";




 -------

 DirectoryInfo dir = new DirectoryInfo(@"c:\myPicutures"); //change and get your folder
        foreach (FileInfo file in dir.GetFiles())
        {
            try
            {
                this.imageList1.Images.Add(Image.FromFile(file.FullName));
            }
            catch{
                Console.WriteLine("This is not an image file");
            }
        }
        this.listView1.View = View.LargeIcon;
        this.imageList1.ImageSize = new Size(32, 32);
        this.listView1.LargeImageList = this.imageList1;
        //or
        //this.listView1.View = View.SmallIcon;
        //this.listView1.SmallImageList = this.imageList1;

        for (int j = 0; j < this.imageList1.Images.Count; j++)
        {
            ListViewItem item = new ListViewItem();
            item.ImageIndex = j;
            this.listView1.Items.Add(item);
        }






There are several ways to do it, but here is one solution (for 4 columns).

string[] row1 = { "s1", "s2", "s3" };
listView1.Items.Add("Column1Text").SubItems.AddRange(row1);

And a more verbose way is here:

ListViewItem item1 = new ListViewItem("Something");
item1.SubItems.Add("SubItem1a");
item1.SubItems.Add("SubItem1b");
item1.SubItems.Add("SubItem1c");

ListViewItem item2 = new ListViewItem("Something2");
item2.SubItems.Add("SubItem2a");
item2.SubItems.Add("SubItem2b");
item2.SubItems.Add("SubItem2c");

ListViewItem item3 = new ListViewItem("Something3");
item3.SubItems.Add("SubItem3a");
item3.SubItems.Add("SubItem3b");
item3.SubItems.Add("SubItem3c");

ListView1.Items.AddRange(new ListViewItem[] {item1,item2,item3});






Images that you added in Image list are added to the ImageList.ImageCollection, so it is collection type then you can use most of the collection methods.

Use the Images property to add, remove and access the image to display in background of panel. Add(key,image)
Remove()
RemoveAt()
RemoveByKey()

Check the example on the ImageList Class documentation to understand that how pragmatically use all of these methods.

Add Image:

imageList1.Images.Add("pic1", Image.FromFile("c:\\mypic.jpg"));

Remove Image from collection:

imageList1.Images.RemoveAt(listBox1.SelectedIndex);
imageList1.Images..RemoveByKey("pic1");

To access images, get image from the imagecollection

panel1.BackgroundImage = imageList1.Images[0];

or

panel1.BackgroundImage = imageList1.Images["pic1"];

