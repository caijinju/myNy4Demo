; =========================================================================
; Created by NYIDE.
; User: CaiJinJu
; Date: 4/21/2017
; Time: 3:46 PM
; =========================================================================

;===========================================
; PA口输入检测
;===========================================
M_CheckPortA	macro
	local	L_ExitIOA,L_ScanPortA,L_ClrHaltFlagA,L_CheckPortAOK
;		newR	R_PG0KeyFlagA
		newR	R_PG0KeyBufferA
;		newR	R_PG0KeyDelayA
		newR	R_PG0KeyRising
		newR	R_PG0KeyFalling
;		newR	R_PG0HaltTime0
;		newR	R_PG0HaltTime1
;		newB	B_PG0HaltFlag

		mpg		page_sys
		;-----------------------------------------
		mvma	pa
		andl	V_IOC_PA
		xorm	R_PG0KeyFlagA
		jz		L_ExitIOA
		mvma	pa
		andl	V_IOC_PA
		xorm	R_PG0KeyBufferA
		jz		L_ScanPortA
		mvma	pa
		andl	V_IOC_PA
		mvam	R_PG0KeyBufferA
	L_ExitIOA:
		mvla	0x0
		mvam	R_PG0KeyDelayA
		jmp		L_CheckPortAOK
		
	;-------------------------------
	L_ScanPortA:
		mvma	R_PG0KeyDelayA
		andl	b'0010'
		jz		L_ClrHaltFlagA
		;-------------------------------
		mvla	0x0
		mvam	R_PG0KeyDelayA
		;-------------------------------
		mvma	R_PG0KeyBufferA
		xorm	R_PG0KeyFlagA
		andm	R_PG0KeyBufferA
		mvam	R_PG0KeyRising
		;-------------------------------
		mvma	R_PG0KeyBufferA
		xorm	R_PG0KeyFlagA
		andm	R_PG0KeyFlagA
		mvam	R_PG0KeyFalling
		;-------------------------------
		mvma	R_PG0KeyBufferA
		mvam	R_PG0KeyFlagA
		;-------------------------------
		mpg		page_user
		jb		R_PG0KeyFalling,0,L_KeyPA0Falling
		jb		R_PG0KeyFalling,1,L_KeyPA1Falling
		jb		R_PG0KeyFalling,2,L_KeyPA2Falling
		jb		R_PG0KeyFalling,3,L_KeyPA3Falling
		;-------------------------------
		jb		R_PG0KeyRising,0,L_KeyPA0Rising
		jb		R_PG0KeyRising,1,L_KeyPA1Rising
		jb		R_PG0KeyRising,2,L_KeyPA2Rising
		jb		R_PG0KeyRising,3,L_KeyPA3Rising
		;-------------------------------
	L_ClrHaltFlagA:
		mpg		page_sys
		mvla	0x0
		mvam	R_PG0HaltTime0
		mvam	R_PG0HaltTime1
		;-------------------------------
		rstb	B_PG0HaltFlag
		;-------------------------------
	L_CheckPortAOK:
endm

	
;===========================================
; PB口输入检测
;===========================================
M_CheckPortB	macro
	local	L_ExitIOB,L_ScanPortB,L_ClrHaltFlagB,L_CheckPortBOK
;		newR	R_PG0KeyFlagB
		newR	R_PG0KeyBufferB
;		newR	R_PG0KeyDelayB
		newR	R_PG0KeyRising
		newR	R_PG0KeyFalling
;		newR	R_PG0HaltTime0
;		newR	R_PG0HaltTime1
;		newB	B_PG0HaltFlag

		mpg		page_sys
		;-----------------------------------------
		mvma	pb
		andl	V_IOC_PB
		xorm	R_PG0KeyFlagB
		jz		L_ExitIOB
		mvma	pb
		andl	V_IOC_PB
		xorm	R_PG0KeyBufferB
		jz		L_ScanPortB
		mvma	pb
		andl	V_IOC_PB
		mvam	R_PG0KeyBufferB
	L_ExitIOB:
		mvla	0x0
		mvam	R_PG0KeyDelayB
		jmp		L_CheckPortBOK
		
	;-------------------------------
	L_ScanPortB:
		mvma	R_PG0KeyDelayB
		andl	b'0010'
		jz		L_ClrHaltFlagB
		;-------------------------------
		mvla	0x0
		mvam	R_PG0KeyDelayB
		;-------------------------------
		mvma	R_PG0KeyBufferB
		xorm	R_PG0KeyFlagB
		andm	R_PG0KeyBufferB
		mvam	R_PG0KeyRising
		;-------------------------------
		mvma	R_PG0KeyBufferB
		xorm	R_PG0KeyFlagB
		andm	R_PG0KeyFlagB
		mvam	R_PG0KeyFalling
		;-------------------------------
		mvma	R_PG0KeyBufferB
		mvam	R_PG0KeyFlagB
		;-------------------------------
		mpg		page_user
		jb		R_PG0KeyFalling,0,L_KeyPB0Falling
		jb		R_PG0KeyFalling,1,L_KeyPB1Falling
		jb		R_PG0KeyFalling,2,L_KeyPB2Falling
		jb		R_PG0KeyFalling,3,L_KeyPB3Falling
		;-------------------------------
		jb		R_PG0KeyRising,0,L_KeyPB0Rising
		jb		R_PG0KeyRising,1,L_KeyPB1Rising
		jb		R_PG0KeyRising,2,L_KeyPB2Rising
		jb		R_PG0KeyRising,3,L_KeyPB3Rising
		;-------------------------------
	L_ClrHaltFlagB:
		mpg		page_sys
		mvla	0x0
		mvam	R_PG0HaltTime0
		mvam	R_PG0HaltTime1
		;-------------------------------
		rstb	B_PG0HaltFlag
		;-------------------------------
	L_CheckPortBOK:
endm
		


;===========================================
M_CheckPort		macro
;		M_CheckPortA
		M_CheckPortB
endm
