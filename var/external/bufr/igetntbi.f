	FUNCTION IGETNTBI ( LUN, CTB )

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    IGETNTBI
C   PRGMMR: ATOR            ORG: NP12       DATE: 2009-03-23
C
C ABSTRACT: THIS FUNCTION RETURNS THE NEXT AVAILABLE INDEX FOR
C   STORING AN ENTRY WITHIN INTERNAL BUFR TABLE CTB.
C
C PROGRAM HISTORY LOG:
C 2009-03-23  J. ATOR    -- ORIGINAL AUTHOR
C
C USAGE:    CALL IGETNTBI ( LUN, CTB )
C   INPUT ARGUMENT LIST:
C     LUN      - INTEGER: I/O STREAM INDEX INTO INTERNAL MEMORY ARRAYS
C     CTB      - CHARACTER*1: INTERNAL BUFR TABLE FROM WHICH TO RETURN
C                THE NEXT AVAILABLE INDEX ('A','B', OR 'D')
C
C   OUTPUT ARGUMENT LIST:
C     IGETNTBI  - INTEGER: NEXT AVAILABLE INDEX IN TABLE CTB
C
C REMARKS:
C    THIS ROUTINE CALLS:        BORT
C    THIS ROUTINE IS CALLED BY: RDUSDX   READS3   STBFDX   STSEQ
C                               Not normally called by application
C                               programs.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

	INCLUDE 'bufrlib.prm'

	COMMON /TABABD/ NTBA(0:NFILES),NTBB(0:NFILES),NTBD(0:NFILES),
     .			MTAB(MAXTBA,NFILES),IDNA(MAXTBA,NFILES,2),
     .			IDNB(MAXTBB,NFILES),IDND(MAXTBD,NFILES),
     .			TABA(MAXTBA,NFILES),TABB(MAXTBB,NFILES),
     .			TABD(MAXTBD,NFILES)

	CHARACTER*600 TABD
	CHARACTER*128 TABA, TABB, BORT_STR
	CHARACTER*1   CTB

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

	IF ( CTB .EQ. 'A' ) THEN
	  IGETNTBI = NTBA(LUN) + 1
	  IMAX = NTBA(0)
	ELSE IF ( CTB .EQ. 'B' ) THEN
	  IGETNTBI = NTBB(LUN) + 1
	  IMAX = NTBB(0)
	ELSE IF ( CTB .EQ. 'D' ) THEN
	  IGETNTBI = NTBD(LUN) + 1
	  IMAX = NTBD(0)
	ENDIF
	IF ( IGETNTBI .GT. IMAX ) GOTO 900

	RETURN
900	WRITE(BORT_STR,'("BUFRLIB: IGETNTBI - NUMBER OF INTERNAL TABLE'
     .    //'",A1," ENTRIES EXCEEDS THE LIMIT (",I4,")")') CTB, IMAX
	CALL BORT(BORT_STR)
	END
