     AREA     test, CODE, READONLY
     EXPORT __main
     IMPORT printMsg
	 IMPORT printMsg2p
	 IMPORT printMsg4p
	 ;IMPORT printSpace 
     ENTRY 
__main  FUNCTION	
		
		VLDR.F32 s20,=0.1;a
		VLDR.F32 s22, =0.1;b
		VLDR.F32 s21,= 1; time
		VLDR.F32 s24, =.01
		VLDR.F32 s31, =1000
		;x = (a+bt)*cos(t)
		;y = (a+bt)*sin(t)
		MOV r4,#1;
		MOV r5,#1572; 5*pi times
		
		
loop2   VMUL.F32 s23,s21,s22 
        VADD.F32 s23,s20,s23
		VMOV.F32 s0,s21
		
		BL sine 
		VMOV.F32 s11,s10;
		VMUL.F32 s13,s11,s23
		;VMUL.F32 s13,s11,s20
        
		BL cos
		VMOV.F32 s12,s10;
		VMUL.F32 s14,s12,s23
		;VMUL.F32 s14,s12,s20
		
		VMUL.F32 s13,s13,s31;
		VCVT.s32.f32 s13,s13;
		VMUL.F32 s14,s14,s31;
		VCVT.s32.f32 s14,s14;
		VMOV.F32 r0,s13;
		VMOV.F32 r1,s14;
        
		BL printMsg2p
		;BL printSpace 
		
		
	    VADD.F32 s21,s21,s24
		CMP r4,r5
        ADD   r4,#1;		
	    BNE   loop2		
       
stop    B stop ; stop program	
	   
	 ENDFUNC
	 
sine FUNCTION
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
		 MOV r1,#100;
	
loop	 CMP  r0,r1;
         VDIV.F32 s8,s6,s4; -1^(n+1)*1/n
		 VMUL.F32 s3,s0,s1; x^(2n+1) 
		 VFMA.F32 s10,s3,s8 
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
	     ;s0 will have x
		 VMUL.F32 s1,s0,s0; to store x^2	
		 VLDR.F32 s10, = 0; sum variable
		 VLDR.F32 s4, = 2;  temporary for coefficients
		 VLDR.F32 s5, = 2;  
		 VLDR.F32 s6, = -1; temporary for sign change
		 VLDR.F32 s7, = -1; sign change
		 VLDR.F32 s9, = 1
         VADD.F32 s10,s9,s10; adding x to sum;		 
		 MOV r0,#1;
		 MOV r1,#100;
	
loop1	 CMP  r0,r1;
         VDIV.F32 s8,s6,s4; -1^(n+1)*1/n
		 VMUL.F32 s3,s9,s1; x^(2n) 
		 VFMA.F32 s10,s3,s8; 
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
		
		
