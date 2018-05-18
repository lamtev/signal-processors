; Linear Assembly version of "MC_case_a"

            .def    _MC_case_a
            .sect   ".text"
            
_MC_case_a: .cproc  ref, curr, r_x, c_x, r_y, c_y, num_cols
            .reg    r_temp1, r_temp2, c_temp1, c_temp2
            .reg    p_r, p_c, np_r
            .reg    lshift, rshift, count
            .reg    r_w1, r_w2, r_w3, r_w4
            .reg    temp
    
    
; Calculate pointers "p_c" and "p_r"

            SHL     r_x, 0x05, r_temp1       ; r_temp1 = r_x * NUM_COLS
            SHL     c_x, 0x05, c_temp1       ; c_temp1 = c_x * NUM_COLS
            
            ADD     r_y, ref, r_temp2        ; r_temp2 = ref + r_y
            ADD     c_y, curr, c_temp2       ; c_temp2 = curr + c_y
            
            ADD     r_temp1, r_temp2, p_r    ; p_r = r_temp1 + r_temp2
            ADD     c_temp1, c_temp2, p_c    ; p_c = c_temp1 + c_temp2
            
            SUB     num_cols, 2, num_cols    ; To update np_r and p_c
            
            
; Initialize loop counter

            MVK     8, count                ; Loop performed 8 times
    
; Obtain distance for shifting

            MVK     0xFFFC, temp            ; To obtain two LSBits
            AND     p_r, temp, np_r         ; Word-aligned access only
            AND     p_r, 0x0003, rshift     ; Two LSB define alignment
            SUB.L   0x04, rshift, lshift    ; Obtain "lshift"
            SHL     rshift, 0x03, rshift    ; # bits for left shift
            SHL     lshift, 0x03, lshift    ; # bits for right shift
    
    
; Loop

loop:       .trip   8
            LDW     *np_r++[1], r_w1        ; Load first word
            LDW     *np_r++[1], r_w2        ; Load second word
            LDW     *np_r++[num_cols], r_w3 ; Load third word
            
            SHRU    r_w1, rshift, r_w1      ; Make room for LSByte
            SHL     r_w3, lshift, r_w3      ; Make room for MSByte
            SHL     r_w2, lshift, r_w4      ; Get LSByte
            SHRU    r_w2, rshift, r_w2      ; Get MSByte
            
            OR      r_w1, r_w4, r_w1        ; Obtain actual 1st word
            OR      r_w2, r_w3, r_w2        ; Obtain actual 2nd word
            
            STW     r_w1, *p_c++[1]         ; Store 1st word
            STW     r_w2, *p_c++[num_cols]  ; Store 2nd word
            ADD     p_c, 4, p_c             ; Since num_cols is short by a word
            
    [count] SUB     count, 1, count         ; Loop back
    [count] B       loop
            .endproc