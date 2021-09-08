PrintWriter output;
int hs;

void setup() {
  size(100, 100);
  parseFile();
  output = createWriter("HS.txt");
  output.println(str(hs+1));
}

void draw() {
}

void keyPressed() {
  output.flush();
  output.close();
  exit();
}

void parseFile() {
  // Open the file from the createWriter() example
  BufferedReader reader = createReader("HS.txt");
  String line = null;
  try {
    while ((line = reader.readLine()) != null) {
      hs = int(line);
      println(hs);
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
} 
