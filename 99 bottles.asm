; Name:	99 bottles of beer on the wall.
; Author:	Björn Paulsen
; Version:	1.6 (final)
; Assembler:	ASM-One V1.48
; Size:	548 bytes (optimized)
; 
; For those who always wanted a drinking song on the Amiga, this 
; routine is just the thing. It prints out the full text of the drinking 
; song "99 Bottles of Beer on the Wall," and is polite about being run
; outside of a Dos environment (i.e. won't crash the Amiga).
;
; Some optimizations have been made, most saliently the branching and
; use of an address register to move the starting address of a string.
; PC-relative addressing worked wonders, but the single biggest impact
; was consolidating the data as much as possible: fewer but longer 
; strings mean fewer syscalls to print them, and it all adds up.
;
; Other optimizations may suggest themselves. If you see them, please
; give me a shout-out. Right now, the address registers are used to
; store and reuse string addresses, and we also use some offsets,
; which though it looks horrible does confer space savings.
; 
; Update: 
; 
; On reflection and code review (i.e. the dudes at the Amiga Code 
; FB group picking it apart), it turns out this code had a few bugs.
; Most saliently, it requires Kickstart 2.0+ to run. This is due to 
; its biggest space saver turned an Achilles Heel, i.e. the PutStr
; function, which is what we print with rather than the older
; Write(). PutStr() is simpler, thus making for comparatively 
; leightweight calls. On the downside, this means a no-go on your
; typical A500 or A2000. :-(

print:	MACRO
	move.l	\1, d1
	jsr	PutStr(a6)
	ENDM

SysBase = 4

; Library vector offsets
OpenLibrary  = -552
CloseLibrary = -414
PutStr       = -948

; Actual code
	lea	DosName, a1
	moveq   #36, d0
	movea.l	SysBase.w, a6
	jsr	OpenLibrary(a6)

	tst.l	d0	; Did it work?
	beq.b	NoDos	; If not, we exit
	movea.l d0, a6	; We store the pointer

	moveq   #99, d4 ; number of bottles

	; Invariants. These are registers we will not change.
	; a1	volatile due to function calls (sadly)
	lea.l	take_one(pc), a2
	lea.l	no_more(pc), a3
	; a6   obviously we need the ExecBase pointer

	; Print first line
bottle_loop:
	move.b	#'N', (a3)	; if used, we capitalize
	bsr.s	bottletext
	move.b	#'n', (a3)	
	move.l	a3, d1
	addq	#8, d1		; no_more + 8 becomes on_the_wall string
	jsr	PutStr(a6)
	move.l	a2, d1  	; reads the comma part of that string
	add	#32, d1 	; but offset 32 spaces
	jsr	PutStr(a6)
	bsr.s 	bottletext
	move.l	a2, d1
	subq	#4, d1		; take_one-4 becomes period
	jsr	PutStr(a6)
	
	; Print second line
	tst.b	d4
	beq.s	go_to_the_store
	print	a2
	subq.b  #1, d4		; remove one bottle
	bra.s	go_to_the_store_end

go_to_the_store:
	moveq   #99, d4
	move.l	a2, d1
	add	#35, d1		; go_to_store is 35 chars after take_one
	jsr	PutStr(a6)

go_to_the_store_end: 	
	bsr.s   bottletext
	move.l	a3, d1
	addq	#8, d1		; no_more text + 8 becomes on_the_wall
	jsr	PutStr(a6)
	move.l	a2, d1
	subq	#4, d1		; take_one - 4 becomes period text
	jsr	PutStr(a6)
	move.l	a2, d1
	subq	#2, d1		; take_one - 2 becomes line break after period
	jsr	PutStr(a6)
	cmpi.b	#99, d4
	bne.b	bottle_loop	
	move.l	a6, a1
	movea.l	SysBase.w,a6
	jsr	CloseLibrary(a6)

NoDos	moveq	#0, d0
	rts

; Subroutine for printing the bottle text
bottletext:

	lea.l	bottle(pc), a4

; Echo out the number, or "no more" if bottles are 0
	tst.b   d4
	bne.s	bottle_count_nonzero
	move.l	a3, d1
	jsr	PutStr(a6)
	addq    #2, a4	      ; a4 is set to position just after numbers
	bra.s	bottle_count_nonzero_end

bottle_count_nonzero:
	move.l	d4, d5
	divu.w	#10, d5
	move.w	#$3030, (a4)  ; We set the first two letters of bottle to '0'
	add.b	d5, (a4)+     ; Incrementing a4 and adding first number, thus-
	move.l	a4, a5	      ; ...storing a4+1 as a5, and then...
	addq	#8, a5	      ; ...we can addq to just reach bottle plural pos!
	swap	d5	      ; we swap the remainder and quotient
	add.b   d5, (a4)
	cmpi.w	#9, d4
	bls.s	bottle_count_nonzero_end
	subq	#1, a4

bottle_count_nonzero_end:
	move.b	#'s', (a5)    ; now we can add plural letter by indirection 

; Fix the suffix (if the number of bottles is 1, no 's'
	cmpi.b	#1, d4
	bne.s	post_removed_s
	move.b	#30, (a5)     ; empty letter for nonplural situations
	
post_removed_s:
	print a4	      ; finally we echo the constructed bottle text
	rts

; Data

DosName		dc.b	"dos.library",0
bottle		dc.b	"xx bottles of beer",0
no_more		dc.b    "no more",0
on_the_wall	dc.b	" on the wall",0
period		dc.b	". ",10,0
take_one	dc.b	"Take one down and pass it around, ",0
go_to_store	dc.b	"Go to the store and buy some more, ",0
