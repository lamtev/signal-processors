; Linear Assembly version of "MC_case_d"

            .def    _MC_case_d
            .sect   ".text"
            
_MC_case_d: .cproc  ref, curr, r_x, c_x, r_y, c_y, num_cols, rounding
            .reg    p_r, p_r1, p_r2, p_c
            .reg    r_temp1, r_temp2, c_temp1, c_temp2
            .reg    r_a1, r_a2, r_b1, r_b2, temp, temp1, temp2
            .reg    count, const, ptr_temp
            
            
; Calculate pointers "p_c" and "p_r"

            SHL     r_x, 0x05, r_temp1      ; r_temp1 = r_x * NUM_COLS
            SHL     c_x, 0x05, c_temp1      ; c_temp1 = c_x * NUM_COLS
            
            ADD     r_y, ref, r_temp2       ; r_temp2 = ref + r_y
            ADD     c_y, curr, c_temp2      ; c_temp2 = curr + c_y
            
            ADD     r_temp1, r_temp2, p_r   ; p_r = r_temp1 + r_temp2
            ADD     c_temp1, c_temp2, p_c   ; p_c = c_temp1 + c_temp2
            
            SUB     2, rounding, const      ; const = 2 - rounding
            
; Initialize loop counter

            MVK     8, count                ; Loop performed 8 times
            MV      p_r, p_r1
            ADD     p_r, num_cols, p_r2
            
; Loop

loop:       .trip   8
            LDBU    *+p_r1[0], r_a1         ; Load 1st byte/1st pair
            LDBU    *+p_r2[0], r_a2         ; Load 2nd byte/1st pair
            ADD     r_a1, r_a2, temp1
            
            LDBU    *+p_r1[1], r_b1         ; Load 1st byte/2nd pair
            LDBU    *+p_r2[1], r_b2         ; Load 2nd byte/2nd pair
            ADD     temp1, const, temp1     ; 1.1 First part of op
            ADD     r_b1, r_b2, temp2       ; 1.2 Second part of op
            ADD     temp1, temp2, temp      ; 1.3 Third part of op
            SHRU    temp, 2, temp           ; 1.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[0]          ; 1.5 Store result
            
            LDBU    *+p_r1[2], r_a1         ; Load 1st byte/3rd pair
            LDBU    *+p_r2[2], r_a2         ; Load 2nd byte/3rd pair
            ADD     temp2, const, temp2     ; 2.1 First part of op
            ADD     r_a1, r_a2, temp1       ; 2.2 Second part of op
            ADD     temp1, temp2, temp      ; 2.3 Third part of op
            SHRU    temp, 2, temp           ; 2.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[1]          ; 2.5 Store result
            
            LDBU    *+p_r1[3], r_b1         ; Load 1st byte/4th pair
            LDBU    *+p_r2[3], r_b2         ; Load 2nd byte/4th pair
            ADD     temp1, const, temp1     ; 3.1 First part of op
            ADD     r_b1, r_b2, temp2       ; 3.2 Second part of op
            ADD     temp1, temp2, temp      ; 3.3 Third part of op
            SHRU    temp, 2, temp           ; 3.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[2]          ; 3.5 Store result
            
            LDBU    *+p_r1[4], r_a1         ; Load 1st byte/5th pair
            LDBU    *+p_r2[4], r_a2         ; Load 2nd byte/5th pair
            ADD     temp2, const, temp2     ; 4.1 First part of op
            ADD     r_a1, r_a2, temp1       ; 4.2 Second part of op
            ADD     temp1, temp2, temp      ; 4.3 Third part of op
            SHRU    temp, 2, temp           ; 4.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[3]          ; 4.5 Store result
            
            LDBU    *+p_r1[5], r_b1         ; Load 1st byte/6th pair
            LDBU    *+p_r2[5], r_b2         ; Load 2nd byte/6th pair
            ADD     temp1, const, temp1     ; 5.1 First part of op
            ADD     r_b1, r_b2, temp2       ; 5.2 Second part of op
            ADD     temp1, temp2, temp      ; 5.3 Third part of op
            SHRU    temp, 2, temp           ; 5.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[4]          ; 5.5 Store result
            
            LDBU    *+p_r1[6], r_a1         ; Load 1st byte/7th pair
            LDBU    *+p_r2[6], r_a2         ; Load 2nd byte/7th pair
            ADD     temp2, const, temp2     ; 6.1 First part of op
            ADD     r_a1, r_a2, temp1       ; 6.2 Second part of op
            ADD     temp1, temp2, temp      ; 6.3 Third part of op
            SHRU    temp, 2, temp           ; 6.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[5]          ; 6.5 Store result
            
            LDBU    *+p_r1[7], r_b1         ; Load 1st byte/8th pair
            LDBU    *+p_r2[7], r_b2         ; Load 2nd byte/8th pair
            ADD     temp1, const, temp1     ; 7.1 First part of op
            ADD     r_b1, r_b2, temp2       ; 7.2 Second part of op
            ADD     temp1, temp2, temp      ; 7.3 Third part of op
            SHRU    temp, 2, temp           ; 7.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[6]          ; 7.5 Store result
            
            LDBU    *+p_r1[8], r_a1         ; Load 1st byte/9th pair
            LDBU    *+p_r2[8], r_a2         ; Load 2nd byte/9th pair
            ADD     temp2, const, temp2     ; 8.1 First part of op
            ADD     r_a1, r_a2, temp1       ; 8.2 Second part of op
            ADD     temp1, temp2, temp      ; 8.3 Third part of op
            SHRU    temp, 2, temp           ; 8.4 Divide by 4 (w/truncation)
            STB     temp, *+p_c[7]          ; 8.5 Store result
            
            ADD     p_r1, num_cols, p_r1    ; Move p_r1 to next col
            ADD     p_r2, num_cols, p_r2    ; Move p_r2 to next col
            ADD     p_c, num_cols, p_c      ; Move p_c to next col
            
    [count] SUB     count, 1, count         ; Loop back
    [count] B       loop
            .endproc