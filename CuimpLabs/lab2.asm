.686
.model flat,stdcall
.stack 100h
.data
	arr1 dd 0EE21h, 04299h, 09544h, 0545Ah;
	arr2 dd 4 dup (?);
	M dd ?;

.code
ExitProcess PROTO STDCALL :DWORD
Start:
	mov ecx, 4;

	mov esi, offset arr1;	// �������� ������ �� arr1
	mov ebx, offset arr2;	// �������� ������ �� arr2

	for_loop:
		mov eax, [esi];
		dec eax;
		mov [ebx], eax;
		add esi, 4;
		add ebx, 4;
		loop for_loop;
		
	mov ebx, offset arr2;	// ������������ ������ �� arr2

	mov eax, [ebx];
	and eax, [ebx + 8];
	mov [esi], eax;

	mov eax, [ebx + 4];
	xor eax, [ebx + 12];
	mov [esi + 4], eax;



exit:
Invoke ExitProcess,1
End Start