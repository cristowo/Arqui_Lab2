	.data
p1: .asciiz "Por favor ingrese el numero entero: "
ps: .asciiz "El logaritmo natural por expansiones de Taylor (ln(1+x)) es: "
TEN: .float 10.0	
ZERO: .float 0.0
ACUM: .float 0.0
ONE: .float 1.0
DEC: .float 0.1
DEC2: .float 0.01
TWO: .float 2.0
TRHEE: .float 3.0
FOUR: .float 4.0
FIVE: .float 5.0
SIX: .float 6.0
SEVEN: .float 7.0
	.text

l.s $f6, ACUM
l.s $f7, ONE
l.s $f8, ZERO
l.s $f31, TWO
l.s $f29, TRHEE
l.s $f27, FOUR
l.s $f28, FIVE
l.s $f26, SIX
#resultado de multiplicacion y division se guardaran en f2, tener ojo
#---------------------------------------------------------------------------------------
li $v0, 4			#syscall para imprimir string
la $a0, p1			#pl sera la frase a imprimir en la consola
syscall

li $v0, 6			#syscall para leer un float simple
syscall
add.s $f19, $f0, $f19
#---------------------------------------------------------------------------------------
#-IMPLEMENTACION DE LA MULTIPLICACION-------LOGARITMO NATURAL---------------------------
veri:
c.eq.s $f8, $f0			#verifica si son 0 o si son negativos
bc1t end			#simplemente es un paso de verificacion 
c.lt.s $f8, $f0			#para que se trabaje mejor
bc1f veri2			#en el problema 3.B tambien esta presente
#---------------------------------------------------------------------------------------
add.s $f1, $f0, $f1
casos:
caso2:				#cuando se eleva por 2
c.eq.s $f30, $f7		#compureba que sea el acum($f30) sea igual a 1
bc1f caso3
add.s $f20, $f20, $f2

caso3:				#cuando se eleva por 3
c.eq.s $f30, $f31		#el elevado a 4 estara en el end
bc1f caso4			#yaque ese sera el ultimo(se nos pidio trabajar con numeros
add.s $f21, $f21, $f2		#cercanos al 0, por lo que entendi)

caso4:				#cuando se eleva por 4
c.eq.s $f30, $f29		
bc1f caso5			
add.s $f22, $f22, $f2	

caso5:				#cuando se eleva por 5
c.eq.s $f30, $f27		
bc1f caso6			
add.s $f23, $f23, $f2	

caso6:				#cuando se eleva por 6
c.eq.s $f30, $f28		
bc1f operaciontraspaso		
add.s $f24, $f24, $f2	

operaciontraspaso:		
add.s $f30, $f30, $f7		#aqui se suma 1 al acum
add.s $f1, $f1, $f2		#aqui $f1 toma el valor de $f2
l.s $f2, ZERO
#---------------------------------------------------------------------------------------
while:
c.le.s $f1, $f8			#while principal
bc1f operacion			#ira comprobando hasta que f1 llegue a 0
#---------------------------------------------------------------------------------------
end:
c.lt.s $f30, $f26 		#este es el caso para 4
bc1t casos			#volvera a casos y si esta listo 
add.s $f25, $f25, $f2		#se guardara el valor de f2 en f22
j paso2
#---------------------------------------------------------------------------------------
operacion:
add.s $f2, $f2, $f0		#operacion principal
sub.s $f1, $f1, $f7		#gurda en f2 la suma con f0 y f1 va disminuyendo
j while
#---CASO EN DONDE UNO O LOS 2 NUMEROS SON NEGATIVOS-------------------------------------
veri2:
sub.s $f0, $f8, $f0
add.s $f15, $f15, $f7		#casos donde son negativos
j veri				#se restan con 0 para quitar negatividad
#---------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------
paso2:
add.s $f24, $f21, $f24
l.s $f0 ZERO
l.s $f30, ZERO
add.s $f0, $f20, $f0
l.s $f1, TWO 
#--PASO DE LA DIVISION-----------------------------------------------------------------
#$f15 indica si el resutado es negativo o positivo

#--PASO DE LA DIVISION------------------------------------------------------------------
primerm:
l.s $f2, ACUM			#SUMA FINAL
l.s $f3, ACUM			#RESULTADO MULTI 1
l.s $f6, ACUM			#RESULTADO DIVI 1
l.s $f7, ONE
l.s $f8, ZERO
l.s $f9, DEC
l.s $f5, TEN
l.s $f10, ACUM
l.s $f11, ACUM
l.s $f12, ACUM				#inicial con el valor de A y B
add.s $f30, $f30, $f7
whilem:
c.lt.s $f0, $f1			#CASO CUANDO F0 SEA MENOR QUE F2 Y CUANDO ES ASI SALTA A FINAL
bc1f operacionm			#es decir, a f0 se le ira restando f1, hasta quedar con el resto
#cuando sea $f0 sea 0
c.eq.s $f8, $f0			#caso cunado el resto sea 0, ej: 4/2 o 10/2
bc1t endm1

j whilem2			#salta a while2 si quedan resto

operacionm:
sub.s $f0, $f0, $f1		#operacion de esta para obtener el resto
add.s $f6, $f6, $f7		#suma para saber cuantas veces cae el f1 en el f0
j whilem
#---------------------------------------------------------------------------------------
PasoDecimalm:			#paso que sera utilizado cuando estemos con el 0.01	
l.s $f5, TEN
l.s $f9, DEC2			#se restablecen algunas variantes con el fin
l.s $f0, ZERO			#de volver a tenerlas en su estado inical para
add.s $f0, $f0, $f3		#tranjarlas con el 0.001
l.s $f3, ZERO
add.s $f11, $f11, $f7
#--PASO DE LA MULTIPLICACION---------------------------------------------------------
whilem2:
c.le.s $f5, $f8			#practicamente multiplica al resto x 10
bc1f operacionm2			#con el fin que este sea divido para sacar
				#el primer decimal
j whilem3			#salta a while 3 para dividir este numero 

operacionm2:
add.s $f3, $f3, $f0		
sub.s $f5, $f5, $f7
j whilem2
#-----DIVIDE AL DECIMAL-----------------------------------------------------------------
PARTEm2:
whilem3:				#aqui se divide al numero multiplicado x10
c.lt.s $f3, $f1			#CASO CUANDO F0 SEA MENOR QUE F2 Y CUANDO ES ASI SALTA A FINAL
bc1f operacionm3
#cuando sea $f0 sea 0
c.eq.s $f8, $f0
bc1t endm

j PARTEm3			#si queda resto pasa a la parte 3, sino termina el proceso

operacionm3:
sub.s $f3, $f3, $f1
add.s $f10, $f10, $f7
j whilem3
#---------------------------------------------------------------------------------------
PARTEm3:
whilem4:
c.le.s $f10, $f8		#multiplica el resto que queda x0.1
bc1f operacionm4			#si hay 2 decimales volvera a este paso pero
				#con 0.01
j casualm

operacionm4:
add.s $f12, $f9, $f12
sub.s $f10, $f10, $f7
j whilem4
#---------------------------------------------------------------------------------------
casualm:
add.s $f2, $f6, $f12
c.eq.s $f3, $f8			#f3 osea el resto == 0 termina el programa
bc1t endm

c.eq.s $f11, $f7		#aqui comprueba si necesita un segundo decimal
bc1t endm			#sino lo necesita temrina el programa
j PasoDecimalm			#y si lo necesita sube y cambia variables para poder 
				#lograrse (se explica en el "PasoDecimal")

endm1:
add.s $f2, $f6, $f12		#suma los valores, osea la parte entera y decimal
c.eq.s $f15, $f7		#si es que se acaba el programa
bc1f endfinalm
add.s $f2, $f2, $f10		#agrega la negatividad si es que la debe poseer
sub.s $f2, $f8, $f2
j endfinalm

endm:
c.eq.s $f15, $f7		
bc1f endfinalm
add.s $f2, $f2, $f10		#agrega la negatividad si es que la debe poseer
sub.s $f2, $f8, $f2
endfinalm:
c.eq.s $f30, $f7
bc1f to2
l.s $f20, ZERO			#en esta lista se guardan los elevados al numero ingresado
add.s $f20, $f20, $f2		#se divide el numero elevado a 2

l.s $f0, ZERO
add.s $f0, $f0, $f21
l.s $f1 TRHEE
to2:
c.eq.s $f30, $f31		#se divide el numero elevado a 3
bc1f to3
l.s $f21, ZERO
add.s $f21, $f21, $f2

l.s $f0, ZERO
add.s $f0, $f0, $f22
l.s $f1, FOUR
to3:
c.eq.s $f30, $f29		#se divide el numero elevado a 4
bc1f primerm
l.s $f22, ZERO
add.s $f22, $f22, $f2

finish:
l.s $f2, ZERO			#se opera para obtner el resultado final en f2
sub.s $f2, $f19, $f20
add.s $f2, $f2, $f21
sub.s $f2, $f2, $f22

li $v0, 4			#syscall para imprimir string
la $a0, ps			#pm sera la frase a imprimir en la consola
syscall

li $v0, 2			#syscall para imprimir entero
mov.s $f12, $f2			#mueve t2 (osea el mayor) a a0 para ser imprimido
syscall
#---------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------
li $v0, 10			#termino del programa
syscall
