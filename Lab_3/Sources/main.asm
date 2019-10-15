;******************************************************************************************
;* Laboratorio #3 - Interrupciones/Dado Electrónico  									  *
;* Contador 0 - 6                                       								  *
;* Sensor de presencia para parada. Mantiene pausa de 5s en donde estaba el conteo.       *    
;* Pulsador 1 - Baja el periodo de conteo                          						  *	
;* Pulsador 2 - Aumenta el periodo de conteo                          					  *	
;* 5 velocidades. Inicio en velocidad media											      * 
;******************************************************************************************
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
display	    ds.b	1
; code section
MyCode:     SECTION
main:
_Startup:

Inicio:

	lda 	#%01010010			;Apagar 
	sta		SOPT1				;El Perro Guardian 
	mov     #%11110000, PTBDD 	;Definir PTB como salida
	mov		#%00000000, display		;Iniciar decenas en 0
	mov		#6T, auxU			;Iniciar auxiliar de unidades en 6
	
Menu:
	
	dbnz	auxU, Sumar			;Aumentar Número
	mov		#6T, auxU
	mov		#%00000000, display	
	bra 	Menu
	
Sumar:

	lda		#%00010000
	add		display
	sta		display
	mov	    display, PTBD
	bra 	Retardo	
	
	
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
	

