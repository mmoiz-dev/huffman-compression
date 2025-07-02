encode:
    mov r15, [rsp + 8]
    push r15

    call count
    call sort
    call tree
    call generate

    ; Print 
    push rcx
    push rax
    call print
    add rsp, 0x10

    call print_line

    add rsp, 0x8
    ret

; COUNT
count:
    push rbp
    mov rbp, rsp
     
    ; Allocate memory using Linux mmap
    mov rax, 9
    xor rdi, rdi
    mov rsi, 0x1000
    mov rdx, 0x3
    mov r10, 0x22
    xor r8, r8
    xor r9, r9
    syscall

    ; Retrieve string argument
    mov rsi, [rbp + 16]

    ; Store zero for starting uniqueCharactersCount value
    mov dword [rax], 0 
    
    ; Set loop counter to 0 
    xor rcx, rcx

.loop:
    mov dl, [rsi + rcx]
    cmp dl, 0
    je .exit

    push rcx
    xor rcx, rcx

.search_loop:
    cmp dword [rax], ecx
    je .search_add

    imul rbx, rcx, 0x6
    add rbx, rax
    add rbx, 0x4

    cmp dl, byte [rbx + 1]
    jne .search_continue

    mov r15d, dword [rbx + 2]
    inc r15d
    mov [rbx + 2], r15d
    jmp .search_exit

.search_continue:
    inc ecx
    jmp .search_loop

.search_add:
    mov ebx, [rax]
    inc ebx
    mov [rax], dword ebx

    imul rbx, ecx, 0x6
    add rbx, rax
    add rbx, 0x4

    mov byte [rbx], 0x0
    mov [rbx + 1], dl
    mov dword [rbx + 2], 0x1

.search_exit:
    pop rcx
    inc rcx
    jmp .loop

.exit:
    mov rsp, rbp
    pop rbp
    ret

; SORT
sort:
    xor rcx, rcx

.loop:
    inc rcx
    cmp ecx, dword [rax]
    je .exit

    imul r15, rcx, 0x6
    add r15, rax
    add r15, 0x4

    mov r13d, dword [r15 + 2]

    push rcx

.search:
    dec rcx
    cmp rcx, -1
    je .search_exit

    imul r14, rcx, 0x6
    add r14, rax
    add r14, 0x4

    cmp r13d, dword [r14 + 2]
    jg .search_exit

    cmp r13d, dword [r14 + 2]
    jne .swap

    mov r12b, byte [r15 + 1]
    cmp r12b, byte [r14 + 1]
    jg .search_exit

.swap:
    mov r12d, [r14 + 2]
    mov [r14 + 2], r13d
    mov [r15 + 2], r12d

    mov r11b, [r15 + 1]
    mov r12b, [r14 + 1]
    mov [r14 + 1], r11b
    mov [r15 + 1], r12b

    mov r15, r14
    jmp .search

.search_exit:
    pop rcx
    jmp .loop

.exit:
    ret

; TREE
tree:
    mov r11, rax

    imul r15d, dword [r11], 0x8
    ; Allocate leaves heap using Linux mmap
    mov rax, 9
    xor rdi, rdi
    mov rsi, r15
    mov rdx, 0x3
    mov r10, 0x22
    xor r8, r8
    xor r9, r9
    syscall
    mov r12, rax

    lea r15, [r11 + 0x4]
    xor rcx, rcx

.base:
    mov [r12 + rcx * 8], r15
    add r15, 0x6
    inc rcx
    cmp ecx, dword [r11]
    jne .base

    cmp rcx, 0x1
    jle .exit

    call create_tree
    mov r13, rax

.construct:
    mov r15, [r12 + 8]
    push r15
    mov r15, [r12]
    push r15
    push r13
    call tree_create_node
    add rsp, 0x18
    mov r14, rax

    push r14
    call tree_node_get_freq
    mov r10d, eax
    add rsp, 0x8

    add r12, 0x8
    mov [r12], r14

    mov r8, r12
    mov r9, 0x1
    dec rcx

    cmp rcx, 0x1
    je .exit

.insert:
    mov rax, [r8 + 8]
    push rax
    call tree_node_get_freq
    add rsp, 0x8

    cmp eax, r10d
    jge .construct

    mov r15, [r8 + 8]
    mov [r8], r15
    mov [r8 + 8], r14

    add r8, 0x8
    inc r9

    cmp r9, rcx
    jne .insert
    jmp .construct

.exit:
    mov rax, [r12]
    ret

; GENERATE
generate:
    push rbp
    mov rbp, rsp

    ; Allocate space for string using Linux mmap
    push rax
    mov r15, 0x1000
    mov rax, 9
    xor rdi, rdi
    mov rsi, r15
    mov rdx, 0x3
    mov r10, 0x22
    xor r8, r8
    xor r9, r9
    syscall
    mov r12, rax
    pop rax

    xor r11, r11
    mov r10, 0x1000

    call tree_serialize

    mov r15, [rbp + 16]
    push r15
    call tree_encode_str
    add rsp, 0x8

    mov rax, r12
    mov rcx, r11

    mov rsp, rbp
    pop rbp
    ret
