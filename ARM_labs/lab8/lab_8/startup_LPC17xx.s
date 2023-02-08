;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011 
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200


                AREA    STACK, NOINIT, READWRITE, ALIGN=3
				SPACE   Stack_Size/2
Stack_Mem       SPACE   Stack_Size/2
__initial_sp		


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF


						AREA asm_functions, CODE, READONLY				
						IMPORT __aeabi_fdiv			
					
check_square  			PROC
						EXPORT  check_square

						
						STMFD sp!,{r4-r8,r10-r11,lr}				
						
						mul r0,r0,r0
						mul r1,r1,r1
						mul r2,r2,r2
						add r4,r1,r0
						cmp r4,r2
						movle r0,#1
						movgt r0,#0
					
						LDMFD sp!,{r4-r8,r10-r11,pc}


						ENDP

my_division  			PROC
						EXPORT  my_division 
							
						STMFD sp!,{r4-r8,r10-r11,lr}
						ldr r0, [r0];
						ldr r1, [r1];
						
						bl __aeabi_fdiv
						
						
						
						LDMFD sp!,{r4-r8,r10-r11,pc}
						
						ENDP
							
;signature				PROC
;						EXPORT signature
;						PUSH{r4-r8,r10-r11,lr}
;						
;						MRS R5,MSP
;						
;						MOV		R4, #3
;						MSR		CONTROL, R4
;						LDR		SP, =Stack_Mem
;						
;						
;						
;						
;						
;						SVC		0x000000CA	
;						sub SP,SP,#36
;					
;						pop {R0}
;						
;						
;						mov R13,R5
;						POP{r4-r8,r10-r11,PC}
;						
;						ENDP
;					
					
						AREA _data, DATA, READWRITE
						EXPORT Opt_M_Coordinates [DATA]
Opt_M_Coordinates		SPACE 11*22*1					
				


						
						AREA _data, DATA, READONLY,align=2

						EXPORT _Matrix_Coordinates [DATA]
						EXPORT _ROWS
						EXPORT _COLUMNS

_Matrix_Coordinates 	DCD -5,5 ,-4,5, 	-3,5 	,-2,5, 	-1,5, 0,5, 	1,5, 	2,5, 3,5, 4,5, 5,5
						DCD -5,4, 	-4,4, 	-3,4, 	-2,4, 	-1,4, 	0,4, 1,4, 	2,4, 3,4, 4,4, 5,4
						DCD -5,3, 	-4,3, 	-3,3, 	-2,3, 	-1,3, 	0,3, 1,3, 	2,3, 3,3, 4,3, 5,3
						DCD -5,2, 	-4,2, 	-3,2, 	-2,2, 	-1,2, 	0,2, 1,2, 	2,2, 3,2, 4,2, 5,2
						DCD -5,1, 	-4,1, 	-3,1, 	-2,1, 	-1,1, 	0,1, 1,1, 	2,1, 3,1, 4,1, 5,1
						DCD -5,0, 	-4,0, 	-3,0, 	-2,0, 	-1,0, 	0,0, 1,0, 	2,0, 3,0, 4,0, 5,0
						DCD -5,-1, 	-4,-1, 	-3,-1, 	-2,-1, 	-1,-1, 	0,-1, 1,-1, 2,-1, 3,-1, 4,-1, 5,-1
						DCD -5,-2, 	-4,-2, 	-3,-2, 	-2,-2, 	-1,-2, 	0,-2, 1,-2, 2,-2, 3,-2, 4,-2, 5,-2
						DCD -5,-3, 	-4,-3, 	-3,-3, 	-2,-3, 	-1,-3, 	0,-3, 1,-3, 2,-3, 3,-3, 4,-3, 5,-3
						DCD -5,-4, 	-4,-4, 	-3,-4, 	-2,-4, 	-1,-4, 	0,-4, 1,-4, 2,-4, 3,-4, 4,-4, 5,-4
						DCD -5,-5, 	-4,-5, 	-3,-5, 	-2,-5, 	-1,-5, 	0,-5, 1,-5, 2,-5, 3,-5, 4,-5, 5,-5
_ROWS		 			DCB 11
_COLUMNS		 		DCB 22






                AREA    |.text|, CODE, READONLY
				

; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]                
                IMPORT  __main                
                LDR     R0, =__main
				MOV		R4, #3
				MSR		CONTROL, R4
				LDR		SP, =Stack_Mem
                BX      R0
                ENDP



; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
				
				PUSH {R0-R12, LR} ;14 valori salvati oltre ai 6 salvati per svc
				
				MRS R1, PSP
				
				;LDR R1, [SP,#20*4];ottengo PC
				LDR R2, [R1,#6*4];ottengo PC

				LDR R2, [R2,#-4]	;torno indietro di di 4 perchè dopo svc pc è aumentato
				BIC R2, #0xFF000000
				LSR R2, #16
				
				
						
				
				; your code here
				cmp r2, #0x000000CA
				LDMFDEQ r1!,{r0} ; pop da PSP per avere r0
				
				EOREQ R0, R0, R1
				EOREQ R0, R0, R2
				EOREQ R0, R0, R3
				EOREQ R0, R0, R4
				EOREQ R0, R0, R5
				EOREQ R0, R0, R6
				EOREQ R0, R0, R7
				EOREQ R0, R0, R8
				EOREQ R0, R0, R9
				EOREQ R0, R0, R10
				EOREQ R0, R0, R11
				EOREQ R0, R0, R12
				EOREQ R0, R0, R14
				MRSEQ R3,XPSR
				EOREQ R0, R0, r3
				
				STMFDEQ r1!,{r0};push di r0 su psp
				
				cmp r2, #0x000000FE
				bne uscita
				
				ldr r0,=Opt_M_Coordinates
				ldr r1,=_Matrix_Coordinates
				
				ldr r2,= _ROWS	
				ldrb r2,[r2]
				ldr r3,= _COLUMNS
				ldrb r3,[r3]
				
				mov r4,#0
				mov r5,#0
				
				mul r7,r3,r2
				
oldmat			ldr r6,[r1,r4,lsl #2]
				strb r6,[r0,r5]
				add r4,r4,#1
				add r5,r5,#1
				subs r7,r7,#1
				bne oldmat


					
				
				
uscita			POP {R0-R12, PC}
				
				
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
