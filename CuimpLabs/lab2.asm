.686
.model flat,stdcall
.stack 100h
.data
	arr1 dd 0EE21h, 04299h, 09544h, 0545Ah;
	arr2 dd 4 dup (?);
	M dd ?;
	R dd ?;

.code
ExitProcess PROTO STDCALL :DWORD
Start:
	mov ecx, 4;

	mov esi, offset arr1;	// —охран€ю ссылку на arr1
	mov ebx, offset arr2;	// —охран€ю ссылку на arr2

	for_loop:
		mov eax, [esi];
		dec eax;
		mov [ebx], eax;
		add esi, 4;			// Ќа 4 байта дальше по массиву
		add ebx, 4;
		loop for_loop;
		
	mov ebx, offset arr2;	// ѕереопределю ссылку на arr2

	mov eax, [ebx];			// X' & Z'
	and eax, [ebx + 8];
	mov [esi], eax;

	mov eax, [ebx + 4];		// Y' xor Q'
	xor eax, [ebx + 12];
	mov [esi + 4], eax;

	mov eax, [esi];			// or
	or eax, [esi + 4];

	cmp M, 0;
	jge pp1_call;
	jmp pp2_call;
	
	pp1 PROC
		mov eax, M;
		sar eax, 1;
		add eax, 01344h;
		mov R, eax;
		ret;
		
	pp1 ENDP

	pp2 PROC
		mov eax, M;
		sal eax, 1;
		sub eax, 092Ch;
		mov R, eax;
		ret;

	pp2 ENDP

	pp1_call:
		call pp1;
		jmp continue;

	pp2_call:
		call pp2;
		jmp continue;

	continue:

	cmp R, 031B8h;
	jge R_ge;
	jmp R_l;

	R_ge:
		mov eax, R;
		add eax, 0221Bh;
		jmp exit;

	R_l:
		mov eax, R;
		xor eax, 0913Ch;
		jmp exit;

exit:
Invoke ExitProcess, 0
End Start