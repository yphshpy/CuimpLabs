.686
.model flat,stdcall
.stack 100h
.data
	x dd 21;
.code
ExitProcess PROTO STDCALL :DWORD
Start:
exit:
Invoke ExitProcess,1
End Start