.model small
.stack 100h
.data
	str0 db "Enter a String: $"
	str1 db "Enter a Sub String: $"
	str2 db 100 dup ("$")
	str3 db 100 dup ("$")
	str4 db "Lenth of String is 0 $"
	str5 db "Lenth of Sub String is 0 $"
	str6 db "Lenth of String is less than the Length of Sub String $"
	str7 db "Substring is not a part of String$"
	str8 db "Substring is a part of String$"
	l1 dw 0
	l2 dw 0
	increment dw 0
.code
main proc
	mov ax,@data
	mov ds,ax
	mov es,ax
	
	lea di,str2
	
	cld
	
	lea dx,str0
	mov ah,09
	int 21h
	
string1:
	mov ah,01
	int 21h
	
	cmp al,13
	je next
	
	stosb
	inc l1
	jmp string1
	
next:
	lea di,str3
	
	cld
	
	lea dx,str1
	mov ah,09
	int 21h
	
string2:
	mov ah,01
	int 21h
	
	cmp al,13
	je comp
	
	stosb
	inc l2
	jmp string2

comp:
	
	cmp l1,0
	je e1
	
	cmp l2,0
	je e2
	
	mov ax,l1
	
	cmp ax,l2
	jb e3
	
	jmp again
e1:
	lea dx,str4
	mov ah,09
	int 21h
	jmp endd

e2:
	lea dx,str5
	mov ah,09
	int 21h
	jmp endd
	
e3:
	lea dx,str6
	mov ah,09
	int 21h
	jmp endd

again:
	mov cx,l1
	cld
	push l2
check:
	pop l2
	push l2
	lea si,str2
	lea di,str3
	add si,increment
	jmp n1
goo:
	dec l2
	cmp l2,0
	je corr
n1:	cmpsb
	je goo
	
	inc increment
	dec cx
	jnz check
	
	
	lea dx,str7
	mov ah,09
	int 21h
	jmp endd
corr:
	lea dx,str8
	mov ah,09
	int 21h
	


endd:
	mov ah,4ch
	int 21h

main endp
end main
