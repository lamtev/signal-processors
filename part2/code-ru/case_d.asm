; "MC_case_d"
; Билинейная интерполяция с половинной точностью 
; в горизонтальном и вертикальном направлении

            .def    _MC_case_d
            .sect   ".text"
            
_MC_case_d: .cproc  ref, curr, r_x, c_x, r_y, c_y, num_cols, rounding
            .reg    p_r, p_r1, p_r2, p_c
            .reg    r_temp1, r_temp2, c_temp1, c_temp2
            .reg    r_a1, r_a2, r_b1, r_b2, temp, temp1, temp2
            .reg    count, const, ptr_temp
            
            
; Вычисление указателей "p_c" и "p_r"

            SHL     r_x, 0x05, r_temp1      ; r_temp1 = r_x * NUM_COLS
            SHL     c_x, 0x05, c_temp1      ; c_temp1 = c_x * NUM_COLS
            
            ADD     r_y, ref, r_temp2       ; r_temp2 = ref + r_y
            ADD     c_y, curr, c_temp2      ; c_temp2 = curr + c_y
            
            ADD     r_temp1, r_temp2, p_r   ; p_r = r_temp1 + r_temp2
            ADD     c_temp1, c_temp2, p_c   ; p_c = c_temp1 + c_temp2
            
            SUB     2, rounding, const      ; const = 2 - rounding
            
; Инициализируем счётчик цикла

            MVK     8, count                ; 8 итераций цикла
            MV      p_r, p_r1
            ADD     p_r, num_cols, p_r2
            
; Цикл

loop:       .trip   8
            LDBU    *+p_r1[0], r_a1         ; Загружаем 1 байт/1 пару
            LDBU    *+p_r2[0], r_a2         ; Загружаем 2 байт/1 пару
            ADD     r_a1, r_a2, temp1
            
            LDBU    *+p_r1[1], r_b1         ; Загружаем 1 байт/2 пару
            LDBU    *+p_r2[1], r_b2         ; Загружаем 2 байт/2 пару
            ADD     temp1, const, temp1     ; 1.1 Первая часть операции
            ADD     r_b1, r_b2, temp2       ; 1.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 1.3 Третья часть операции
            SHRU    temp, 2, temp           ; 1.4 Разделим на 4 с усечением
            STB     temp, *+p_c[0]          ; 1.5 Сохраняем результат
            
            LDBU    *+p_r1[2], r_a1         ; Загружаем 1 байт/3 пару
            LDBU    *+p_r2[2], r_a2         ; Загружаем 2 байт/3 пару
            ADD     temp2, const, temp2     ; 2.1 Первая часть операции
            ADD     r_a1, r_a2, temp1       ; 2.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 2.3 Третья часть операции
            SHRU    temp, 2, temp           ; 2.4 Разделим на 4 с усечением
            STB     temp, *+p_c[1]          ; 2.5 Сохраняем результат
            
            LDBU    *+p_r1[3], r_b1         ; Загружаем 1 байт/4 пару
            LDBU    *+p_r2[3], r_b2         ; Загружаем 2 байт/4 пару
            ADD     temp1, const, temp1     ; 3.1 Первая часть операции
            ADD     r_b1, r_b2, temp2       ; 3.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 3.3 Третья часть операции
            SHRU    temp, 2, temp           ; 3.4 Разделим на 4 с усечением
            STB     temp, *+p_c[2]          ; 3.5 Сохраняем результат
            
            LDBU    *+p_r1[4], r_a1         ; Загружаем 1 байт/5 пару
            LDBU    *+p_r2[4], r_a2         ; Загружаем 2 байт/5 пару
            ADD     temp2, const, temp2     ; 4.1 Первая часть операции
            ADD     r_a1, r_a2, temp1       ; 4.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 4.3 Третья часть операции
            SHRU    temp, 2, temp           ; 4.4 Разделим на 4 с усечением
            STB     temp, *+p_c[3]          ; 4.5 Сохраняем результат
            
            LDBU    *+p_r1[5], r_b1         ; Загружаем 1 байт/6 пару
            LDBU    *+p_r2[5], r_b2         ; Загружаем 2 байт/6 пару
            ADD     temp1, const, temp1     ; 5.1 Первая часть операции
            ADD     r_b1, r_b2, temp2       ; 5.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 5.3 Третья часть операции
            SHRU    temp, 2, temp           ; 5.4 Разделим на 4 с усечением
            STB     temp, *+p_c[4]          ; 5.5 Сохраняем результат
            
            LDBU    *+p_r1[6], r_a1         ; Загружаем 1 байт/7 пару
            LDBU    *+p_r2[6], r_a2         ; Загружаем 2 байт/7 пару
            ADD     temp2, const, temp2     ; 6.1 Первая часть операции
            ADD     r_a1, r_a2, temp1       ; 6.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 6.3 Третья часть операции
            SHRU    temp, 2, temp           ; 6.4 Разделим на 4 с усечением
            STB     temp, *+p_c[5]          ; 6.5 Сохраняем результат
            
            LDBU    *+p_r1[7], r_b1         ; Загружаем 1 байт/8 пару
            LDBU    *+p_r2[7], r_b2         ; Загружаем 2 байт/8 пару
            ADD     temp1, const, temp1     ; 7.1 Первая часть операции
            ADD     r_b1, r_b2, temp2       ; 7.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 7.3 Третья часть операции
            SHRU    temp, 2, temp           ; 7.4 Разделим на 4 с усечением
            STB     temp, *+p_c[6]          ; 7.5 Сохраняем результат
            
            LDBU    *+p_r1[8], r_a1         ; Загружаем 1 байт/9 пару
            LDBU    *+p_r2[8], r_a2         ; Загружаем 2 байт/9 пару
            ADD     temp2, const, temp2     ; 8.1 Первая часть операции
            ADD     r_a1, r_a2, temp1       ; 8.2 Вторая часть операции
            ADD     temp1, temp2, temp      ; 8.3 Третья часть операции
            SHRU    temp, 2, temp           ; 8.4 Разделим на 4 с усечением
            STB     temp, *+p_c[7]          ; 8.5 Сохраняем результат
            
            ADD     p_r1, num_cols, p_r1    ; Перемещаем p_r1 в следующий столбец
            ADD     p_r2, num_cols, p_r2    ; Перемещаем p_r2 в следующий столбец
            ADD     p_c, num_cols, p_c      ; Перемещаем p_c в следующий столбец
            
    [count] SUB     count, 1, count         ; Переход на следующую итерацию
    [count] B       loop
            .endproc