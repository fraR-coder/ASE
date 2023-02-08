				
				AREA _data, DATA, READWRITE
				EXPORT BEST_3	
BEST_3			SPACE 3  ;vettore di 3 byte
NEW				SPACE 10*4 


				AREA _data, DATA, READONLY,align=2
				EXPORT DATA_IN
				EXPORT N
DATA_IN			DCD 1,-2,3,-4,5,8,16,-100,0,32 
N				DCB	10
matrix			DCB	0,1,2,3,4,0,0,9,8
				DCB	6,0,4,0,0,0,1,9,8
				DCB	6,0,4,0,0,0,1,9,8
								
			
				AREA asm_functions, CODE, READONLY				
                
					
ASM_function	PROC
				EXPORT  ASM_function 
				; save current SP for a faster access 
				; to parameters in the stack
				MOV   r12, sp
				; save volatile registers
				STMFD sp!,{r4-r8,r10-r11,lr}
				;r0=  r1= r2= r3=
				;ldr r4,[r12]  ldr r5,[r12,#4]
				

				
				
				
				
				

				; restore volatile registers
				LDMFD sp!,{r4-r8,r10-r11,pc}
                ENDP
					


ASM_monotono	PROC ;crescente
				; save volatile registers
				push{r0-r8,lr}
				;r0=byte vett r1=n int
				ldr r0,[sp,#40] 
				ldr r1,[sp,#44]
				mov r2, #0xff ; result value
				mov r3, #0    ; pointer
				mov r4, #0    ; reference 
ciclomonotono			
				ldrb r5, [r0,r3]
				cmp r5,r4
				movlo r2, #0x55;
				mov r4,r5
				add r3,r3,#1
				cmp r3,r1
				blo ciclomonotono	
				mov r0, r2		
				; restore volatile registers
				pop{r0-r8,pc}
                ENDP
					
				

					
; legge vettore di word e lo ricopia richiede push{oldvett,num elementi, newvett} BL creaVett  pop{oldvett,num elementi, newvett}
;newvett viene riempito,non modificato

;stack:	
;newvett	32
;numelem	28	
;oldvett	24
;LR			20
;r8			16
;r7			12
;r6			8
;r5			4
;r4			0

creaVett		PROC 
				push {r4,r5,r6,r7,r8,LR}
				
				mov r8,#0
				
				
ciclocrea		ldr r7,[r0,r8,lsl #2] 
				str r7,[r2,r8,lsl #2]
				add r8,r8,#1
				subs r1,r1,#1
				bne ciclocrea
				
				pop{r4,r5,r6,r7,r8,PC}
				ENDP


;push{vett,n)
;bl ordinaVett
;pop{vett,n} 
;stack:	

;n			44	
;vett		40
;LR			36
;r8			32
;r7			28
;r6			24
;r5			20
;r4			16
;r3			12
;r2			8
;r1			4
;r0			0
ordinaVett		PROC ;vettore di word ascendente
	
				push {r0-r8,LR}
				ldr r0,[sp,#40]  ;vett
				ldr r1,[sp,#44]	 ;n
				; controlla se la lunghezza è >= 2
				CMP R1, #2
				BLT finalword
				mov r4,#0 ;i
				mov r5,#0 ;j
				add r6,r1,#-1 ;r6=n-1
				
cicloextword	mov r5,#0
				sub r7,r6,r4 ;r7=n-1-i
				add r4,r4,#1
				
ciclointword	ldr r2,[r0,r5,lsl #2]
				add r5,r5,#1
				ldr r3,[r0,r5,lsl #2]
				cmp r2,r3				;inverti per discendente
				strgt r2,[r0,r5,lsl#2]
				addgt r5,r5,#-1
				strgt r3,[r0,r5,lsl#2]
				addgt r5,r5,#1
				cmp r5,r7
				blt ciclointword
				
				cmp r4,r6
				blt cicloextword

finalword		pop{r0-r8,PC}
				ENDP


ordinaVettByte	PROC ;vettore di byte discendente
	
				push {r0-r8,LR}
				ldr r0,[sp,#40]  ;vett
				ldr r1,[sp,#44]	 ;n
				; controlla se la lunghezza è >= 2
				CMP R1, #2
				BLT finalbyte
				mov r4,#0 ;i
				mov r5,#0 ;j
				add r6,r1,#-1 ;r6=n-1
				
cicloextbyte	mov r5,#0
				sub r7,r6,r4 ;r7=n-1-i
				add r4,r4,#1
				
ciclointbyte	ldrb r2,[r0,r5]
				add r5,r5,#1
				ldrb r3,[r0,r5]
				cmp r3,r2
				strbgt r2,[r0,r5]
				addgt r5,r5,#-1
				strbgt r3,[r0,r5]
				addgt r5,r5,#1
				cmp r5,r7
				blt ciclointbyte
				
				cmp r4,r6
				blt cicloextbyte

finalbyte		pop{r0-r8,PC}
				ENDP
          

scorri_matrix_byte	PROC
					MOV   r12, sp
				; save volatile registers
				STMFD sp!,{r4-r8,r10-r11,lr}
				
				;r0=indirizzomat	r1=numrighe r2=numcol
				mov r4,#0 ;indice linea
				mov r5,#0;indice col
				mov r6,#0; global index
				
				mul r7,r1,r2 ;maxindex
				
				
cicloext		mov r5,#0
				
				;mul r6,r4,r2  ;o questo o la add sotto r4
				
				
cicloint		ldrb r8,[r0,r6] ;lsl #2 se word
				add r5,r5,#1
				
				cmp r5,r2
				addlt r6,r6,#1
				blt cicloint
				
				add r4,r4,#1 ;mi sposto di una riga
				
				cmp r4,r1
				addlt r6,r6,#1
				blt cicloext
				
				ENDP

sum_vett		PROC
				;r0=v1 r1=v2 r2=newvett r3=N
				mov r4,#0 ;pointer
				mov r5,#0;tmp
				mov r6,#0;tmp2
				
ciclo_sum		ldrb r5,[r0,r4]
				ldrb r6,[r1,r4]
				add r7,r5,r6
				strb r7,[r2,r4]
				add r4,r4,#1
				cmp r4,r3
				blt ciclo_sum
				
				ENDP
				
				
				END				END