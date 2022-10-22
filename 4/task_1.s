    .intel_syntax noprefix

    .section .data
length:             # Переменная length
        .zero   4
i:                  # Переменная i
        .zero   4
        
        .section .rodata    # Строки, которые буду использоваться для ввода/вывода
.LC0:
        .string "Input length: "
.LC1:
        .string "%d"
.LC2:
        .string "Incorrect length = %d\n"
.LC3:
        .string "a[%d]? "
.LC4:
        .string "b[%d] = %d\n"
        
    .section .text
    .global main
main:               # Точка входа в программу
        push    rbp
        mov     rbp, rsp
        
        push    r15
        push    r14
        push    r13
        push    r12
        push    rbx
        sub     rsp, 72
        # Приглашение для ввода значения длины
        mov     rax, rsp
        mov     rbx, rax
        lea     rdi, .LC0[rip]
        mov     eax, 0
        call    printf      # Вызов функции вывода текста сообщения
        # Ввод значения длины
        lea     rsi, length[rip]
        lea     rdi, .LC1[rip]
        mov     eax, 0
        call    scanf       # Вызов функции ввода
        # Сравнение длины с 0 и максимальным значением
        mov     eax, DWORD PTR length[rip]
        test    eax, eax
        jle     .L2
        mov     eax, DWORD PTR length[rip]
        cmp     eax, 2000
        jle     .L3
.L2:    # Вывод сообщения об ошибке
        mov     eax, DWORD PTR length[rip]
        mov     esi, eax
        lea     rdi, .LC2[rip]
        mov     eax, 0
        call    printf
        mov     eax, 1
        jmp     .L4
.L3:    # Продолжение программы
        # Массив a
        mov     eax, DWORD PTR length[rip]
        movsx   rdx, eax
        sub     rdx, 1
        mov     QWORD PTR [rbp-56], rdx
        movsx   rdx, eax
        mov     QWORD PTR [rbp-96], rdx
        mov     QWORD PTR [rbp-88], 0
        movsx   rdx, eax
        mov     QWORD PTR [rbp-112], rdx
        mov     QWORD PTR [rbp-104], 0
        cdqe
        lea     rdx, [0+rax*4]
        mov     eax, 16
        sub     rax, 1
        add     rax, rdx
        mov     ecx, 16
        mov     edx, 0
        div     rcx
        imul    rax, rax, 16
        sub     rsp, rax
        mov     rax, rsp
        add     rax, 3
        shr     rax, 2
        sal     rax, 2
        mov     QWORD PTR [rbp-64], rax
        # Массив b
        mov     eax, DWORD PTR length[rip]
        movsx   rdx, eax
        sub     rdx, 1
        mov     QWORD PTR [rbp-72], rdx
        movsx   rdx, eax
        mov     r14, rdx
        mov     r15d, 0
        movsx   rdx, eax
        mov     r12, rdx
        mov     r13d, 0
        cdqe
        lea     rdx, [0+rax*4]
        mov     eax, 16
        sub     rax, 1
        add     rax, rdx
        mov     ecx, 16
        mov     edx, 0
        div     rcx
        imul    rax, rax, 16
        sub     rsp, rax
        mov     rax, rsp
        add     rax, 3
        shr     rax, 2
        sal     rax, 2
        mov     QWORD PTR [rbp-80], rax
        mov     DWORD PTR i[rip], 0
        jmp     .L5
.L6:
        # Цикл ввода значений в массив a
        mov     eax, DWORD PTR i[rip]
        mov     esi, eax
        lea     rdi, .LC3[rip]
        mov     eax, 0
        call    printf      # Вывод подсказки
        mov     eax, DWORD PTR i[rip]
        cdqe
        lea     rdx, [0+rax*4]
        mov     rax, QWORD PTR [rbp-64]
        add     rax, rdx
        mov     rsi, rax
        lea     rdi, .LC1[rip]
        mov     eax, 0
        call    scanf       # Ввод значения
        mov     eax, DWORD PTR i[rip]
        add     eax, 1
        mov     DWORD PTR i[rip], eax
.L5:    # Проверка условия цикла
        mov     edx, DWORD PTR i[rip]
        mov     eax, DWORD PTR length[rip]
        cmp     edx, eax
        jl      .L6
        mov     DWORD PTR i[rip], 0
        jmp     .L7
.L11:
        mov     edx, DWORD PTR i[rip]
        mov     rax, QWORD PTR [rbp-64]
        movsx   rdx, edx
        mov     eax, DWORD PTR [rax+rdx*4]
        test    eax, eax    # Сравнение элементов массива a с 0 в цикле
        jns     .L8
        mov     edx, DWORD PTR i[rip]
        mov     rax, QWORD PTR [rbp-80]
        movsx   rdx, edx
        mov     DWORD PTR [rax+rdx*4], -1       # Записываем -1 в массив b, если элемент меньше 0
        jmp     .L9
.L8:
        mov     edx, DWORD PTR i[rip]
        mov     rax, QWORD PTR [rbp-64]
        movsx   rdx, edx
        mov     eax, DWORD PTR [rax+rdx*4]
        test    eax, eax    # Сравнение элементов массива a с 0 в цикле
        jle     .L10
        mov     edx, DWORD PTR i[rip]
        mov     rax, QWORD PTR [rbp-80]
        movsx   rdx, edx
        mov     DWORD PTR [rax+rdx*4], 1        # Записываем 1 в массив b, если элемент больше 0
        jmp     .L9
.L10:
        mov     edx, DWORD PTR i[rip]
        mov     rax, QWORD PTR [rbp-80]
        movsx   rdx, edx
        mov     DWORD PTR [rax+rdx*4], 0        # Записываем 0 в массив b, если элемент равен 0
.L9:    # Начало цикла с заполненнием массива b
        mov     eax, DWORD PTR i[rip]
        add     eax, 1
        mov     DWORD PTR i[rip], eax
.L7:
        mov     edx, DWORD PTR i[rip]
        mov     eax, DWORD PTR length[rip]
        cmp     edx, eax        # Сравниваем i и length, выходим из цикла, если i >= length
        jl      .L11
        mov     edi, 10
        call    putchar         # Печатаем пустую строку - разделитель для массива b
        mov     DWORD PTR i[rip], 0
        jmp     .L12
.L13:   # Вывод элементов массива b
        mov     edx, DWORD PTR i[rip]
        mov     rax, QWORD PTR [rbp-80]
        movsx   rdx, edx
        mov     edx, DWORD PTR [rax+rdx*4]
        mov     eax, DWORD PTR i[rip]
        mov     esi, eax
        lea     rdi, .LC4[rip]
        mov     eax, 0
        call    printf
        
        # Начало цикла вывода элементов массива b
        mov     eax, DWORD PTR i[rip]
        add     eax, 1
        mov     DWORD PTR i[rip], eax
.L12:
        mov     edx, DWORD PTR i[rip]
        mov     eax, DWORD PTR length[rip]
        cmp     edx, eax
        jl      .L13
        mov     eax, 0
.L4:    # Завершение программы
        mov     rsp, rbx
        lea     rsp, [rbp-40]
        pop     rbx
        pop     r12
        pop     r13
        pop     r14
        pop     r15
        pop     rbp
        ret