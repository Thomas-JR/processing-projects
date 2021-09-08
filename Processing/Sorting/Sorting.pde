float[] list;
int listLength = 1900;
int max = 10;
int iterations = 0;
int SORTING_ALGORITHM = 3;

void setup() {
  size(1900, 500);
  list = new float[listLength];
  for (int i = 0; i < listLength; i++) {
    list[i] = random(0, max);
  }
  noStroke();
  colorMode(HSB);
}

void draw() {
  background(0);
  if (SORTING_ALGORITHM == 0 && iterations < listLength) {
    selectionSort(iterations);
  }
  if (SORTING_ALGORITHM == 1 && iterations > 0 && iterations < listLength) {
    insertionSort(iterations);
  }
  if (SORTING_ALGORITHM == 2 && iterations < listLength) {
    quicksort(iterations, listLength);
  }
  if (SORTING_ALGORITHM == 3) {
    heapSort(listLength-iterations, iterations);
  }
  show();
  iterations++;
}

void show() {
  float widthRange = listLength;
  for (int i = 0; i < listLength; i++) {
    fill(map(list[i], 0, max, 50, 235), 255, 255);
    rect(width/widthRange*float(i), height-list[i]*height/(max), width/widthRange, list[i]*height/(max));
  }
}

void selectionSort(int iterations) {
  int min = iterations;
  for (int i = iterations+1; i < listLength; i++) {
    if (list[i] < list[min]) {
      min = i;
    }
  }
  swap(min, iterations);
}

void swap(int a, int b) {
  float temp = list[a];
  list[a] = list[b];
  list[b] = temp;
}

void insertionSort(int iteration) {
  float k = list[iteration];
  int j = iteration - 1;

  while (j >= 0 && list[j] > k) {
    list[j + 1] = list[j];
    j = j - 1;
  }
  list[j + 1] = k;
}

void quicksort(int min, int max) {
  if (min < max) {
    int p = lomuto(min, max);
    quicksort(min, p-1);
    quicksort(p+1, max);
  }
}

int lomuto(int min, int max) {
  float p = list[min];
  int s = min;
  for (int i = min+1; i < max; i++) {
    if (list[i] < p) {
      s++;
      swap(s, i);
    }
  }
  swap(min, s);
  return s;
}

// To heapify a subtree rooted with node i which is
// an index in arr[]. n is size of heap
void heapify(int n, int i) {
  int largest = i; // Initialize largest as root
  int l = 2 * i + 1; // left = 2*i + 1
  int r = 2 * i + 2; // right = 2*i + 2

  // If left child is larger than root
  if (l < listLength && list[l] > list[largest])
    largest = l;

  // If right child is larger than largest so far
  if (r < listLength && list[r] > list[largest])
    largest = r;

  // If largest is not root
  if (largest != i) {
    swap(i, largest);

    // Recursively heapify the affected sub-tree
    heapify(n, largest);
  }
}

void heapSort(int n, int root) {
  // Build heap (rearrange array)
  for (int i = n / 2 - 1; i >= root; i--)
    heapify(listLength, root);

  // One by one extract an element from heap
  for (int i = n - 1; i > 0; i--) {
    // Move current root to end
    swap(0, i);

    // call max heapify on the reduced heap
    heapify(i, 0);
  }
}
