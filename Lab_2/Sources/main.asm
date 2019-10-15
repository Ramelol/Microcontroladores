;********************************************
;* Laboratorio #2 - Entradas y Salidas	 	*
;* Contador 00 - 59 con Periodo T = 1s      *
;* Pulsador 1 - Reset                       *
;* Pulsador 2 - Parar/Continuar             *
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
aux4		ds.b	1 
aux5		ds.b	1
auxU		ds.b	1 
auxD		ds.b	1 
display	    ds.b	1
pausa	    ds.b	1

; code section
MyCode:     SECTION
main:
_Startup:

Inicio:
	
	lda 	#%01010010			;Apagar 
	sta		SOPT1				;El Perro Guardian 
	mov     #%11111111, PTBDD 	;Definir PTB como salida
	mov		#%11111111, display		;Iniciar decenas en 0
	mov		#11T, auxU			;Iniciar auxiliar de unidades en 11
	mov		#6T, auxD			;Iniciar auxiliar de decenas en 6
	mov		#0T, pausa			
		
Menu:

	dbnz	auxU, RevisarPausa
	mov		#10T, auxU
	bclr	0, display
	bclr	3, display
	dbnz	auxD, SumarD
	mov		#6T,  auxD
	mov		#11T, auxU
	mov		#%11111111, display	
	bra 	Menu

RevisarPausa:

	brset	1, PTAD, IncPausa
	bsr		Retardo2
	brset	0, PTAD, Inicio
	brset	0, pausa, RevisarPausa 
	
SumarU:
	
	lda		#1T
	add		display
	sta		display
	mov	    display, PTBD
	brset	0, PTAD, Inicio
	bra		Retardo	
	
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

IncPausa:
	
	lda		#1T
	add		pausa
	sta		pausa
	bra     RevisarPausa
	
Retardo2: 

	mov		#35T, aux4
	mov		#35T, aux5

AuxRetardo2: 

	dbnz	aux4, AuxRetardo2
	mov		#30T, aux1	
	dbnz	aux5, AuxRetardo2
	rts
