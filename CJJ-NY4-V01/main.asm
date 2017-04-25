; =========================================================================      
; Project:       CJJ-NY4-V01
; File:          main.asm
; Description:   New Project for NY4
;                 
; Author:        CaiJinJu
; Version:       1.0
; Date:          2017/04/21
; =========================================================================
;--------------- File Include ---------------------------------------------
;--------------------------------------------------------------------------
#include		NY4.H						; The Header File for NY4 Series

#include		"SystemFiles\cjj.mac4"
#include		"SystemFiles\SystemMacro.asm"
#include		"SystemFiles\playV.asm"
#include		"SystemFiles\keyscan.asm"
#include		"UserFiles\UserMacro.asm"
;--------------- Variable Defination --------------------------------------
;--------------------------------------------------------------------------
;		R_Temp		EQU		0x10			; Example


;--------------- Constant Defination --------------------------------------
;--------------------------------------------------------------------------
;		C_Temp		EQU		0xFF			; Example


;--------------- Vector Defination ----------------------------------------
;--------------------------------------------------------------------------
		ORG		0x000		
		JMP		V_Main                

		
;--------------- Code Start -----------------------------------------------
;--------------------------------------------------------------------------
        ORG		0x800        
V_Main:
		; Power ON initial - User program area 
		; ...
		; ...
		M_Option
		;------------
		Block_Option
		;------------
		M_ClearRam
		M_Init
    	;------------
		mpg		page_user
		;------------
		Block_Init
L_PowerOnPlay:
;		mpg		page_user
		;------------
		Block_PowerOn
		;------------
L_MainLoop:                                    
        CWDT								; Clear WatchDog
		; Main Loop Service -  User program area
		; ...
		; ...
		
		mpg		page_sys
		;------------
		M_Timer
		;------------
		M_PlayFunction
		;------------
		jmp		L_ServiceIO
L_ServiceIOOK:
		jmp		L_UserLoopBlock
L_UserLoopBlockOk:
        mpg		page_sys
		;------------
		jb		B_PG0PlayFlag,L_ClrHalt
        ;------------
        mpg		page_User
		;------------
		Block_PlayOver	L_MainLoop
		;------------
		mpg		page_sys
		;------------
		jnb		B_PG0HaltFlag,L_MainLoop
        ;------------
L_Sleep:
		;------------
		M_GotoSleep
        ;------------
        mpg		page_User
		;------------
		Block_BeforeSleep
        ;------------
		nop
        nop
        halt
        nop
        nop
        ;------------
        jmp		L_MainLoop

L_ClrHalt:
		M_ClrHalt	L_MainLoop
;--------------------------------------------------------------------------
; Path
;--------------------------------------------------------------------------
        #include		"SystemFiles\SystemPath.asm"
		#include		"UserFiles\UserPath.asm"
		Block_PlayList
		#include 		"Resource.asm"
end											; End of Code
		