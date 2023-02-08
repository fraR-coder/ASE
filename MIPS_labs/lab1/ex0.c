/*____________________________
< this is a simple c program >
 ----------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
*/

#include <stdio.h>
#include <stdlib.h>

#define N 3
int main(int argc, char** argv) {

    int* a,*b,*c;

    a=(int*)malloc(N*sizeof(int));
    b=(int*)malloc(N*sizeof(int));
    c=(int*)calloc(N,sizeof(int));

    for(int i=0;i<N;i++){
        a[i]=i*10;
        b[i]=i+2;

    }
    printf("a:\n");
    for(int i=0;i<N;i++){
        printf("%d ",a[i]);
    
    }
    printf("\nb:\n");
    for(int i=0;i<N;i++){
        printf("%d ",b[i]);
    
    }

    for(int i=0;i<N;i++){
        c[i]=a[i]+b[i];
    }
    printf("\nc:\n");
    for(int i=0;i<N;i++){
        printf("%d ",c[i]);
    
    }




   
   return 0;
}

