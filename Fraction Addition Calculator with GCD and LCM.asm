.model small
.stack 100h
.data
	str0 db "Enter numerator of first fraction: $"
	str1 db "Enter denominator of first fraction: $"
	str2 db "Enter numerator of second fraction: $"
	str3 db "Enter denominator of second fraction: $"
	str4 db "The result is: $"
	n1 dw 0
	d1 dw 0     ;M
	n2 dw 0
	d2 dw 0		;N
	gcd dw 0
	lcm dw 0
	v1 dw 0
	v2 dw 0
.code
main proc
		mov ax,@data
		mov ds,ax
		
		lea dx,str0				; first numerator
		mov ah,09
		int 21h
		
		call decimal_input
		
		mov n1,bx
		
		lea dx,str1				;first denominator
		mov ah,09
		int 21h
		
		call decimal_input
		
		mov d1,bx				; second numerator
		
		lea dx,str2
		mov ah,09
		int 21h
		
		call decimal_input
		
		mov n2,bx
		
		lea dx,str3				;second denominator
		mov ah,09
		int 21h
		
		call decimal_input
		
		mov d2,bx
		
		lea dx,str4
		mov ah,09
		int 21h
		
		mov ax,d1				;Code to calc GCD
		mov bx,d2
		
		cmp ax,bx				;find biger value
		jae divide
		
		push ax					; swap values
		push bx
		
		pop ax
		pop bx
		
divide:							;Code to calc GCD
		xor dx,dx				
		
		div bx
		
		cmp dx,0
		je e1
		
		mov ax,bx
		mov bx,dx
		
		jmp divide
	
e1:
	mov gcd,bx			;Code to find LCM =M x N / GCD
	mov ax,d1
	mov bx,d2
	
	mul bx
	
	xor dx,dx
	mov bx,gcd
	
	div bx
	
	mov lcm,ax
	
	
	mov ax,lcm    ;12
	mov bx,d1	  ;4 
	
	xor dx,dx
	
	div bx		; ax = 3
	
	mov cx,n1	; cx=1
	
	mul cx		; ax = 3
	
	mov v1,ax	; v1 = 3
	
	
	
	mov ax,lcm		;12
	mov bx,d2		;3
	
	xor dx,dx
	
	div bx			;ax = 4
	
	mov bx,n2		;bx = 2
	
	mul bx			; AX = 8
	
	
	add ax,v1
	
	mov v2,ax
	
	mov bx,lcm
	
	xor dx,dx
	
	div bx
	
	cmp dx,0
	jne print
		
	call decimal_output
	
	jmp endd
	
print:
	mov ax,v2
	call decimal_output
	
	mov dl,'/'
	mov ah,02
	int 21h
	
	mov ax,lcm
	
	
	call decimal_output
	
endd:
	mov ah,4ch
	int 21h
		
	
		
		
main endp
decimal_input proc 
	
	mov bx, 0
	
again:

	mov ah, 01
	int 21h
	
	cmp al, 13
	
	JE exit
	
	sub al, 48
	
	mov cl,al
	mov ch,0
	mov ax,bx
	
	mov bx, 10
	
	mul bx
	;pop bx
	
	add ax, cx
	mov bx,ax
	
	JMP again
	
exit:
	;mov var, bx
	
	ret
	
decimal_input endP

decimal_output proc

	;mov ax, 0
	;mov ax, var
	
	mov bx, 10
	
	mov cx, 0
	
divide:	

	cmp ax, 0
	JE nowprint

	mov dx, 0

	div bx
	push dx
	
	inc cx
	
	JMP divide

	
nowprint:
	
	pop dx
	
	cmp dl, 9
	JBE digit
	
	add dl, 7
	
digit:
	add dl, 30h
	
	mov ah, 2
	int 21h
	
	dec cx
	JNZ nowprint

	ret

decimal_output endP

end main	
	
