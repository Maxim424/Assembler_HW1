#include <stdio.h>

int length;
int i;
int sum;

int main() {
  printf("Input length: ");
  scanf("%d", &length);

  if(length < 1 || length > 2000) {
    printf("Incorrect length = %d\n", length);
    return 1;
  }
  
  int a[length];
  int b[length];

  for(i = 0; i < length; ++i) {
    printf("a[%d]? ", i);
    scanf("%d", a + i);
  }

  for(i = 0; i < length; ++i) {
    if (a[i] < 0) {
        b[i] = -1;
    } else if (a[i] > 0) {
        b[i] = 1;
    } else {
        b[i] = 0;
    }
  }
  
  printf("\n");
  
  for(i = 0; i < length; ++i) {
    printf("b[%d] = %d\n", i, b[i]);
  }

  return 0;
}