	.data
A: .float 14.0
B: .float 4.0
TEN: .float 10.0	
ZERO: .float 0.0
ACUM: .float 0.0
ONE: .float 1.0
DEC: .float 0.1
DEC2: .float 0.01			
	.text
#resultado final en $f2
# numero A / numero B
l.s $f0, A			#int numero 1
l.s $f1, B			#int numero 2
l.s $f2, ACUM			#SUMA FINAL
l.s $f3, ACUM			#RESULTADO MULTI 1
l.s $f6, ACUM			#RESULTADO DIVI 1
l.s $f7, ONE
l.s $f8, ZERO
l.s $f9, DEC
l.s $f5, TEN
l.s $f10, ACUM
l.s $f11, ACUM
l.s $f12, ACUM
#$f15 indica si el resutado es negativo o positivo
#---CASO EN DONDE UNO O LOS 2 NUMEROS SON NEGATIVOS------------------------------------
vericero:
c.eq.s $f8, $f0
bc1t end				#caso donde la multiplicacion debe dar 0
vericero2:
c.eq.s $f8, $f1
bc1t end
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
veri:
c.lt.s $f8, $f0
bc1f veri2
c.lt.s $f8, $f1			#verifica que el numero sea mayor o menor que cero
bc1f veri3
j primer
#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
veri2:
sub.s $f0, $f8, $f0
add.s $f15, $f15, $f7
j veri
veri3:				#si es menor que cero lo resta con cero para obtener un positivo
sub.s $f1, $f8, $f1		#al final se le volvera a cambiar el signo para obtner el resultado correcto
add.s $f15, $f15, $f7
j primer
#--PASO DE LA DIVISION------------------------------------------------------------------
primer:				#inicial con el valor de A y B
while:
c.lt.s $f0, $f1			#CASO CUANDO F0 SEA MENOR QUE F2 Y CUANDO ES ASI SALTA A FINAL
bc1f operacion			#es decir, a f0 se le ira restando f1, hasta quedar con el resto
#cuando sea $f0 sea 0
c.eq.s $f8, $f0			#caso cunado el resto sea 0, ej: 4/2 o 10/2
bc1t end1

j while2			#salta a while2 si quedan resto

operacion:
sub.s $f0, $f0, $f1		#operacion de esta para obtener el resto
add.s $f6, $f6, $f7		#suma para saber cuantas veces cae el f1 en el f0
j while
#---------------------------------------------------------------------------------------
PasoDecimal:			#paso que sera utilizado cuando estemos con el 0.01	
l.s $f5, TEN
l.s $f9, DEC2			#se restablecen algunas variantes con el fin
l.s $f0, ZERO			#de volver a tenerlas en su estado inical para
add.s $f0, $f0, $f3		#tranjarlas con el 0.001
l.s $f3, ZERO
add.s $f11, $f11, $f7
#--PASO DE LA MULTIPLICACION---------------------------------------------------------
while2:
c.le.s $f5, $f8			#practicamente multiplica al resto x 10
bc1f operacion2			#con el fin que este sea divido para sacar
				#el primer decimal
j while3			#salta a while 3 para dividir este numero 

operacion2:
add.s $f3, $f3, $f0		
sub.s $f5, $f5, $f7
j while2
#-----DIVIDE AL DECIMAL-----------------------------------------------------------------
PARTE2:
while3:				#aqui se divide al numero multiplicado x10
c.lt.s $f3, $f1			#CASO CUANDO F0 SEA MENOR QUE F2 Y CUANDO ES ASI SALTA A FINAL
bc1f operacion3
#cuando sea $f0 sea 0
c.eq.s $f8, $f0
bc1t end

j PARTE3			#si queda resto pasa a la parte 3, sino termina el proceso

operacion3:
sub.s $f3, $f3, $f1
add.s $f10, $f10, $f7
j while3
#---------------------------------------------------------------------------------------
PARTE3:
while4:
c.le.s $f10, $f8		#multiplica el resto que queda x0.1
bc1f operacion4			#si hay 2 decimales volvera a este paso pero
				#con 0.01
j casual

operacion4:
add.s $f12, $f9, $f12
sub.s $f10, $f10, $f7
j while4
#---------------------------------------------------------------------------------------
casual:
add.s $f2, $f6, $f12
c.eq.s $f3, $f8			#f3 osea el resto == 0 termina el programa
bc1t end

c.eq.s $f11, $f7		#aqui comprueba si necesita un segundo decimal
bc1t end			#sino lo necesita temrina el programa
j PasoDecimal			#y si lo necesita sube y cambia variables para poder 
				#lograrse (se explica en el "PasoDecimal")

end1:
add.s $f2, $f6, $f12		#suma los valores, osea la parte entera y decimal
c.eq.s $f15, $f7		#si es que se acaba el programa
bc1f endfinal
add.s $f2, $f2, $f10		#agrega la negatividad si es que la debe poseer
sub.s $f2, $f8, $f2
j endfinal

end:
c.eq.s $f15, $f7		
bc1f endfinal
add.s $f2, $f2, $f10		#agrega la negatividad si es que la debe poseer
sub.s $f2, $f8, $f2
endfinal:
li $v0, 10			#termino del programa
syscall
