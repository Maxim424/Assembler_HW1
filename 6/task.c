#include <stdio.h>

// Функция для вывода массива
void print_array(int b[], int length) {
    printf("\n");
    for(int i = 0; i < length; ++i) {
        printf("b[%d] = %d\n", i, b[i]);
    }
}

// Функция для заполнения массива b
void calculate(int a[], int b[], int length) {
    for(int i = 0; i < length; ++i) {
        if (a[i] < 0) {
            b[i] = -1;
        } else if (a[i] > 0) {
            b[i] = 1;
        } else {
            b[i] = 0;
        }
    }
}

// Функция main, точка входа в программу
int main() {
  int length;

  printf("Input length: ");
  scanf("%d", &length);

  if(length < 1 || length > 2000) {
    printf("Incorrect length = %d\n", length);
    return 1;
  }
  
  int a[length];
  int b[length];

  for(int i = 0; i < length; ++i) {
    printf("a[%d]? ", i);
    scanf("%d", a + i);
  }

  calculate(a, b, length);
  
  print_array(b, length);

  return 0;
}