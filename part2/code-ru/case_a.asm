; "MC_case_a"
; Копирование пикселей из опорного кадра в текущий

            .def    _MC_case_a
            .sect   ".text"
            
_MC_case_a: .cproc  ref, curr, r_x, c_x, r_y, c_y, num_cols
            .reg    r_temp1, r_temp2, c_temp1, c_temp2
            .reg    p_r, p_c, np_r
            .reg    lshift, rshift, count
            .reg    r_w1, r_w2, r_w3, r_w4
            .reg    temp
    
    
; Вычисление указателей "p_c" и "p_r"

            SHL     r_x, 0x05, r_temp1       ; r_temp1 = r_x * NUM_COLS
            SHL     c_x, 0x05, c_temp1       ; c_temp1 = c_x * NUM_COLS
            
            ADD     r_y, ref, r_temp2        ; r_temp2 = ref + r_y
            ADD     c_y, curr, c_temp2       ; c_temp2 = curr + c_y
            
            ADD     r_temp1, r_temp2, p_r    ; p_r = r_temp1 + r_temp2
            ADD     c_temp1, c_temp2, p_c    ; p_c = c_temp1 + c_temp2
            
            SUB     num_cols, 2, num_cols    ; Обновляем p_r и p_c
            
            
; Инициализируем счётчик цикла

            MVK     8, count                ; 8 итераций цикла
    
; Получаем длину сдвига

            MVK     0xFFFC, temp            ; Получаем 2 бита LSBits
            AND     p_r, temp, np_r         ; Доступ только кратно слову
            AND     p_r, 0x0003, rshift     ; 2 LSB бита определяют выравнивание
            SUB.L   0x04, rshift, lshift    ; Получаем сдвиг "lshift"
            SHL     rshift, 0x03, rshift    ; # биты для сдвига влево
            SHL     lshift, 0x03, lshift    ; # биты для сдвига вправо
    
    
; Цикл

loop:       .trip   8
            LDW     *np_r++[1], r_w1        ; Загрузка первого слова
            LDW     *np_r++[1], r_w2        ; Загрузка второго слова
            LDW     *np_r++[num_cols], r_w3 ; Загрузка третьего слова
            
            SHRU    r_w1, rshift, r_w1      ; Освобождаем место для LSByte
            SHL     r_w3, lshift, r_w3      ; Освобождаем место для MSByte
            SHL     r_w2, lshift, r_w4      ; Получаем LSByte
            SHRU    r_w2, rshift, r_w2      ; Получаем MSByte
            
            OR      r_w1, r_w4, r_w1        ; Получаем актуальное первое слово
            OR      r_w2, r_w3, r_w2        ; Получаем актуальное второе слово
            
            STW     r_w1, *p_c++[1]         ; Сохраняем первое слово
            STW     r_w2, *p_c++[num_cols]  ; Сохраняем второе слово
            ADD     p_c, 4, p_c             ; Поскольку num_cols кратно слову
            
    [count] SUB     count, 1, count         ; Переход на следующую итерацию
    [count] B       loop
            .endproc