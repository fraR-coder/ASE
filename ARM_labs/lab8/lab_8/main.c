extern int check_square(int x, int y, int r);
extern float my_division(float *area,float *rsquare);
extern int _Matrix_Coordinates;
extern char Opt_M_Coordinates;


extern int ASM_funct(char* string);

extern char _COLUMNS;
extern char _ROWS;
int main(void){

	volatile int* matrix=&_Matrix_Coordinates;
	volatile int row=_ROWS;
	volatile int col=_COLUMNS;
	volatile char* new_matrix=& Opt_M_Coordinates;
	volatile int x,y;
	 float a=0;
	volatile int n=row*col;
	int i=0;
	 float r=2;
	volatile float pi;
	for(i=0;i<n;i+=2){
		x=matrix[i];
		y=matrix[i+1];
		a += check_square(x,y,r);
		
	}
	r=r*r;
	pi=my_division(&a,&r);	
	
	__asm__("svc 0xca");
		
	__asm__("svc 0xfe");
	

	//a=0;
	//for(i=0;i<n;i+=2){
	//	x=new_matrix[i];
	//	y=new_matrix[i+1];
	//	a += check_square(x,y,r);
	//	
	//}
	//pi=my_division(&a,&r);	
		
	while(1);
}
