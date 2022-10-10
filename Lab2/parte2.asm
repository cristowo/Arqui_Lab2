	.data
pr: .asciiz "el maximo comun divisor es:  "
	.text
#---------------------------------------------------------------------------------------
li $t5, 0
li $t6, 81 			#int a = NUMERO 1
li $t7, -153 			#int b = NUMERO 2
#---------------------------------------------------------------------------------------
veri:
bgt $t5, $t6, veri1
bgt $t5, $t7, veri2
while:				#Ciclo while ("Ciclo mientras pa los habla hispana")
bne $t6, $t7, A			#si ($t6 != $t7) ir a A
#---------------------------------------------------------------------------------------
				#cuando se rompe el ciclo avanzara a imprimir el MCD y Finalizar el programa
result: 
li $v0, 4			#syscall para imprimir string
la $a0, pr			#pr sera la frase a imprimir en la consola
syscall

li $v0, 1			#syscall para imprimir entero
move $a0, $t6			#mueve t6 (osea el MCD) a a0 para ser imprimido
syscall
#---------------------------------------------------------------------------------------
END:				#sino no lo es termina el programa
li $v0, 10
syscall
#---------------------------------------------------------------------------------------
A:
bge $t6, $t7, B			#Si $t6 >= $t7 ir a B

				#Sino
sub $t7, $t7, $t6		#t7= t7-t6
j while				#vuelve a evaluar en el while

B:				
sub $t6, $t6, $t7		#t6= t6-t7
j while				#vuelve a evaluar en el while
#---------------------------------------------------------------------------------------
veri1:
sub $t6, $t5, $t6
j veri
veri2:
sub $t7, $t5, $t7
j while