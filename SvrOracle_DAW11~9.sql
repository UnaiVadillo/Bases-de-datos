
CONSTRAINT_NAME                                                                                                                  TABLE_NAME                                                                                                                       SEARCH_CONDITION                                                                 C
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------- -
ALU_FECHA_CK                                                                                                                     ALUMNOS                                                                                                                          FECHA_NAC<FECHA_ALTA                                                             C
ALU_SEX_CK                                                                                                                       ALUMNOS                                                                                                                          SEXO IN('M','F')                                                                 C
SYS_C00119590                                                                                                                    ALUMNOS                                                                                                                          "NOMBRE" IS NOT NULL                                                             C
SYS_C00119595                                                                                                                    ALUMNOS                                                                                                                          "SEXO" IS NOT NULL                                                               C
CURSO_CK                                                                                                                         ALUMNOS                                                                                                                          CURSO IN (1,2,3)                                                                 C
NOMBRE_CK                                                                                                                        ALUMNOS                                                                                                                          NOMBRE= UPPER(NOMBRE)                                                            C
DNI_PK                                                                                                                           ALUMNOS                                                                                                                                                                                                           P

7 filas seleccionadas. 
