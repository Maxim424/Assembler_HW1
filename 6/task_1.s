.intel_syntax noprefix

.section .rodata    # Строки, которые буду использоваться для ввода/вывода, read-only
.LC0:
.string "b[%d] = %d\n"

.section .text
.globl    print_array
.type    print_array, @function
print_array:        # Функция, которая печатает массив b
push    rbp     # Пролог функции
mov     rbp, rsp
sub     rsp, 32
mov     QWORD PTR [rbp-24], rdi     # Первый аргумент функции
mov     DWORD PTR [rbp-28], esi     # Второй аргумент функции
mov     edi, 10
call    putchar     # Вывод пустой строки
mov     DWORD PTR [rbp-4], 0        # Переменная i
jmp     .L2         # Переход к метке .L2
.L3:
mov     eax, DWORD PTR [rbp-4]
cdqe
lea     rdx, [0+rax*4]
mov     rax, QWORD PTR [rbp-24]
add     rax, rdx
mov     edx, DWORD PTR [rax]
mov     eax, DWORD PTR [rbp-4]
mov     esi, eax
lea     rdi, .LC0[rip]       # Строка с подсказкой для пользователя
mov     eax, 0
call    printf          # Печать элемента массива
add     DWORD PTR [rbp-4], 1    # Увеличиваем i на 1
.L2:
mov     eax, DWORD PTR [rbp-4]
cmp     eax, DWORD PTR [rbp-28]     # Проверка условия цикла
jl      .L3             # Если меньше, переходим к метке .L3
nop
nop
leave
ret         # Выход из функции

.global    calculate
.type    calculate, @function
calculate:          # Функция, записывающая значения в массив b согласно условию
push    rbp     # Пролог функции
mov     rbp, rsp
mov     QWORD PTR [rbp-24], rdi     # Первый аргумент функции
mov     QWORD PTR [rbp-32], rsi     # Второй аргумент функции
mov     DWORD PTR [rbp-36], edx     # Третий аргумент функции
mov     DWORD PTR [rbp-4], 0        # Переменная i
jmp     .L5                         # Переход к метке .L5
.L9:
mov     eax, DWORD PTR [rbp-4]
cdqe
lea     rdx, [0+rax*4]          # Берем iй элемент массива
mov     rax, QWORD PTR [rbp-24]
add     rax, rdx
mov     eax, DWORD PTR [rax]
test    eax, eax                # Сравниваем: элемент меньше 0?
jns     .L6                     # Если нет, переходим к метке .L6
mov     eax, DWORD PTR [rbp-4]
cdqe
lea     rdx, [0+rax*4]          # Вычисляет нужный адрес
mov     rax, QWORD PTR [rbp-32]
add     rax, rdx                # Прибавляем вычисленный адрес к началу массива
mov     DWORD PTR [rax], -1     # Записывам -1, если элемент меньше 0
jmp     .L7                     # Переходим к метке .L7
.L6:
mov     eax, DWORD PTR [rbp-4]
cdqe
lea     rdx, [0+rax*4]
mov     rax, QWORD PTR [rbp-24]
add     rax, rdx
mov     eax, DWORD PTR [rax]
test    eax, eax                # Сравниваем: элемент больше 0?
jle     .L8
mov     eax, DWORD PTR [rbp-4]
cdqe
lea     rdx, [0+rax*4]
mov     rax, QWORD PTR [rbp-32]
add     rax, rdx
mov     DWORD PTR [rax], 1      # Записывам 1, если элемент меньше 0
jmp     .L7
.L8:
mov     eax, DWORD PTR [rbp-4]
cdqe
lea     rdx, [0+rax*4]
mov     rax, QWORD PTR [rbp-32]
add     rax, rdx
mov     DWORD PTR [rax], 0          # Записывам 0, если элемент равен 0
.L7:
add     DWORD PTR [rbp-4], 1        # Увеличиваем i на 1
.L5:
mov     eax, DWORD PTR [rbp-4]
cmp     eax, DWORD PTR [rbp-36]     # Проверка условия цикла
jl      .L9
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

.section .text
.global main
.type    main, @function
main:       # Точка входа в программу
push    rbp
mov     rbp, rsp
push    r15
push    r14
push    r13
push    r12
push    rbx
sub     rsp, 88
mov     rax, rsp
mov     rbx, rax
lea     rdi, .LC1[rip]
mov     eax, 0
call    printf          #  Вывод подсказки для ввода длины массива
lea     rax, [rbp-92]
mov     rsi, rax
lea     rdi, .LC2[rip]
mov     eax, 0
call    __isoc99_scanf      #  Ввод длины массива
mov     eax, DWORD PTR [rbp-92]
test    eax, eax        # Если длина меньше 1, печатаем ошибку
jle     .L11
mov     eax, DWORD PTR [rbp-92]
cmp     eax, 2000       # Если длина больше 2000, печатаем ошибку
jle     .L12
.L11:
mov     eax, DWORD PTR [rbp-92]
mov     esi, eax
lea     rdi, .LC3[rip]
mov     eax, 0
call    printf      # Вывод ошибки о некорректном размере массива
mov     eax, 1
jmp     .L13
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
mov     DWORD PTR [rbp-52], 0
jmp     .L14
.L15:
mov     eax, DWORD PTR [rbp-52]
mov     esi, eax
lea     rdi, .LC4[rip]
mov     eax, 0
call    printf          # Вывод подсказки для ввода массива
mov     eax, DWORD PTR [rbp-52]
cdqe
lea     rdx, [0+rax*4]
mov     rax, QWORD PTR [rbp-72]
add     rax, rdx
mov     rsi, rax
lea     rdi, .LC2[rip]
mov     eax, 0
call    __isoc99_scanf      # Ввод элемента массива
add     DWORD PTR [rbp-52], 1
.L14:
mov     eax, DWORD PTR [rbp-92]
cmp     DWORD PTR [rbp-52], eax
jl      .L15
mov     edx, DWORD PTR [rbp-92]     # Передача третьего аргумента в функцию
mov     rcx, QWORD PTR [rbp-88]
mov     rax, QWORD PTR [rbp-72]
mov     rsi, rcx            # Передача второго аргумента в функцию
mov     rdi, rax            # Передача первого аргумента в функцию
call    calculate           # Вызов функции calculate
mov     edx, DWORD PTR [rbp-92]
mov     rax, QWORD PTR [rbp-88]
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
