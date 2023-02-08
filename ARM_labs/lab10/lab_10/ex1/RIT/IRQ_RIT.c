/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_RIT.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    RIT.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "RIT.h"
#include "../led/led.h"

/******************************************************************************
** Function name:		RIT_IRQHandler
**
** Descriptions:		REPETITIVE INTERRUPT TIMER handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/

volatile int down_0 = 0;
volatile int down_1 = 0;
volatile int down_2 = 0;

extern char MESSAGE;


int count_chars_and_character(char*message,char end,int*chars);

extern int translate_morse(char* vett_input, int vet_input_lenght, char* vett_output,
	int vet_output_lenght, char change_symbol, char space, char sentence_end);



	
void RIT_IRQHandler (void)
{
	volatile char* message=&MESSAGE;
	int a=0;
	int i=0;
	int n=0;
	
	
	
	int res;
	char output[100];
	int message_lenght,output_lenght;
	char change_symbol=2;
	char space=3;
	char end=4;


	
	if(down_1!=0){  
			down_1 ++;  
		if((LPC_GPIO2->FIOPIN & (1<<11)) == 0){

			switch(down_1){
			case 2:
				
			//my function
	
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
				break;
			default:
				/*if(down_1 % 10 == 0)
					{
						if( position == 7){
							LED_On(0);
							LED_Off(7);
							position = 0;
							}
						else{
							LED_Off(position);
							LED_On(++position);
						}
					}*/					
				break;
		}
	}
	else {	/* button released */
		down_1=0;			
		NVIC_EnableIRQ(EINT1_IRQn);							 /* enable Button interrupts			*/
		LPC_PINCON->PINSEL4    |= (1 << 22);     /* External interrupt 0 pin selection */
	}
	}
	if(down_2!=0){  
			down_2 ++;  
		if((LPC_GPIO2->FIOPIN & (1<<12)) == 0){
			switch(down_2){
			case 2:
	
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
						
						
				break;
			default:
				/*if(down_2 % 10 == 0)
					{
						if( position == 0){
							LED_On(7);
							LED_Off(0);
							position = 7;
							}
						else{
							LED_Off(position);
							LED_On(--position);
						}
					}					
			*/
				break;
		}
	}
	else {	/* button released */
		down_2=0;			
		NVIC_EnableIRQ(EINT2_IRQn); 							 /* enable Button interrupts			*/
		LPC_PINCON->PINSEL4    |= (1 << 24);     /* External interrupt 0 pin selection */
	}
	}
	
	if(down_0!=0){  
			down_0 ++;  
		if((LPC_GPIO2->FIOPIN & (1<<12)) == 0){
			switch(down_0){
			case 2:
	
				LED_Out(0);
						
						
				break;
			default:
				break;
		}
	}
	else {	/* button released */
		down_0=0;			
		NVIC_EnableIRQ(EINT0_IRQn); 							 /* enable Button interrupts			*/
		LPC_PINCON->PINSEL4    |= (1 << 20);     /* External interrupt 0 pin selection */
	}
	}
	reset_RIT();
  LPC_RIT->RICTRL |= 0x1;	/* clear interrupt flag */
	
  return;
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

/******************************************************************************
**                            End Of File
******************************************************************************/
