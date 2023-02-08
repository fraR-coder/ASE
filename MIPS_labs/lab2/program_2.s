.data

ifmap: 		.byte	1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
kernel: 	.byte	1,1,1,1,1,1,1,1,1
ofmap:		.space   9



.text

MAIN:
    dadd r4, r0, r0
    daddi r16, r16, 3 
    daddi r17, r17,3
   
    daddi r5, r0,0 #index for output matrix
    daddi r7, r0,9     #counter ifmap
   
    
external:
    
    dadd r3, r0, r0    #index kernel
    daddi r13, r0, 9    #counter kernel
    dadd r10, r0, r0    #tmp sum
    daddi r14, r0, 3    #counter line ifmap
   

    beqz r17, changeLine

  

loop:
    lb r2, kernel(r3)
    lb r1, ifmap(r4)  

    dmul r11,r2,r1

    daddi r3,r3,1
    daddi r13, r13, -1
    daddi r4,r4,1
    daddi r14, r14,-1
    dadd r10, r10, r11


    
    slti  r15,r14,1     #se r14<1 -> r15=1	
    dsll  r15, r15,1    #r15=r15*2 --> r15=2 se r14=0 altriment r15=0
    
    dadd r4,r4,r15

    movz r14,r16,r14    #se r14=0 allora r14=r16   r16 sempre ugualea 3
    bnez r13, loop

    sb r10, ofmap(r5)
    daddi r5,r5,1
    
    daddi r17,r17,-1
    daddi r4, r4,-14
    daddi r7,r7,-1
    bnez r7, external

    j fine
   

changeLine:
    daddi r4, r4,2
    daddi r17,r17,3
    j loop

fine:
halt