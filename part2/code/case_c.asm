; Linear Assembly version of "MC_case_c"

            .def    _MC_case_c
            .sect   ".text"
            
_MC_case_c: .cproc  ref, curr, r_x, c_x, r_y, c_y, num_cols, rounding
            .reg    p_r, p_c, ptr_temp
            .reg    r_temp1, r_temp2, c_temp1, c_temp2
            .reg    r_a, r_b, temp
            .reg    count, const
            
            
; Calculate pointers "p_c" and "p_r"

            SHL     r_x, 0x05, r_temp1      ; r_temp1 = r_x * NUM_COLS
            SHL     c_x, 0x05, c_temp1      ; c_temp1 = c_x * NUM_COLS
            
            ADD     r_y, ref, r_temp2       ; r_temp2 = ref + r_y
            ADD     c_y, curr, c_temp2      ; c_temp2 = curr + c_y
            
            ADD     r_temp1, r_temp2, p_r   ; p_r = r_temp1 + r_temp2
            ADD     c_temp1, c_temp2, p_c   ; p_c = c_temp1 + c_temp2
            
            SUB     1, rounding, const      ; const = 1 - rounding
            
            
; Initialize loop counter

            MVK     8, count                ; Loop performed 8 times
            
; Loop

loop:       .trip 8
            LDBU    *p_r++[num_cols], r_a       ; Load 1st byte
            
            LDBU    *p_r++[num_cols], r_b       ; Load 2nd byte
            ADD     r_a, const, temp            ; 1.1 First part of op
            ADD     r_b, temp, temp             ; 1.2 Second part of op
            SHRU    temp, 1, temp               ; 1.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 1.4 Store result
            
            LDBU    *p_r++[num_cols], r_a       ; Load 3rd byte
            ADD     r_b, const, temp            ; 2.1 First part of op
            ADD     r_a, temp, temp             ; 2.2 Second part of op
            SHRU    temp,1, temp                ; 2.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 2.4 Store result
            
            LDBU    *p_r++[num_cols], r_b       ; Load 4nd byte
            ADD     r_a, const, temp            ; 3.1 First part of op
            ADD     r_b, temp, temp             ; 3.2 Second part of op
            SHRU    temp, 1, temp               ; 3.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 3.4 Store result
            
            LDBU    *p_r++[num_cols], r_a       ; Load 5th byte
            ADD     r_b, const, temp            ; 4.1 First part of op
            ADD     r_a, temp, temp             ; 4.2 Second part of op
            SHRU    temp, 1, temp               ; 4.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 4.4 Store result
            
            LDBU    *p_r++[num_cols], r_b       ; Load 6th byte
            ADD     r_a, const, temp            ; 5.1 First part of op
            ADD     r_b, temp, temp             ; 5.2 Second part of op
            SHRU    temp, 1, temp               ; 5.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 5.4 Store result
            
            LDBU    *p_r++[num_cols], r_a       ; Load 7th byte
            ADD     r_b, const, temp            ; 6.1 First part of op
            ADD     r_a, temp, temp             ; 6.2 Second part of op
            SHRU    temp, 1, temp               ; 6.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 6.4 Store result
            
            LDBU    *p_r++[num_cols], r_b       ; Load 8th byte
            ADD     r_a, const, temp            ; 7.1 First part of op
            ADD     r_b, temp, temp             ; 7.2 Second part of op
            SHRU    temp, 1, temp               ; 7.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 7.4 Store result
            
            LDBU    *p_r, r_a                   ; Load 9th byte
            ADD     r_b, const, temp            ; 8.1 First part of op
            ADD     r_a, temp, temp             ; 8.2 Second part of op
            SHRU    temp, 1, temp               ; 8.3 Divide by 2 (w/truncation)
            STB     temp, *p_c++[num_cols]      ; 8.4 Store result
            
            SHL     num_cols, 0x03, ptr_temp    ; Multiply by 8
            
            SUB     p_r, ptr_temp, p_r          ; Adjust ptr to ref frame
            ADD     p_r, 0x01, p_r              ; Move p_r to next col
            
            SUB     p_c, ptr_temp, p_c          ; Adjust ptr to cur frame
            ADD     p_c, 0x01, p_c              ; Move p_c to next col
            
    [count] SUB     count, 1, count             ; Loop back
    [count] B       loop
            .endproc