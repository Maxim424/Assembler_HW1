    .intel_syntax noprefix      # Используем синтаксис intel
    
    .section .rodata            # Строки, которые буду использоваться для ввода/вывода, read-only
.LC0:
    .string "b[%d] = %d\n"
    
    .section .text                      # Секция с функциями
    .globl    print_array               # Объявляем функцию как глобальную
    .type    print_array, @function     # Обозначаем, что print_array - это функция
print_array:        # Функция, которая печатает массив b
    push    rbp         # Пролог функции
    mov     rbp, rsp
    sub     rsp, 32
    # Вместо [rbp-24] используется регистр r13
    mov     r13, rdi    # Первый аргумент функции - массив b[]
    # Вместо [rbp-28] используется регистр r14d
    mov     r14d, esi   # Второй аргумент функции - length
    mov     edi, 10     # Передача кода 10 (перевод строки) в функцию putchar
    call    putchar     # Вывод пустой строки
    # Вместо [rbp-4] используется регистр r15d
    mov     r15d, 0     # Переменная i, локальная
    jmp     .L2         # Переход к метке .L2
.L3:
    mov     eax, r15d
    cdqe
    lea     rdx, [0+rax*4]
    mov     rax, r13
    add     rax, rdx
    mov     edx, DWORD PTR [rax]
    mov     eax, r15d
    mov     esi, eax        # Передаем i как параметр printf
    lea     rdi, .LC0[rip]  # Строка с подсказкой для пользователя
    mov     eax, 0
    call    printf          # Печать элемента массива
    add     r15d, 1         # Увеличиваем i на 1
.L2:
    mov     eax, r15d
    cmp     eax, r14d       # Проверка условия цикла
    jl      .L3             # Если меньше, переходим к метке .L3
    nop
    nop
    leave
    ret         # Выход из функции

    .global    calculate            # Объявляем функцию как глобальную
    .type    calculate, @function   # Обозначаем, что calculate - это функция
calculate:          # Функция, записывающая значения в массив b согласно условию
    push    rbp         # Пролог функции
    mov     rbp, rsp
    # Вместо [rbp-24] используется регистр r11
    mov     r11, rdi    # Первый аргумент функции - массив a[]
    # Вместо [rbp-32] используется регистр r12
    mov     r12, rsi    # Второй аргумент функции - массив b[]
    # Вместо [rbp-36] используется регистр r13d
    mov     r13d, edx   # Третий аргумент функции - length
    # Вместо [rbp-4] используется регистр r15d
    mov     r14d, 0     # Переменная i, локальная
    jmp     .L5         # Переход к метке .L5
.L9:
    mov     eax, r14d
    cdqe
    lea     rdx, [0+rax*4]          # Берем iй элемент массива
    mov     rax, r11
    add     rax, rdx
    mov     eax, DWORD PTR [rax]
    test    eax, eax                # Сравниваем: элемент меньше 0?
    jns     .L6                     # Если нет, переходим к метке .L6
    mov     eax, r14d
    cdqe
    lea     rdx, [0+rax*4]          # Вычисляет нужный адрес
    mov     rax, r12
    add     rax, rdx                # Прибавляем вычисленный адрес к началу массива
    mov     DWORD PTR [rax], -1     # Записывам -1, если элемент меньше 0
    jmp     .L7                     # Переходим к метке .L7
.L6:
    mov     eax, r14d
    cdqe
    lea     rdx, [0+rax*4]
    mov     rax, r11
    add     rax, rdx
    mov     eax, DWORD PTR [rax]
    test    eax, eax                # Сравниваем: элемент больше 0?
    jle     .L8                     # Переходим к метке .L7
    mov     eax, r14d
    cdqe
    lea     rdx, [0+rax*4]
    mov     rax, r12
    add     rax, rdx
    mov     DWORD PTR [rax], 1      # Записывам 1, если элемент меньше 0
    jmp     .L7                     # Переходим к метке .L7
.L8:
    mov     eax, r14d
    cdqe
    lea     rdx, [0+rax*4]
    mov     rax, r12
    add     rax, rdx
    mov     DWORD PTR [rax], 0      # Записывам 0, если элемент равен 0
.L7:
    add     r14d, 1                 # Увеличиваем i на 1
.L5:
    mov     eax, r14d
    cmp     eax, r13d               # Проверка условия цикла
    jl      .L9                     # Переходим к метке .L9
    nop
    nop
    pop     rbp
    ret

    .section .rodata    # Строки, которые буду использоваться для ввода/вывода
.LC1:
    .string "Input length: "
.LC2:
    .string "%d"
.LC3:
    .string "Incorrect length = %d\n"
.LC4:
    .string "a[%d]? "

    .section .text      # Секция с функциями
    .global main        # Объявляем функцию как глобальную
    .type    main, @function    # Обозначаем, что main - это функция
main:       # Точка входа в программу
push    rbp     # Пролог
mov     rbp, rsp
push    r15
push    r14
push    r13
push    r12
push    rbx
sub     rsp, 88
mov     rax, rsp
mov     rbx, rax
lea     rdi, .LC1[rip]  # Добавляем строку .LC1 в качестве аргумента функци printf
mov     eax, 0
call    printf          #  Вывод подсказки для ввода длины массива
lea     rax, [rbp-92]
mov     rsi, rax
lea     rdi, .LC2[rip]  # Добавляем строку .LC2 в качестве аргумента функци scanf
mov     eax, 0
call    __isoc99_scanf  #  Ввод длины массива
mov     eax, DWORD PTR [rbp-92]
test    eax, eax        # Если длина меньше 1, печатаем ошибку
jle     .L11            # Переходим к метке .L11
mov     eax, DWORD PTR [rbp-92]
cmp     eax, 2000       # Если длина больше 2000, печатаем ошибку
jle     .L12            # Переходим к метке .L12
.L11:
mov     eax, DWORD PTR [rbp-92]
mov     esi, eax
lea     rdi, .LC3[rip]  # Добавляем строку .LC3 в качестве аргумента функци printf
mov     eax, 0
call    printf          # Вывод ошибки о некорректном размере массива
mov     eax, 1
jmp     .L13            # Переходим к метке .L13
.L12:
# Массив a
mov     eax, DWORD PTR [rbp-92]
movsx   rdx, eax
sub     rdx, 1
mov     QWORD PTR [rbp-64], rdx
movsx   rdx, eax
mov     QWORD PTR [rbp-112], rdx
mov     QWORD PTR [rbp-104], 0
movsx   rdx, eax
mov     QWORD PTR [rbp-128], rdx
mov     QWORD PTR [rbp-120], 0
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
mov     QWORD PTR [rbp-72], rax

# Массив b
mov     eax, DWORD PTR [rbp-92]
movsx   rdx, eax
sub     rdx, 1
mov     QWORD PTR [rbp-80], rdx
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
mov     QWORD PTR [rbp-88], rax
mov     r14d, 0 # Переменная i, локальная
jmp     .L14        # Переходим к метке .L14
.L15:
mov     eax, r14d
mov     esi, eax
lea     rdi, .LC4[rip]  # Добавляем строку .LC4 в качестве аргумента функци printf
mov     eax, 0
call    printf          # Вывод подсказки для ввода массива
mov     eax, r14d
cdqe
lea     rdx, [0+rax*4]
mov     rax, QWORD PTR [rbp-72]
add     rax, rdx
mov     rsi, rax
lea     rdi, .LC2[rip]      # Добавляем строку .LC2 в качестве аргумента функци scanf
mov     eax, 0
call    __isoc99_scanf      # Ввод элемента массива
add     r14d, 1   # Увеличиваем i на 1
.L14:
mov     eax, DWORD PTR [rbp-92]
cmp     r14d, eax           # Проверяем условие цикла
jl      .L15
mov     edx, DWORD PTR [rbp-92]     # Передача третьего аргумента в функцию
mov     rcx, QWORD PTR [rbp-88]     # Запись второго аргумента в rcx
mov     rax, QWORD PTR [rbp-72]     # Запись первого аргумента в rax
mov     rsi, rcx            # Передача второго аргумента в функцию
mov     rdi, rax            # Передача первого аргумента в функцию
call    calculate           # Вызов функции calculate
mov     edx, DWORD PTR [rbp-92]     # Запись второго аргумента в edx
mov     rax, QWORD PTR [rbp-88]     # Запись первого аргумента в rax
mov     esi, edx            # Передача второго аргумента в функцию
mov     rdi, rax            # Передача первого аргумента в функцию
call    print_array         # Вызов функции print_array
mov     eax, 0
.L13:   # Выход из программы
mov     rsp, rbx
lea     rsp, [rbp-40]
pop     rbx
pop     r12
pop     r13
pop     r14
pop     r15
pop     rbp
ret