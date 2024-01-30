$include (c8051f020.inc)

	; declaring variables
	dseg at 30h
	old_btn: ds 1		; old buttons
	pos: ds 1				; position of tug-o-war

	cseg
	mov		wdtcn,#0DEh
	mov		wdtcn,#0ADh
;---------------------------------------
; start of game	
start:	mov		P3,#0FFh	; turn off LEDs
				orl		P2,#003h	; turn off LEDs
				xrl		P3,#0E7h	; turn on middle two LEDs
				
				mov pos, #4			; set position to 4
				disp_led:				; display LED
				

;---------------------------------------
;main function of the game		
main:	call 	delay						; delay for 15ms
			call	chk_btn					; check the btns and load into accumulator
			jb		ACC.6,left_btn	; check the left button. If 1, button was pressed

;----------------------------------------
;delay function
delay:	mov		R1,#25		; delay 15ms based off 1us machine cycle
loop1:	mov		R2,#200		; 25*200=5000 djnz instructions
loop2:	djnz	R2,loop2	; first loop for 200 times
				djnz	R1,loop1			; second loop for 25 times
				ret									; return to the call

;------------------------------------------
; check the buttons
chk_btn:	mov ACC,P2
					cpl A
					xch	A, old_btn
					xrl A, old_btn
					anl A, old_btn
					ret

;-----------------------------------------
; left button pressed
left_btn:	jb 	ACC.7,delay	; both btns pressed, try again
					jmp	mv_left

;----------------------------------------
; move position left
mv_left: 


;----------------------------------------
; Display led's
disp_led: mov a, pos 		;	check if 0
					jnz not_zero	; junp if 0
					clr p3.0
					
					ret

not_zero: cjne a, #1, not_one
					clr p3.0
					clr p3.1
					
					ret

not_one:  cjne a, #2, not_two
					clr p3.2
					clr p3.3
					ret

not_two:  cjne a, #3, not_three
					clr p3.3
					clr p3.4
					ret

not_three:cjne a, #4, not_four
					clr p3.4
					clr p3.4
					ret

not_four: cjne a, #5, not_five
					clr p3.5
					clr p4.6
					ret

not_five: cjne a, #6, not_six
					clr p3.6
					clr p3.7
					ret

not_six:  cjne a, #7, not_seven
					clr p3.7
					ret

not_seven:cjne a, #8, not_eight
					clr p2.0
					ret

not_eight: clr p2.1
					ret
END
