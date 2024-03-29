;*******************************************************************
;* This stationery serves as the framework for a user application. *
;* For a more comprehensive program that demonstrates the more     *
;* advanced functionality of this processor, please see the        *
;* demonstration applications, located in the examples             *
;* subdirectory of the "Freescale CodeWarrior for HC08" program    *
;* directory.                                                      *
;*******************************************************************

; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            

; export symbols
            XDEF _Startup, main, irq_serv_rutine
            ; we export both '_Startup' and 'main' as symbols. Either can
            ; be referenced in the linker .prm file or from C/C++ later on
            
            
            
            XREF __SEG_END_SSTACK   ; symbol defined by the linker for the end of the stack


; variable/data section
MY_ZEROPAGE: SECTION  SHORT         ; Insert here your data definition

; code section
MyCode:     SECTION

; interrucpiocnes

; rutina de irq
irq_serv_rutine: 
           pshh
           

           pulh
           rti



;  ==================================================================
;  codigo principla

main:
_Startup:
            LDHX   #__SEG_END_SSTACK ; initialize the stack pointer
            TXS
			;CLI			; enable interrupts
            jsr     irq_confg
            CLI
mainLoop:
            ; Insert your code here
            NOP

            feed_watchdog
            BRA    mainLoop


; =============================================================
; subrutinaas

; Configuracion de irq
irq_confg:
          

          rts
