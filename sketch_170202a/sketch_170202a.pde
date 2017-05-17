import java.util.*;
Table table;
int visaSum = 0;
int maxSum = -1;
ArrayList<CountryData> countryDatas = new ArrayList<CountryData>();
void setup() 
{
  size(1200,720);
  table = loadTable("US Visa Statistics - Green cards.csv");
  
  
  
printTable();
Collections.sort(countryDatas);
renderPieChart();
renderBars();
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

void renderPieChart()
{
  float piRadius = min(width,height);
  float arcStart = 0;
  pushMatrix();
  translate(width/2.f,height/2.f);
  for(CountryData cd : countryDatas)
  {
    float arcW = cd.total*TWO_PI/visaSum;
    fill(cd.renderColor);
    noStroke();
    arc(0, 0, piRadius, piRadius, arcStart, arcStart+arcW, PIE);
    arcStart += arcW;
  }
  popMatrix();
}

void renderBars()
{
  pushMatrix();

  float rectWidth = width*1.f/countryDatas.size();
  for(CountryData cd : countryDatas)
  {
    float rectHeight = cd.total*height/maxSum;
    fill(cd.renderColor);
    noStroke();
    rect(0,height,rectWidth,-rectHeight);
    if(cd.banned)
    {
      fill(0);
      pushMatrix();
      translate(0,height-rectHeight);
      rotate(-1);
      text(cd.name+" - " + cd.total,0,0);
      popMatrix();
    }
    translate(rectWidth,0);
  }
  popMatrix();
}
