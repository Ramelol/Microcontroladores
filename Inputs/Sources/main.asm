;**********************
;* Prueba entradas    *
;**********************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            

; export symbols
            XDEF _Startup, main
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            
            
            
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack


; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition
auxU	ds.b	1 
auxD	ds.b	1 
auxT	ds.b	1 
aux1	ds.b	1 
aux2	ds.b	1 
aux3	ds.b	1 
pepito	ds.b	1 
; code section
MyCode:     SECTION
main:
_Startup:

Inicio: 

	lda 	#%01010010			;Apagar 
	sta		SOPT1				;El Perro Guardian 
	mov     #%11111111, PTBDD 	;Definir PTB como salida
	bset	3, PTADD 			;Definir PTA3 como salida
	bclr	0, PTADD			;Definir PTA0 como entrada
	bclr	1, PTADD			;Definir PTA1 como entrada	
	mov		#%00000000, auxU
	mov		#%00000001, auxD
	
Menu:

	brset	0, PTAD, SumarU
	brset	1, PTAD, SumarD
	bra		Menu

SumarU:

	lda		#1T
	add		auxU
	sta		auxU
	mov	    auxU, PTBD
	bra 	Retardo
	
SumarD:

	lda		#%00010000
	add		auxU
	sta		auxU
	mov	    auxU, PTBD
	bra 	Retardo
	
Retardo: 

	mov		#100T, aux1
	mov		#255T, aux2
	mov		#22T, aux3

AuxRetardo: 

	dbnz	aux1, AuxRetardo
	mov		#100T, aux1	
	dbnz	aux2, AuxRetardo
	mov		#255T, aux2
	dbnz	aux3, AuxRetardo
	bra		Menu

