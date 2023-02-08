.data
v1: .double 1, 2, 3,4,5,6.5,7,8,9,1,1, 2, 3,4,5,6,7,8,9,1,1, 2, 3,4,5,6,3.47,8,9,1,1, 2, 3,4,5,6,7,8,9,1,1, 2, 3,4,5,6,7,8,9,1,1, 2, 3,4,5,6,7,8,9,1
v2: .double 1, 2, 1, 3,5,7,9.6,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6
v3: .double 1, 2, 3,4,5,6,7,8,0.9,1,1, 2, 3,4,5,6,7,8,9,1,0.00021, 2, 3,4,5,6,7,8,9,1,1, 2, 3,4,5,6,7,8,9,1,1, 2, 3,4,5,6,7,8,9,1,1, 2, 3,4,5,6,7,8,9,1
v4: .double 1, 2, 1, 3,5,7,9,2,4.24,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6,1, 2, 1, 3,5,7,9,2,4,6



v5: .space 480  # 60* 64 bit =60*8byte
v6: .space 480
v7: .space 480


#for (i = 0; i < 60; i++){	
#	v5[i] = ((v1[i]+v2[i]) * v3[i])+v4[i];
#	v6[i] = v5[i]/(v4[i]*v1[i]);
#   v7[i] = v6[i]*(v2[i]+v3[i]);
#}


.text

MAIN:
    
    daddi R1, R0, 15 
    dadd R3, R0, R0             #i
    dadd R2, R0, R0             #i

loop:

    l.d f1, v1(R3)
    l.d f2, v2(R3)
    l.d f4, v4(R3)
    
    
    add.d f10, f1, f2       #v1+v2
    mul.d f11, f4, f1         #v4*v1
    l.d f3, v3(R3)
    daddi R3,R3, 8
    add.d f12, f2, f3                #v2+v3
    
    l.d f21, v1(R3)

    mul.d f10, f10, f3       # *v3
    l.d f24, v4(R3)
    l.d f22, v2(R3)
    l.d f23, v3(R3)

    add.d f15, f21, f22       #v1+v2
    mul.d f16, f24, f21         #v4*v1
    add.d f10, f10, f4       # +v4
    add.d f17, f22, f23                #v2+v3


    div.d f11, f10, f11                 # v5/v4*v1
    s.d f10, v5(R2)          # v5->f10
    mul.d f15, f15, f23       # *v3
    
    daddi R3,R3, 8
    l.d f25, v1(R3)
    l.d f26, v2(R3)
    l.d f28, v4(R3)
    l.d f27, v3(R3)
   
    mul.d f19, f28, f25        #v4*v1
    add.d f18, f26, f25       #v1+v2
    add.d f15, f15, f24       # +v4
    add.d f20, f26, f27                #v2+v3
    

    div.d f16, f15, f16                 # v5/v4*v1
    mul.d f12, f12, f11         # v6*(v2+v3)
    s.d f11, v6(R2)             # v6->f11
    mul.d f18, f18, f27       # *v3
    daddi R3,R3, 8
    
    l.d f1, v1(R3)
    l.d f2, v2(R3)
    l.d f3, v3(R3)
    l.d f4, v4(R3)
    s.d f12, v7(R2)             # v7->f12
    add.d f18, f18, f28       # +v4
    daddi R2,R2, 8
    s.d f15, v5(R2)          # v5->f15
    mul.d f11, f4, f1         #v4*v1
    add.d f10, f1, f2       #v1+v2
    add.d f12, f2, f3                #v2+v3


    div.d f19,f18,f19
    mul.d f17, f17, f16         # v6*(v2+v3)
    s.d f16, v6(R2)             # v6->f16
    mul.d f10, f10, f3       # *v3
    daddi R3,R3, 8
    
    s.d f17, v7(R2)             # v7->f17
    daddi R2,R2, 8
    s.d f18, v5(R2)          # v5->f18
    add.d f10, f10, f4       # +v4
    

    
    
    div.d f11, f10, f11                 # v5/v4*v1
    mul.d f20, f20, f19         # v6*(v2+v3)
    s.d f19, v6(R2)             # v6->f19
    s.d f20, v7(R2)             # v7->f20
    daddi R2,R2, 8
    s.d f10, v5(R2)          # v5->f10
    daddi R1, R1, -1
    mul.d f12, f12, f11         # v6*(v2+v3)


    s.d f11, v6(R2)             # v6->f11


    s.d f12, v7(R2)             # v7->f12



    bnez R1, loop
    daddi R2,R2, 8

halt

