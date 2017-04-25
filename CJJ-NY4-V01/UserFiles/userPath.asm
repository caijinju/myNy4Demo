; =========================================================================
; Created by NYIDE.
; User: CaiJinJu
; Date: 4/24/2017
; Time: 4:12 PM
; =========================================================================
	
;----------------------------------
L_ServiceIO:
;		M_CheckPortA
;		M_CheckPortB
		M_CheckPort
		jmp		L_ServiceIOOK

;----------------------------------
L_UserLoopBlock:
		mpg		page_user
		;----------------
		Block_Loop
		;----------------
		jmp		L_UserLoopBlockOk
		
;----------------------------------
;	按键处理
;----------------------------------
L_KeyPA0Falling:

		PathEnd
;----------------------------------
L_KeyPA1Falling:

		PathEnd

;----------------------------------
L_KeyPA2Falling:

		PathEnd

;----------------------------------
L_KeyPA3Falling:

		PathEnd

;----------------------------------
L_KeyPA0Rising:

		PathEnd

;----------------------------------
L_KeyPA1Rising:

		PathEnd

;----------------------------------
L_KeyPA2Rising:

		PathEnd

;----------------------------------
L_KeyPA3Rising:

		PathEnd

;----------------------------------
L_KeyPB0Falling:

		PathEnd

;----------------------------------
L_KeyPB1Falling:

		PathEnd

;----------------------------------
L_KeyPB2Falling:

		PathEnd

;----------------------------------
L_KeyPB3Falling:

		PathEnd

;----------------------------------
L_KeyPB0Rising:

		PathEnd

;----------------------------------
L_KeyPB1Rising:

		PathEnd

;----------------------------------
L_KeyPB2Rising:

		PathEnd

;----------------------------------
L_KeyPB3Rising:

		PathEnd

;----------------------------------
