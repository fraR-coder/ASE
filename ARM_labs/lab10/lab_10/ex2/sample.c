/*----------------------------------------------------------------------------
 * Name:    sample.c
 * Purpose: 
 *		to control led11 and led 10 through EINT buttons (similarly to project 03_)
 *		to control leds9 to led4 by the timer handler (1 second - circular cycling)
 * Note(s): this version supports the LANDTIGER Emulator
 * Author: 	Paolo BERNARDI - PoliTO - last modified 15/12/2020
 *----------------------------------------------------------------------------
 *
 * This software is supplied "AS IS" without warranties of any kind.
 *
 * Copyright (c) 2017 Politecnico di Torino. All rights reserved.
 *----------------------------------------------------------------------------*/

                  
#include "LPC17xx.H"                    /* LPC17xx definitions                */
#include "led/led.h"
#include "button_EXINT/button.h"
#include "timer/timer.h"

/* Led external variables from funct_led */
extern unsigned char led_value;					/* defined in lib_led								*/
#ifdef SIMULATOR
extern uint8_t ScaleFlag; // <- ScaleFlag needs to visible in order for the emulator to find the symbol (can be placed also inside system_LPC17xx.h but since it is RO, it needs more work)
#endif
/*----------------------------------------------------------------------------
  Main Program
 *----------------------------------------------------------------------------*/
int main (void) {
  	
	SystemInit();  												/* System Initialization (i.e., PLL)  */
  LED_init();                           /* LED Initialization                 */
  BUTTON_init();												/* BUTTON Initialization              */
	
	LED_On(2);

	
	//init_timer(2, 0, 0, 3,0x017D7840*0.01);   //spegne
	//init_timer(2, 0, 1, 1,0x017D7840*0.001);	//accende
	
	
	//100%
	//init_timer(2, 0, 0, 3,0x017D7840*0.01);   //spegne
	//init_timer(2, 0, 1, 1,0x017D7840*0.005);	  //accende
	
	//50%
	//init_timer(2, 0, 0, 3,0x017D7840*0.007);   //spegne
//	init_timer(2, 0, 1, 1,0x017D7840*0.005);	  //accende
	
	//25%
	//init_timer(2, 0, 0, 3,0x017D7840*0.006);   //spegne
	//init_timer(2, 0, 1, 1,0x017D7840*0.005);	  //accende
	
	//75%
	init_timer(2, 0, 0, 3,0x017D7840*0.008);   //spegne
	init_timer(2, 0, 1, 1,0x017D7840*0.005);	  //accend
	
	enable_timer(2);
	
	//enable_timer(0);
	
	//LPC_SC->PCON |= 0x1;									/* power-down	mode										*/
	//LPC_SC->PCON &= 0xFFFFFFFFD;						
		
  while (1) {                           /* Loop forever                       */	
		//__ASM("wfi");
  }

}
