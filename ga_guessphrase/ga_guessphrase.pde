class DNA {
  
  char[] genes;
  float fitness;
  
  DNA(int num) {
    genes = new char[num];
    for (int i = 0; i < genes.length; i++) {
      genes[i] = (char) random(32, 128);
    }
  }
  
  void fitness(String target) {
    int score = 0;
    for (int i = 0; i < genes.length; i++) {
      if (genes[i] == target.charAt(i)) {
        score++;
      }
    }
    fitness = pow(2, score);
  }
  
  DNA crossover(DNA partner) {
    DNA child = new DNA(genes.length);
    int midpoint = int(random(genes.length));
    for (int i = 0; i < genes.length; i++) {
      if (i > midpoint) child.genes[i] = genes[i];
      else child.genes[i] = partner.genes[i];
    }
    
    return child;
  }
  
  void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = (char) random(32, 128);
      }
    }
  }
  
  String getPhrase() {
    return new String(genes);
  }
  
}

class Population {
  DNA[] population;
  String target;
  float mutationRate;
  int generation;
  ArrayList<DNA> matingPool;
  boolean finished;
  int perfectscore;
  
  Population(String p, float m, int num) {
    target = p;
    mutationRate = m;
    population = new DNA[num];
    for (int i = 0; i < population.length; i++) {
      population[i] = new DNA(target.length());
    }
    calcfitness();
    matingPool = new ArrayList<DNA>();
    finished = false;
    generation = 0;
    perfectscore = int(pow(2, target.length()));
    
  }
  
  void calcfitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness(target);
    }
  }
  
  void natureselection() {
    matingPool.clear();
    float maxfitness = 0;
    for(int i = 0; i < population.length; i++) {
      if(population[i].fitness > maxfitness) {
        maxfitness = population[i].fitness;
      }
    }
    for (int i = 0; i < population.length; i++) {
      float fitnessf = map(population[i].fitness, 0, maxfitness, 0, 1);
      int n = int(fitnessf * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }
  
  void generate() {
    for (int i = 0; i < population.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      DNA partnerA = matingPool.get(a);
      DNA partnerB = matingPool.get(b);
      DNA child = partnerA.crossover(partnerB);
      child.mutate(mutationrate);
      population[i] = child;
    }
    generation++;
  }
  
  String getbest() {
    float record = 0.0f;
    int index = 0;
    for (int i = 0; i < population.length; i++) {
      if(population[i].fitness > record) {
        index = i;
        record = population[i].fitness;
      }
      
    }
    
    if (record == perfectscore) finished = true;
    return population[index].getPhrase();
    
  }
  
  boolean finished() {
    return finished;
    
  }
  
  int getgenerations() {
    return generation;
  }
  
  float getaveragefitness() {
    float total = 0;
    for (int i = 0; i < population.length; i++) {
      total = total + population[i].fitness;
    }
    return total / population.length;
    
  }
  
  String allphrase() {
    String all = "";
    int limit = min(population.length, 50);
    for (int i = 0; i < limit; i++) {
      all += population[i].getPhrase() + "\n";
      
    }
    return all;
    
    
  }
  
}


PFont f;
String target;
float mutationrate;
int popmax;
Population population;

void setup() {
  size(600, 200);
  f = createFont("Courier", 32, true);
  target = "Deus Ex Machina.";
  popmax = 150;
  mutationrate = 0.03;
  population = new Population(target, mutationrate, popmax);
}

void display() {
  background(255);
  String answer = population.getbest();
  textFont(f);
  textAlign(LEFT);
  fill(0);
  
  textSize(16);
  text("best phrase:", 20, 30);
  textSize(32);
  text(answer, 20, 75);
  
  textSize(12);
  text("total generations: "+population.getgenerations(), 20, 140);
  text("average fitness: "+nf(population.getaveragefitness(), 2, 3), 20, 155);
  text("total population: " + popmax, 20, 170);
  text("mutation rate: " + mutationrate, 20, 185);
  
  textSize(10);
  text("all phrase:\n" + population.allphrase(), 450, 10);
}