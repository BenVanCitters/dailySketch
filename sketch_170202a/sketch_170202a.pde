
Table table;
int visaSum = 0;
ArrayList<CountryData> countryDatas = new ArrayList<CountryData>();
void setup() 
{
  size(500,500);
  table = loadTable("US Visa Statistics - Green cards.csv");
  
printTable();
}

void printTable()
{
  
   for (TableRow row : table.rows()) 
   {
     CountryData cd = new CountryData();
     cd.name =  row.getString(0);;
     cd.sum2013 = getCommaSeparatedInt(row.getString(1));
     cd.sum2014 =getCommaSeparatedInt(row.getString(2));
     cd.sum2015 =getCommaSeparatedInt(row.getString(2));
     cd.total = cd.sum2013 + cd.sum2014 + cd.sum2015;
     visaSum += cd.total;
     countryDatas.add(cd);
     println(cd.name + " - " + cd.sum2013 + " - " + cd.sum2014 + " - " + cd.sum2015);
   }
}

int getCommaSeparatedInt(String num)
{
  num = num.replace("," , "");
  int result = 0;
  try{
    result = Integer.parseInt(num);
  } catch(Exception e)
  {
    println(e);
  }
  
  return result;
}

void draw()
{
  
}
