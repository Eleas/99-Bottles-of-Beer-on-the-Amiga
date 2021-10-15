
ExecBase:        equ 4
LVOOpenLibrary:  equ -552
LVOCloseLibrary: equ -414
LVOOutput:       equ -60
LVOWrite:        equ -48

  move.l (ExecBase).w,a6
  lea dosname(pc),a1
  moveq #0,d0 ; Use any library version.

  jsr LVOOpenLibrary(a6)
  tst.l d0
  beq.b no_lib
  move.l d0,a6
  jsr LVOOutput(a6)

  move.l d0,d7 ; Make sure we have a CLI handle
  beq.b no_cli

  move.b #$99,d5 ; bottle counter

loop:
  bsr.s bottle(pc) ; "[counter] bottle(s)"
  lea ofbeer(pc),a0
  move.l a0, a2    ; store it
  moveq #22,d3
  bsr.w print(pc)  ; " of beer on the wall, "
  bsr.s bottle(pc) ; "[counter] bottle(s)"
  exg a2, a0
  moveq #8, d3
  bsr.w print(pc)  ; " of beer"
  lea period(pc),a0
  moveq #3, d3
  bsr.w print(pc)  ; ".[newline]"

; drink one bottle
  tst.b d5
  bne.s notzero(pc)
  move.b #$99,d5
  bra.s zerodone(pc)
notzero:
  moveq #1,d2
  sbcd d2,d5
zerodone:

  lea takeone(pc),a0
  moveq #31,d3
  cmp.w #$99,d5
  bne.s notfinal(pc)
  lea gotostore(pc),a0
  move.b #$21,(period)
  addq #4,d3
notfinal:
  bsr.s print(pc)  ; "Take one down, pass it around, "
  
  bsr.s bottle(pc) ; "[counter] bottle(s)"
  lea ofbeer(pc),a0
  moveq #20,d3
  bsr.s print(pc)  ; " of beer on the wall"
  lea period(pc),a0
  moveq #5, d3
  bsr.s print(pc)  ; ".[newline][newline]"
  cmp.w #$99,d5
  bne.s loop

no_cli:
  move.l a6,a1
  move.l (ExecBase).w,a6
  jsr LVOCloseLibrary(a6)

no_lib:
  rts

bottle:
  lea msg(pc),a0
  moveq #15,d3
; write value as decimal
  move.w d5,d6
  lsl.w #4,d6
  lsr.b #4,d6
  add.w #$3030,d6
  cmp.w #$10,d5
  bge.s twodecimals
  and #$ff,d6
twodecimals:
  move.w d6,(a0)
  moveq #1,d2
  cmp.b d1,d5
  bne.s nosingular
  subq #1,d3    
nosingular:
  tst.b d5
  bne.s regular
  add.l #15,a0
  bchg #5,(a0)  ; flip the letter N in No More
regular:
  bra.w print(pc)
  
print:
  move.l d7, d1
  move.l a0, d2
  jsr LVOWrite(a6)
  rts


  cnop 0,2

msg:
  dc.b '99 ',0,0,0,0,0,'bottles'
  dc.b 'No more bottles'
ofbeer:
  dc.b ' of beer on the wall, '
period:
  dc.b '.',$a,$d,$a,$d
takeone:
  dc.b 'Take one down, pass it around, '
gotostore:
  dc.b 'Go to the store and buy some more, '

dosname:
  dc.b "dos.library",0

  cnop 0,2

