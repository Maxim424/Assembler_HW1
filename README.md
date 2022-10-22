# Assembler_HW1
"Архитектура вычислительных систем". Задание для самостоятельной работы №1.

Кузнецов Максим Вадимович, БПИ219. Вариант 4

### Условие

Массив B формируется по следующим правилам: 

B[i] = 1, если A[i] > 0,

B[i] = -1, если A[i] < 0,

B[i] = 0, если A[i] = 0.


### Решение на каждую оценку лежит в папке с соответствующим именем.

## На оценку 4

- Решение задачи на C приведено в файле task.c
- Максимальный размер массива: 2000 элементов
- Ассемблерная программа (task_1.s) получена и отредактирована согласно критериям, код содержит подробные комментарии
- Тесты и результаты тестовых прогонов приведены ниже (только значения массивов a и b, без подсказок для пользователя)
- Результаты тестовых прогонов одинаковы для обеих программ
- Все тесты содержатся в папке tests

Здесь в секции "Тест 1" вводятся 4 элемента массива a: 1, 0, -2 и 4. В секции "Результат 1" выводятся значения массива b: 1, 0, -1, 1.

### Тест 1

input: ``4 1 0 -2 4``.

output: ``1 0 -1 1``

### Тест 2

input: ``7 3 4 -5 -6 7 8 1``

output: ``1 1 -1 -1 1 1 1``

### Тест 3

input: ``0``

output: ``Incorrect length = 0``

### Тест 4

input: ``40000000``

output: ``Incorrect length = 40000000``

### Тест 5

inout: ``1 -2``

output: ``-1``

### Тест 6

input: ``5 0 0 0 0 0``

output: ``0 0 0 0 0``

## На оценку 5

- Название файлов осталось тем же
- В программе на языке C появились 2 функции, отвечающие за заполнение массива b и его вывод
- Также используются локальные переменные, вместо глобальных
- Ассемблерная программа (task_1.s) получена и отредактирована согласно критериям, добавлены новые комментарии
- Тесты такие же, как и в предыдущем пункте, обе программы отрабатывают корректно

Для преобразования кода на C в ассемблерный код была использована команда:

``gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-exceptions ./task.c -S -o ./task_1.s``

``-masm=intel`` нужен для того, чтобы использовался синтаксис intel

``-fno-asynchronous-unwind-tables`` убирает отладочную информацию

``-fno-jump-tables`` нужен для того, чтобы не использовать таблицы переходов

``-fno-exceptions`` для правильной работы с исключениями
