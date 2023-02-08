#include "button.h"
#include "lpc17xx.h"

#include <stdlib.h>

#include "../led/led.h"

#define N 5
extern char MESSAGE;
int count_chars_and_character(char*message,char end,int*chars);

extern int translate_morse(char* vett_input, int vet_input_lenght, char* vett_output,
	int vet_output_lenght, char change_symbol, char space, char sentence_end);

void EINT0_IRQHandler (void)	  
{
	LED_Out(0);
  LPC_SC->EXTINT &= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	
	volatile char* message=&MESSAGE;
	
	int a=0;
	int i=0;
	
	int n=0;
	LED_Out(0);

	while(message[i]!=4){
		n=message[i];
		if(n==2 || n==3){
			a++;
				
			i++;
			
			LED_Out(a);
			continue;
		
		}
		
		i++;
	
	}
	a++;
	LED_Out(a);
	
	LED_Out(255);
	LPC_SC->EXTINT &= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
	char* message=&MESSAGE;
	int res;
	char output[100];
	int message_lenght,output_lenght;
	char change_symbol=2;
	char space=3;
	char end=4;
	//int i=0;
	
	NVIC_DisableIRQ(EINT0_IRQn);
	NVIC_DisableIRQ(EINT1_IRQn);
	message_lenght=count_chars_and_character(message,end,&output_lenght);
	
	res=translate_morse(message,message_lenght,output,output_lenght,change_symbol,space,end);
	
	//for(i=0;i<output_lenght;i++){
	//	end=output[i];
	//}
	LED_Out(res);
	
	NVIC_EnableIRQ(EINT0_IRQn);
	NVIC_EnableIRQ(EINT1_IRQn);
  LPC_SC->EXTINT &= (1 << 2);     /* clear pending interrupt         */    
}

int count_chars_and_character(char*message,char end,int*chars){
	
	int i=0;
	int n=0;
	char m;
	int c=0;
	while(message[i]!=end){
		m=message[i];
		n++;
		if(m==2|| m==3){
			c++;
		}
		if(m==3){
			c++;
		}
		i++;
	}
	c++;
	n++;
	*chars=c;
	return n;
}

