	.data						
A: .float 6.0
B: .float 5.0
ONE: .float 1.0
ZERO: .float 0.0
ACUM: .float 0.0	
	.text

l.s $f0, A
l.s $f1, B
l.s $f6, ACUM
l.s $f7, ONE
l.s $f8, ZERO
#--VERIFICACION-----------------------------------------------------------------
veri:
c.eq.s $f8, $f0
bc1t end
c.eq.s $f8, $f1			#verifica si son 0 o si son negativos
bc1t end			#simplemente es un paso de verificacion 
c.lt.s $f8, $f0			#para que se trabaje mejor
bc1f veri2			#en el problema 3.B tambien esta presente
c.lt.s $f8, $f1
bc1f veri3
#---------------------------------------------------------------------------------------
while:
c.le.s $f1, $f8			#while principal
bc1f operacion			#ira comprobando hasta que f1 llegue a 0
#-------------------------------------------------------------------------------------
c.eq.s $f15, $f7
bc1f end			#agrega negatividad si es que la poseen
sub.s $f2, $f8, $f2
#---------------------------------------------------------------------------------------
end:
li $v0, 10			#termino del programa
syscall
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
veri3:				#y se guarda un 1 para saber si el resultado final
sub.s $f1, $f8, $f1		#necesita ser negativo, si tiene 0 o 2, no necesita serlo
add.s $f15, $f15, $f7
j while
#---------------------------------------------------------------------------------------

