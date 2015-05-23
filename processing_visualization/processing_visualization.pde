import processing.pdf.*;

boolean saveFrame;
JSONArray data;

void setup() {
  size(400, 400);
  saveFrame = false;
  frameRate(10);
  
  data = importData();
}

void draw() {
  background(255, 255, 255);
  
  if (saveFrame) {
    beginRecord(PDF, "screen-" + currentTimestamp() + ".pdf");
  }
  
  noStroke();
  fill(0);
  
  float columnWidth = width / data.size();
  float maxHeight = height;
  
  float maxValue = data.getJSONObject(0).getFloat("population");
  for (int i = 0; i < data.size(); i++) {
    maxValue = max(maxValue, data.getJSONObject(i).getFloat("population"));
  }
  
  for (int i = 0; i < data.size(); i++) {
    JSONObject state = data.getJSONObject(i);
    float barHeight = (state.getFloat("population") / maxValue) * maxHeight;
    rect(columnWidth * i, height - barHeight, columnWidth, barHeight);
  }
  
  if (saveFrame) {
    endRecord();
    saveFrame = false;
  }
}

JSONArray importData() {
  JSONObject json = loadJSONObject("states.json");
  return json.getJSONArray("states");
}

String currentTimestamp() {
    return year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
}

void mousePressed() {
  saveFrame = true;
}
