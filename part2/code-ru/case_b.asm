; "MC_case_b"
; Билинейная интерполяция с половинной 
; точностью в горизонтальном направлении

            .def    _MC_case_b
            .sect   ".text"
            
MC_case_b:  .cproc  ref, curr, r_x, c_x, r_y, c_y, num_cols, rounding
            .reg    p_r, p_c
            .reg    r_temp1, r_temp2, c_temp1, c_temp2
            .reg    r_a, r_b, temp
            .reg    count, const
            
            
; Вычисление указателей "p_c" и "p_r"

            SHL     r_x, 0x05, r_temp1      ; r_temp1 = r_x * NUM_COLS
            SHL     c_x, 0x05, c_temp1      ; c_temp1 = c_x * NUM_COLS
            
            ADD     r_y, ref, r_temp2       ; r_temp2 = ref + r_y
            ADD     c_y, curr, c_temp2      ; c_temp2 = curr + c_y
            
            ADD     r_temp1, r_temp2, p_r   ; p_r = r_temp1 + r_temp2
            ADD     c_temp1, c_temp2, p_c   ; p_c = c_temp1 + c_temp2
            
            SUB     1, rounding, const      ; const = 1 - rounding
            
            
; Инициализируем счётчик цикла

            MVK     8, count            ; 8 итераций цикла
            

; Цикл

loop:       .trip   8

            LDBU    *+p_r[0], r_a       ; Загружаем первый байт
            
            LDBU    *+p_r[1], r_b       ; Загружаем второй байт
        
            ADD     r_a, const, temp    ; 1.1 Первая часть операции
            ADD     r_b, temp, temp     ; 1.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 1.3 Разделим на 2 с усечением
            STB     temp, *+p_c[0]      ; 1.4 Сохраняем результат
            
            LDBU    *+p_r[2], r_a       ; Загружаем третий байт
            ADD     r_b, const, temp    ; 2.1 Первая часть операции
            ADD     r_a, temp, temp     ; 2.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 2.3 Разделим на 2 с усечением
            STB     temp, *+p_c[1]      ; 2.4 Сохраняем результат
            
            LDBU    *+p_r[3], r_b       ; Загружаем четвертый байт
            ADD     r_a, const, temp    ; 3.1 Первая часть операции
            ADD     r_b, temp, temp     ; 3.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 3.3 Разделим на 2 с усечением
            STB     temp, *+p_c[2]      ; 3.4 Сохраняем результат
            
            LDBU    *+p_r[4], r_a       ; Загружаем пятый байт
            ADD     r_b, const, temp    ; 4.1 Первая часть операции
            ADD     r_a, temp, temp     ; 4.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 4.3 Разделим на 2 с усечением
            STB     temp, *+p_c[3]      ; 4.4 Сохраняем результат
            
            LDBU    *+p_r[5], r_b       ; Загружаем шестой байт
            ADD     r_a, const, temp    ; 5.1 Первая часть операции
            ADD     r_b, temp, temp     ; 5.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 5.3 Разделим на 2 с усечением
            STB     temp, *+p_c[4]      ; 5.4 Сохраняем результат
            
            LDBU    *+p_r[6], r_a       ; Загружаем седьмой байт
            ADD     r_b, const, temp    ; 6.1 Первая часть операции
            ADD     r_a, temp, temp     ; 6.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 6.3 Разделим на 2 с усечением
            STB     temp, *+p_c[5]      ; 6.4 Сохраняем результат
            
            LDBU    *+p_r[7], r_b       ; Загружаем восьмой байт
            ADD     r_a, const, temp    ; 7.1 Первая часть операции
            ADD     r_b, temp, temp     ; 7.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 7.3 Разделим на 2 с усечением
            STB     temp, *+p_c[6]      ; 7.4 Сохраняем результат
            
            LDBU    *+p_r[8], r_a       ; Загружаем девятый байт
            ADD     r_b, const, temp    ; 8.1 Первая часть операции
            ADD     r_a, temp, temp     ; 8.2 Вторая часть операции
            SHRU    temp, 1, temp       ; 8.3 Разделим на 2 с усечением
            STB     temp, *+p_c[7]      ; 8.4 Сохраняем результат
            
            ADD     p_c, num_cols, p_c  ; Перемещаем p_c в следующую строку
            ADD     p_r, num_cols, p_r  ; Перемещаем p_r в следующую строку
            
    [count] SUB     count, 1, count     ; Переход на следующую итерацию
    [count] B       loop
            .endproc