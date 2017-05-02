import java.util.*;
Table table;
int visaSum = 0;
int sum2015 = -1;
int Sum2013 = -1;
int Sum2014 = -1;
int maxSum = -1;
ArrayList<CountryData> countryDatas = new ArrayList<CountryData>();
void setup() 
{
  size(1200,700);
  table = loadTable("US Visa Statistics - Refugees.csv");
  printTable();
  Collections.sort(countryDatas);
  
  renderCircles();
}

void printTable()
{
  for (TableRow row : table.rows()) 
  {
     CountryData cd = new CountryData();
     cd.name =  row.getString(0);
     cd.renderColor = color(random(128)+128,0,0);
     if(cd.name.equals("Iraq") || cd.name.equals("Iran") || 
     cd.name.equals("Syria") || cd.name.equals("Yemen") ||  
     cd.name.equals("Sudan") || cd.name.equals("Libya") ||  
     cd.name.equals("Somalia")){
       cd.renderColor = color(0,255,0); 
       cd.banned = true;
     }
     cd.sum2013 = getCommaSeparatedInt(row.getString(1));
     cd.sum2014 =getCommaSeparatedInt(row.getString(2));
     cd.sum2015 =getCommaSeparatedInt(row.getString(2));
     cd.total = cd.sum2013 + cd.sum2014 + cd.sum2015;
     visaSum += cd.total;
     maxSum = max(maxSum,cd.total);
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



void renderCircles()
{
  pushMatrix();

  float circRad = width*1.f/countryDatas.size();
  for(CountryData cd : countryDatas)
  {
    float circRadius = max(3,cd.total*300/maxSum);
    fill(cd.renderColor);
    noStroke();
    ellipse(0,random(height),circRadius,circRadius);
//    if(cd.banned)
//    {
//      fill(0);
//      pushMatrix();
//      translate(0,height-rectHeight);
//      rotate(-1);
//      text(cd.name+" - " + cd.total,0,0);
//      popMatrix();
//    }
    translate(circRad,0);
  }
  popMatrix();
}
