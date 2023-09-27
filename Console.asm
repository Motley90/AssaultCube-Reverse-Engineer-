;==============================================================================================
; AssaultCube Console (C) 2023 Robert
;==============================================================================================
format PE console
entry start

include 'win32a.inc'

;=================== data ====================
section '.data' data readable writeable
;=============================================
 
WindowTitle             db 'AssaultCube',0;
ProcID                  dd ?
ProcHandle              db ?


WaitForProcess          db  "Waiting for AssaultCube...",0dh,0ah,0
LibrariesLoaded         db  "AC.DLL Added to the stacks successfully!",10,0

    
section '.text' code readable executable

start:
        push WaitForProcess
        call [printf]
processfeaturepresent:
        invoke FindWindow, NULL, WindowTitle ; Find the window title
        test eax,eax                         ; Test whether a window with that title was found or not
        jnz Initiate                      ; Don't jump = The window was not found
        jmp processfeaturepresent
yield:
        jmp yield
Initiate:


        invoke printf, LibrariesLoaded
        call yield

section '.idata' import data readable

        library msvcrt, 'MSVCRT.DLL', kernel32,'KERNEL32.DLL', user32,'USER32.DLL' ;AC,'AC.DLL'

        ;import AC,

        import       msvcrt, printf, 'printf'
        import       kernel32, OpenProcess,'OpenProcess'
        import       user32, FindWindow,'FindWindowA'
