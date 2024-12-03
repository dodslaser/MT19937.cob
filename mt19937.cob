       >>DEFINE CONSTANT N 624
       >>DEFINE CONSTANT M 397
       >>DEFINE CONSTANT W 32
       >>DEFINE CONSTANT R 31
       >>DEFINE CONSTANT A 2567483615 *> 0x9908b0dfUL
       >>DEFINE CONSTANT U 11
       >>DEFINE CONSTANT S 7
       >>DEFINE CONSTANT T 15
       >>DEFINE CONSTANT L 18
       >>DEFINE CONSTANT B 2636928640 *> 0x9d2c5680UL
       >>DEFINE CONSTANT C 4022730752 *> 0xefc60000UL
       >>DEFINE CONSTANT D 4294967295 *> 0xffffffffUL
       >>DEFINE CONSTANT F 1812433253

       IDENTIFICATION DIVISION.
           PROGRAM-ID. mt19937.
           AUTHOR. dodslaser.

       ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
               REPOSITORY.
                   FUNCTION ALL INTRINSIC.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
               01 STATE-TABLE.
                   05 STATE OCCURS N TIMES BINARY-LONG UNSIGNED.
               77 UMASK BINARY-LONG UNSIGNED.
               77 LMASK BINARY-LONG UNSIGNED.
               77 IDX BINARY-SHORT UNSIGNED.
               77 N-VALUES BINARY-SHORT UNSIGNED.
               77 CHR-N-VALUES PIC Z(5).
               77 SEED BINARY-LONG UNSIGNED.
               77 CHR-SEED PIC Z(10).
               77 X BINARY-LONG UNSIGNED.
               77 Y BINARY-LONG UNSIGNED.
               77 CHR-Y PIC Z(10).


       PROCEDURE DIVISION.
           ACCEPT SEED FROM ENVIRONMENT "SEED"
                  ON EXCEPTION MOVE 5489 TO SEED.
           MOVE SEED TO CHR-SEED.
           DISPLAY "MT19937 (Seed: " TRIM(CHR-SEED) ")".

           ACCEPT N-VALUES FROM ENVIRONMENT "N"
                  ON EXCEPTION MOVE 10 TO N-VALUES.
           MOVE N-VALUES TO CHR-N-VALUES.
           DISPLAY "Generating " TRIM(CHR-N-VALUES) " values".

           COMPUTE UMASK = 4294967295 B-SHIFT-L R.
           COMPUTE LMASK = 4294967295 B-SHIFT-R (W - R).

           MOVE SEED TO STATE(1).
           PERFORM VARYING IDX FROM 2 BY 1
                   UNTIL IDX = N
               COMPUTE STATE(IDX) =
                   STATE(IDX - 1)
                   B-SHIFT-R (W - 2)
                   B-XOR STATE(IDX - 1) * F + IDX - 1
                   B-AND ((1 B-SHIFT-L W) - 1)
           END-PERFORM.

           DISPLAY SPACE.
           PERFORM N-VALUES TIMES
               PERFORM TEMPER
               MOVE Y TO CHR-Y
               DISPLAY HEX-OF(Y) " : " TRIM(CHR-Y)
           END-PERFORM.

           TWIST.
               PERFORM VARYING IDX FROM 1 BY 1
                       UNTIL IDX = N
                   COMPUTE X =
                       STATE(IDX)
                       B-AND UMASK
                       + STATE(MOD(IDX, N) + 1)
                   COMPUTE STATE(IDX) =
                       X
                       B-AND LMASK
                       B-SHIFT-R 1
                       B-XOR (A * MOD(X, 2))
                       B-XOR STATE(MOD(IDX + M, N))
               END-PERFORM.
               MOVE 1 TO IDX.

           TEMPER.
               IF IDX = N THEN PERFORM TWIST END-IF.
               MOVE STATE(IDX) TO Y.
               COMPUTE Y = Y B-XOR ((Y B-SHIFT-R U) B-AND D).
               COMPUTE Y = Y B-XOR ((Y B-SHIFT-L S) B-AND B).
               COMPUTE Y = Y B-XOR ((Y B-SHIFT-L T) B-AND C).
               COMPUTE Y = Y B-XOR (Y B-SHIFT-R L).
               COMPUTE Y = Y B-AND ((1 B-SHIFT-L W) - 1).
               COMPUTE IDX = IDX + 1.
