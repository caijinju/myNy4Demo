;==============================================================================
;	函数调用
;==============================================================================
;-----------------------------------------------
; 清理当前页面的RAM
F_ClearRam:
		mvla	0x0
	for i=0X10 to 0X3F
		mvam	i
	endfor
		ldpc



