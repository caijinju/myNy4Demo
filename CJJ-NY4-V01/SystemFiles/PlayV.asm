; =========================================================================
; Created by NYIDE.
; User: CaiJinJu
; Date: 3/21/2017
; Time: 5:12 PM
; =========================================================================

;===================================================
; 播放功能MACRO
M_PlayFunction	macro
	local	L_StartPlay,L_PlayVoice,L_PlayVoiceStart,L_CheckPlayEnd,L_CheckVoiceEnd,L_CheckRepeat,L_CheckMuteEnd,L_PlayMute,L_PlayOver,L_cjjExit
		;------------------------
		newR	R_PG0Temp0
;		newR	R_PG0SampleRateL
;		newR	R_PG0SampleRateH
		newR	R_PG0FGRepeat
;		newR	R_PG0MuteTimer0
;		newR	R_PG0MuteTimer1
;		newR	R_PG0MuteTimer2

;		newB	B_PG0PlayStart
		newB	B_PG0PlayFlag
		newB	B_PG0PlayMute
		;------------------------

		mpg		page_sys
		;-----------------------------------------
		jb		B_PG0PlayStart,L_StartPlay		; 跳至开始播放处理
		jb		B_PG0PlayFlag,L_CheckPlayEnd	; 跳至播放中处理，检测是否播放完毕
		jmp		L_cjjExit									; 退出
		
	;-----------------------------------------
	L_StartPlay: ; 开始播放
		nop
		setB	B_PG0PlayFlag 				; 设置为播放状 
		rstB	B_PG0PlayStart             ; 关闭开始状态
		;-----------------------------------------
		M_LoadFGTabAddr										; 检测命令字
		;-----------------------------------------
		rbro	1
		mvam	R_PG0Temp0									; 加载数据，检测最低位
		;-----------------------------------------
;		mvma	rod2
;		andl	b'0011'
		cje_al	V_CmdPlayMute,L_PlayMute					; 跳至处理静音（待完善）
		cje_al	V_CmdPlayV,L_PlayVoice						; 跳至处理声音
		;-----------------------------------------
		jmp		L_PlayOver
		
	L_PlayVoice:
		rbro	1
		mvam	R_PG1VoiceAddr0
		mvma	rod1
		mvam	R_PG1VoiceAddr1
		;-----------------------------------------
		rbro	1
		mvam	R_PG1VoiceAddr2
		mvma	rod1
		mvam	R_PG1VoiceAddr3
		;-----------------------------------------
		rbro	1
		mvam	R_PG1VoiceAddr4
		;-----------------------------------------
		; 暂存SR
		rbro	1
		mvam	R_PG0SampleRateL
		mvma	rod1
		mvam	R_PG0SampleRateH  ;;sample rate.
		;-----------------------------------------
		; 设置播放重复数 R_PG0FGRepeat
		rbro	1
		mvam	R_PG0FGRepeat
		;-----------------------------------------
		M_SaveFGTabAddr
		;-----------------------------------------
	L_PlayVoiceStart:
		mvmr	(R_PG0SampleRateL&0X0F),rpt0
		mvmr	(R_PG0SampleRateH&0X0F),rpt1	; 加载采样率
		ldtm
		;-----------------------------------------
		mvmr	(R_PG1VoiceAddr0&0X0F),rpt0
		mvmr	(R_PG1VoiceAddr1&0X0F),rpt1
		mvmr	(R_PG1VoiceAddr2&0X0F),rpt2
		mvmr	(R_PG1VoiceAddr3&0X0F),rpt3
		mvma	R_PG1VoiceAddr4
		mvam	rpt4
		;-----------------------------------------
		play
		;-----------------------------------------
		jmp		L_cjjExit
		
	;-----------------------------------------
	L_CheckPlayEnd:
		jb		B_PG0PlayMute,L_CheckMuteEnd
		
	L_CheckVoiceEnd:
		jb		B_PFLG,L_cjjExit
		;-----------------------------------------
	L_CheckRepeat:
		decm	R_PG0FGRepeat
		mvam	R_PG0FGRepeat
		jnz		L_PlayVoiceStart
		
		jmp		L_StartPlay
		
	L_CheckMuteEnd:
		jz_3m	R_PG0MuteTimer2,R_PG0MuteTimer1,R_PG0MuteTimer0,L_cjjExit
		nop
		rstb	B_PG0PlayMute
		jmp		L_StartPlay
	;-----------------------------------------
		
		
	L_PlayMute:
		nop
		SETB	B_PG0PlayMute
		;-----------------------------------------
		rbro	1
		mvam	R_PG0MuteTimer0
		mvma	rod1
		mvam	R_PG0MuteTimer1
		;-----------------------------------------
		rbro	1
		mvam	R_PG0MuteTimer2
		;-----------------------------------------
		M_SaveFGTabAddr
		;-----------------------------------------
		jmp		L_cjjExit
		
	L_PlayOver:
		;-----------------------------------------
		mvla	0X0
		mvam	rpt0
		mvam	rpt1
		;-----------------------------------------
		ldtm
		stop
		;-----------------------------------------
;		mvla	0X0
;		mvam	R_PG1PlayFlag
		rstB	B_PG0PlayFlag
;		rstB	B_PG0PlayMute
;		rstB	B_PG0PlayStart
		;-----------------------------------------
		jmp		L_cjjExit
		
	;-----------------------------------------
	L_cjjExit:
		mpg		page_User
endm

;==========================================================================
M_SaveFGTabAddr	macro
		mpg		page_sys
		;-----------------------------------------
		mvrm	(R_PG1FGTabAddr0&0XF),rpt0
		mvrm	(R_PG1FGTabAddr1&0XF),rpt1
		mvrm	(R_PG1FGTabAddr2&0XF),rpt2
		mvrm	(R_PG1FGTabAddr3&0XF),rpt3
		;-----------------------------------------
	endm


;===================================================
M_LoadFGTabAddr macro
		mpg		page_sys
		;-----------------------------------------
		mvmr	(R_PG1FGTabAddr0&0XF),rpt0
		mvmr	(R_PG1FGTabAddr1&0XF),rpt1
		mvmr	(R_PG1FGTabAddr2&0XF),rpt2
		mvmr	(R_PG1FGTabAddr3&0XF),rpt3
		mvla	0X0
		mvam	rpt4
		;-----------------------------------------
		endm
;===================================================
; 播放序列
playList	macro	voiceLabel
		newB	B_PG0PlayStart
		mpg		page_sys
		;-----------------------------------------
		mvla	low0 voiceLabel
		mvam	R_PG1FGTabAddr0
		mvla	low1 voiceLabel
		mvam	R_PG1FGTabAddr1
		mvla	mid0 voiceLabel
		mvam	R_PG1FGTabAddr2
		mvla	mid1 voiceLabel
		mvam	R_PG1FGTabAddr3
		;----------------------
		setB	B_PG0PlayStart
		;----------------------
		mpg		page_User
	endm

;===================================================
; 播放静音
MuteMake	macro	delayTime
		;-----------------------------------------
		DW	(V_SelectPlay<<4)|V_CmdPlayMute
		;-----------------------------------------
		DW	Low (delayTime/8)
		DW	Mid0 (delayTime/8)
;		DW	High0 (delayTime/8)
		;-----------------------------------------
	endm
	
;===================================================
VoiceMake@N	macro	voiceLabel,SR,repeatData
		;-----------------------------------------
		DW	(V_SelectPlay<<4)|V_CmdPlayV
		;-----------------------------------------
		DW	Low voiceLabel
		DW	Mid voiceLabel
		DW	High0 voiceLabel
		;-----------------------------------------
		DW	D'1000000'/SR -1
		;-----------------------------------------
		dw	Low0 repeatData
	endm

;===================================================
VoiceMake	macro	voiceLabel,SR
		VoiceMake@N	voiceLabel,SR,0x1
	endm

;===================================================
ListEnd		macro
		DW	(V_SelectPlay<<4)|V_CmdPlayEnd
endm
;===================================================


