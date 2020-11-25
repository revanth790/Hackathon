	 AREA     test, CODE, READONLY
     EXPORT __main  
	 IMPORT printMsg2p
     ENTRY 
__main  FUNCTION	
	    ;centre of spiral 1 (0,0)
		;centre of spiral 2
		VLDR.F32 s28,=3.5; (3.5,3.5)
		
		VLDR.F32 s20,=0.1;a
		VLDR.F32 s22, =0.1;b
		VLDR.F32 s25,= 0;
		VLDR.F32 s26,= 360;
		VLDR.F32 s24, =1
		VLDR.F32 s31, =1000
		;x = (a+bt)*sin(t)
		;y = (a+bt)*cos(t)
		VLDR.F32 s30, =57.32
		VLDR.F32 s29, = 3.14
;For 1st spiral        
		MOV r6,#1
		MOV r7,#5

loop3   VLDR.F32 s21,= 0; theeta
        MOV r4,#1;
		MOV r5,#360;	
		
loop2   VDIV.F32 s0,s25,s30	
        VMUL.F32 s23,s0,s22 
        VADD.F32 s23,s20,s23
        
		VMOV.F32 s0,s21;		
		BL sine
		VMOV.F32 s11,s10;
		VMUL.F32 s13,s11,s23
		
		VMOV.F32 s0,s21;
		BL cos
		VMOV.F32 s12,s10;
		VMUL.F32 s14,s12,s23
		
		
		VMUL.F32 s13,s13,s31;
		VCVT.s32.f32 s13,s13;
		VMUL.F32 s14,s14,s31;
		VCVT.s32.f32 s14,s14;
		VMOV.F32 r0,s13;
		VMOV.F32 r1,s14;
        
		BL printMsg2p
		VADD.F32 s21,s21,s24
		VADD.F32 s25,s25,s24
		CMP r4,r5
        ADD   r4,#1;		
	    BLE   loop2		
		
		CMP r6,r7
		ADD r6,#1
		BLT loop3      
;For 2nd spiral 		
		VLDR.F32 s20,=0.03;a
		VLDR.F32 s22, =0.03;b
        VLDR.F32 s25,= 1800;
        MOV r6,#1
		MOV r7,#5
loop4   VLDR.F32 s21,= 0; theeta
        MOV r4,#1;
		MOV r5,#360;	
		
loop5   VDIV.F32 s0,s25,s30	
        VMUL.F32 s23,s0,s22 
        VADD.F32 s23,s20,s23
        
		VMOV.F32 s0,s21;		
		BL sine
		VMOV.F32 s11,s10;
		VMUL.F32 s13,s11,s23
		VADD.F32 s13,s13,s28
		
		VMOV.F32 s0,s21;
		BL cos
		VMOV.F32 s12,s10;
		VMUL.F32 s14,s12,s23
		VADD.F32 s14,s14,s28
		
		VMUL.F32 s13,s13,s31;
		VCVT.s32.f32 s13,s13;
		VMUL.F32 s14,s14,s31;
		VCVT.s32.f32 s14,s14;
		VMOV.F32 r0,s13;
		VMOV.F32 r1,s14;
        
		BL printMsg2p
		;BL printSpace 
        VADD.F32 s21,s21,s24
		VSUB.F32 s25,s25,s24
		CMP r4,r5
        ADD   r4,#1;		
	    BLE   loop5 
		
		CMP r6,r7
		ADD r6,#1
		BLT loop4
       
stop    B stop ; stop program	
	   
	 ENDFUNC
	 
sine FUNCTION
		
		 
		 
START 	 VDIV.F32 s0,s0,s30	
         ;s0 will have x
         VMUL.F32 s1,s0,s0; to store x^2	
		 VLDR.F32 s10, = 0; sum variable
		 VLDR.F32 s4, = 6;  temporary for coefficients
		 VLDR.F32 s5, = 3 
		 VLDR.F32 s6, = -1; temporary for sign change
		 VLDR.F32 s7, = -1; sign change
		 VLDR.F32 s9, = 1
         VADD.F32 s10,s0,s10; adding x to sum;		 
		 MOV r0,#1;
		 MOV r1,#8;
	
loop	 CMP  r0,r1;
         VDIV.F32 s8,s6,s4; -1^(n+1)*1/n
		 VMUL.F32 s0,s0,s1; x^(2n+1) 
		 VMUL.F32 s18,s0,s8
         VADD.F32 s10,s10,s18		 
		 VADD.F32 s5,s5,s9
		 VMUL.F32 s4,s4,s5 
		 VADD.F32 s5,s5,s9
		 VMUL.F32 s4,s4,s5 
		 VMUL.F32 s6,s6,s7; alternate sign change
         ADD   r0,#1;		
	     BNE   loop	
 
         BX LR 
		
		 ENDFUNC

cos FUNCTION
	    	
START1	 VDIV.F32 s0,s0,s30	
		 VMUL.F32 s1,s0,s0; to store x^2	
		 VLDR.F32 s10, = 0; sum variable
		 VLDR.F32 s4, = 2;  temporary for coefficients
		 VLDR.F32 s5, = 2;  
		 VLDR.F32 s6, = -1; temporary for sign change
		 VLDR.F32 s7, = -1; sign change
		 VLDR.F32 s0, = 1
         VADD.F32 s10,s9,s10; adding x to sum;		 
		 MOV r0,#1;
		 MOV r1,#8;
	
loop1	 CMP  r0,r1;
         VDIV.F32 s8,s6,s4; -1^(n+1)*1/n
		 VMUL.F32 s0,s0,s1; x^(2n) 
		 VMUL.F32 s18,s0,s8
         VADD.F32 s10,s10,s18
		 VADD.F32 s5,s5,s9
		 VMUL.F32 s4,s4,s5 
		 VADD.F32 s5,s5,s9
		 VMUL.F32 s4,s4,s5 
		 VMUL.F32 s6,s6,s7; alternate sign change
         ADD   r0,#1;		
	     BNE   loop1		
		
		BX LR
		
		ENDFUNC
	
		 END
		
		
