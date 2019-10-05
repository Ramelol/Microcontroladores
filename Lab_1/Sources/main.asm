;********************************************
;* Laboratorio #1 - Entradas y Salidas	 	*
;* Contador 00 - 59 con Periodo T = 1s      *
;********************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            

; export symbols
            XDEF _Startup, main
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            
            
            
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack


; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

aux1		ds.b	1 
aux2		ds.b	1 
aux3		ds.b	1
auxU		ds.b	1 
auxD		ds.b	1 
display	    ds.b	1
;decenas		ds.b	1

; code section
MyCode:     SECTION
main:
_Startup:

Inicio:
	
	lda 	#%01010010			;Apagar 
	sta		SOPT1				;El Perro Guardian 
	mov     #%11111111, PTBDD 	;Definir PTB como salida
	bset	3, PTADD 			;Definir PTA3 como salida
	mov		#%11111111, display		;Iniciar decenas en 0
	mov		#11T, auxU			;Iniciar auxiliar de unidades en 6
	mov		#6T, auxD			;Iniciar auxiliar de decenas en 6
	

	
Menu:

	dbnz	auxU, SumarU
	mov		#10T, auxU
	bclr	0, display
	bclr	3, display
	dbnz	auxD, SumarD
	mov		#6T,  auxD
	mov		#11T, auxU
	mov		#%11111111, display	
	bra 	Menu
	
	
SumarU:

	lda		#1T
	add		display
	sta		display
	mov	    display, PTBD
	bra		Retardo
	;bsr		Retardo
	
	
SumarD:

	lda		#%00010000
	add		display
	sta		display
	mov	    display, PTBD
	bra		Retardo	
	
Retardo: 

	mov		#101T, aux1
	mov		#255T, aux2
	mov		#22T, aux3

AuxRetardo: 

	dbnz	aux1, AuxRetardo
	mov		#101T, aux1	
	dbnz	aux2, AuxRetardo
	mov		#255T, aux2
	dbnz	aux3, AuxRetardo
	bra		Menu
	
	
	
	
	
	
	
	
	

