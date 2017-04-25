; =========================================================================
; Created by NYIDE.
; User: CaiJinJu
; Date: 4/24/2017
; Time: 4:12 PM
; =========================================================================
;----------------------------------
PathEnd	macro
		jmp		L_MainLoop
endm
;----------------------------------
Block_Option	macro
	;-----------------------------------
	; IO口输入输出设置
	;-----------------------------------
	V_IOC_PA		equ		b'0000'
	V_IOC_PB		equ		b'1011'
	
	#define		B_IO_Motor1		pa,3
	#define		B_IO_Motor2		pa,2
	#define		B_IO_Led1		pa,0
	#define		B_IO_Led2		pa,1
	#define		B_IO_Send		pb,2
	
endm
;----------------------------------
Block_Init	macro

endm
;----------------------------------
Block_PowerOn	macro
		playList	pl0

endm
;----------------------------------
Block_PlayOver	macro	returnLoop

endm
;----------------------------------
Block_BeforeSleep	macro

endm
;----------------------------------
Block_Loop	macro

endm
;----------------------------------
Block_125us	macro
		
endm
;----------------------------------
Block_2ms	macro
		
endm
;----------------------------------
;----------------------------------
Block_4ms	macro
		
endm
;----------------------------------
Block_8ms	macro
		
endm
;----------------------------------
Block_PlayList	macro
	pl0:
		VoiceMake	L_SPH_0,d'12000'
		;----------------------
		ListEnd
	;-----------------------------------------
;	pl1:
;		VoiceMake@N	L_SPH_0,d'9000',2
;		;----------------------
;;		MuteMake	d'200'
;		;----------------------
;		VoiceMake@N	L_SPH_0,d'8000',3
;		VoiceMake	L_SPH_1,d'8000'
;		VoiceMake@N	L_SPH_1,d'9000',5
;;		VoiceMake	v06,d'8000'
;;		VoiceMake	v07,d'8000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_chongzhi:
;		VoiceMake	L_SPH_0,d'8300'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_huanhu:
;		VoiceMake	L_SPH_1,d'8000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_kaiji:
;		VoiceMake	L_SPH_2,d'16000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_yinxiao1:
;		VoiceMake	L_SPH_3,d'16000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_yinxiao2:
;		VoiceMake	L_SPH_4,d'16000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_yinxiao3:
;		VoiceMake	L_SPH_5,d'16000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_yinxiao4:
;		VoiceMake	L_SPH_6,d'16000'
;		;----------------------
;		ListEnd
;	;-----------------------------------------
;	pl_testMute:
;		VoiceMake	L_SPH_0,d'8300'
;		MuteMake	d'1000'
;		VoiceMake	L_SPH_1,d'8000'
;		MuteMake	d'2000'
;		VoiceMake	L_SPH_2,d'16000'
;		MuteMake	d'2000'
;		VoiceMake	L_SPH_3,d'16000'
;		MuteMake	d'3000'
;		VoiceMake	L_SPH_4,d'16000'
;		MuteMake	d'4000'
;		VoiceMake	L_SPH_5,d'16000'
;		MuteMake	d'5000'
;		VoiceMake	L_SPH_6,d'16000'
;		;----------------------
;		ListEnd
	
	;-----------------------------------------
	;-----------------------------------------
endm
;----------------------------------
