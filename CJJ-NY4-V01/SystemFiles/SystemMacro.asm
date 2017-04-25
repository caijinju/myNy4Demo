; =========================================================================
; Created by NYIDE.
; User: CaiJinJu
; Date: 3/21/2017
; Time: 5:12 PM
; =========================================================================
R_PG1FGTabAddr0		equ		0x35 ; 
R_PG1FGTabAddr1		equ		0x36 ; 
R_PG1FGTabAddr2		equ		0x37 ; 
R_PG1FGTabAddr3		equ		0x38 ; 
;---------------------------------
R_PG0SampleRateL	equ		0x39 ; 声音采样率
R_PG0SampleRateH	equ		0x3a ; 
;--------------------------------- 
R_PG1VoiceAddr0		equ		0x3b ; 声音地址
R_PG1VoiceAddr1		equ		0x3c ; 
R_PG1VoiceAddr2		equ		0x3d ; 
R_PG1VoiceAddr3		equ		0x3e ; 
R_PG1VoiceAddr4		equ		0x3f ; 
;--------------------------------- 

page_sys		equ		0
page_play		equ		0
page_user		equ		1

;======================================================
;		页面动态分配
; RAM
;	- 从 0x10 ~ 0x2f
; Bit
;	- 从 0x30 ~ 0x34
;======================================================
variable	V_DynamicRam=0x10
variable	V_MaxSRamAddr=0x2f

variable	V_BitRam=0x30
variable	V_BitRamMax=0x34
variable	V_BitNow=0x0

;======================================================
;==============================================================================
;	宏MACRO定义
;==============================================================================
M_DynRam	macro	regName
	if (V_DynamicRam>V_MaxSRamAddr)
		error	RAM is run out ! Ram name is --> regName
	else
		ifndef	regName
			regName		equ		V_DynamicRam
			V_DynamicRam=V_DynamicRam+1
		else
			error	Ram name has been defined ! Ram name is -->  regName
;			messg	"Ram name has been defined!"
		endif
	endif
endm

;--------------------------------- 
newR	macro	regName
		M_DynRam	regName
endm

;--------------------------------- 
newB	macro	bitName
	if (V_BitNow>=4)
		V_BitNow=0
		V_BitRam=V_BitRam+1
		if (V_BitRam>V_BitRamMax)
			error	Bit RAM is run out ! Bit name is --> bitName
		endif
	endif

	ifndef	bitName
;		#define		bitName		V_BitRam,V_BitNow
		switch	V_BitRam
			case 0x30
				switch	V_BitNow
					case 0
						#define		bitName		0x30,0
						break
					case 1
						#define		bitName		0x30,1
						break
					case 2
						#define		bitName		0x30,2
						break
					case 3
						#define		bitName		0x30,3
						break
				endsw
				break
			case 0x31
				switch	V_BitNow
					case 0
						#define		bitName		0x31,0
						break
					case 1
						#define		bitName		0x31,1
						break
					case 2
						#define		bitName		0x31,2
						break
					case 3
						#define		bitName		0x31,3
						break
				endsw
				break
			case 0x32
				switch	V_BitNow
					case 0
						#define		bitName		0x32,0
						break
					case 1
						#define		bitName		0x32,1
						break
					case 2
						#define		bitName		0x32,2
						break
					case 3
						#define		bitName		0x32,3
						break
				endsw
				break
			case 0x33
				switch	V_BitNow
					case 0
						#define		bitName		0x33,0
						break
					case 1
						#define		bitName		0x33,1
						break
					case 2
						#define		bitName		0x33,2
						break
					case 3
						#define		bitName		0x33,3
						break
				endsw
				break
			case 0x34
				switch	V_BitNow
					case 0
						#define		bitName		0x34,0
						break
					case 1
						#define		bitName		0x34,1
						break
					case 2
						#define		bitName		0x34,2
						break
					case 3
						#define		bitName		0x34,3
						break
				endsw
				break
		endsw
		
		V_BitNow=V_BitNow+1
	else
		error	Bit name has been defined ! Bit name is -->  bitName
;		messg	"bit name has been defined!"
	endif

endm
;-----------------------------------------------
M_Option	macro
	;-----------------------------------
	; 播放命令字
	;-----------------------------------
	V_SelectPlay	equ		0x33
	V_SelectQIO		equ		0X34
	;-----------------------------------------
	V_CmdPlayV		equ		0X01
	V_CmdPlayMute	equ		0X02
	V_CmdPlayEnd	equ		0xf
	;-----------------------------------------
	V_TabPlayEnd	equ		0X04
	V_TabPlayOut	equ		0X05
	;-----------------------------------------
	V_CmdDelay		equ		0X0A
	V_CmdPlayTab	equ		0X0B
	;-----------------------------------------
	V_TabOutput		equ		0X0C
	V_CmdPlayA		equ		0X0E
	;-----------------------------------------
			
endm
;-----------------------------------------------
; 清理所有页面的RAM
M_ClearRam	macro
		mpg		page_user
		call	F_ClearRam
		mpg		page_sys
		call	F_ClearRam
endm

;-----------------------------------------------
; 清理 HALT 标志和计时器
M_Init	macro
		;------------------
		newR	R_PG0KeyFlagA
		newR	R_PG0KeyFlagB
		;------------------

		mpg		page_sys
		;-------------------
		mvla	V_IOC_PA
		mvam	paio
		mvla	V_IOC_PB
		mvam	pbio
		;-------------------
;		mvma	pa
;		andl	V_IOC_PA
;		mvam	pa
;		mvam	R_PG0KeyFlagA
;		mvma	pb
;		andl	V_IOC_PB
;		mvam	pb
;		mvam	R_PG0KeyFlagB
		
		mvla	V_IOC_PA
		mvam	R_PG0KeyFlagA
		mvla	V_IOC_PB
		mvam	R_PG0KeyFlagB
		;-------------------
;		mvla	0x0
;		mvam	pa
;		mvam	pb
		;-------------------
		mvla	0x0			; 计时器 0.125ms 
		mvam	bt
endm

;-----------------------------------------------
; 清理 HALT 标志和计时器
;M_WakeUp	macro
;		;------------------
;		newR	R_PG0HaltTime0
;		newR	R_PG0HaltTime1
;		newR	B_PG0HaltFlag
;		;------------------
;
;		MPG		page_sys
;		mvla	0x0
;		mvam	R_PG0HaltTime0
;		mvam	R_PG0HaltTime1
;		rstb	B_PG0HaltFlag
;endm



;-----------------------------------------------
; 清理 HALT 标志和计时器
M_ClrHalt	macro	returnMain
		;------------------
;		newR	R_PG0HaltTime0
;		newR	R_PG0HaltTime1
;		newB	B_PG0HaltFlag
		;------------------

		MPG		page_sys
		mvla	0x0
		mvam	R_PG0HaltTime0
		mvam	R_PG0HaltTime1
		rstb	B_PG0HaltFlag
		jmp		returnMain
endm



;-----------------------------------------------
; 睡眠前处理
;-----------------------------------------------
M_GotoSleep	macro
		;------------------
;		newR	R_PG0HaltTime0
;		newR	R_PG0HaltTime1
;		newB	B_PG0HaltFlag
		;------------------
		mpg		page_sys
		mvla	0x0
		mvam	R_PG0HaltTime0
		mvam	R_PG0HaltTime1
		rstB	B_PG0HaltFlag
        ;------------
		mvma	pa
        mvam	pa
        mvma	pb
        mvam	pb
endm

;--------------------------------------
M_ClrBTFlag	macro
		mvla	0x4
		mvam	sfr
endm
;--------------------------------------
; 功能：
;	分频，计时
;	此计时器使用的是125us计时
M_Timer macro
	local	L_Timer_125us,L_Timer_4Ms,L_Timer_8Ms,L_NotPlayMute,L_NotHaltFlag,L_Timer_End
		;---------------
		newR	R_PG0KeyDelayA
		newR	R_PG0KeyDelayB
		newR	R_PG0MuteTimer0
		newR	R_PG0MuteTimer1
		newR	R_PG0MuteTimer2
		newR	R_PG0HaltTime0
		newR	R_PG0HaltTime1
		newR	R_PG0BTInc
		
;		newB	B_PG0125us
;		newB	B_PG02ms
		newB	B_PG04ms
		newB	B_PG08ms
		newB	B_PG0HaltFlag
		;---------------
		mpg		Page_sys
		jnb		B_BTF,L_Timer_End
		;-----------------------------------------
		M_ClrBTFlag
	;-------------------------------------------------------
	;into one time for 0.125ms
	;-------------------------------------------------------
	L_Timer_125us:
		mpg		page_user
		;-----------------------------------------
		Block_125us
		;-----------------------------------------
		mpg		Page_sys
		incm	R_PG0BTInc
		mvam	R_PG0BTInc
		jnc		L_Timer_End
	;-------------------------------------------------------
	;into one time for 2ms
	;-------------------------------------------------------
	L_Timer_2Ms:
		mpg		page_user
		;-----------------------------------------
		Block_2ms
		;-----------------------------------------
		mpg		Page_sys
		xorB	B_PG04ms
		;-----------------------------------------
		jb		B_PG04ms,L_Timer_End
	;-------------------------------------------------------
	;into one time for 4ms
	;-------------------------------------------------------
	L_Timer_4Ms:
		mpg		page_user
		;-----------------------------------------
		Block_4ms
		;-----------------------------------------
		mpg		Page_sys
		xorB	B_PG08ms
		;-----------------------------------------
		jb		B_PG08ms,L_Timer_End
	;-------------------------------------------------------
	;into one time for 8ms
	;-------------------------------------------------------
	L_Timer_8Ms:
		mpg		page_user
		;-----------------------------------------
		Block_8ms
		;-----------------------------------------
		mpg		Page_sys
		incm	R_PG0KeyDelayA
		mvam	R_PG0KeyDelayA
		incm	R_PG0KeyDelayB
		mvam	R_PG0KeyDelayB
		;-----------------------------------------
		jz_3m	R_PG0MuteTimer2,R_PG0MuteTimer1,R_PG0MuteTimer0,L_NotPlayMute
		dec_3m	R_PG0MuteTimer2,R_PG0MuteTimer1,R_PG0MuteTimer0
		;-----------------------------------------
	L_NotPlayMute:
		nop
		inc_2m	R_PG0HaltTime1,R_PG0HaltTime0
		nop
		jnc		L_NotHaltFlag
		nop
		setb	B_PG0HaltFlag
		;-----------------------------------------
	L_NotHaltFlag:
		;-----------------------------------------
	L_Timer_End:
		endm

