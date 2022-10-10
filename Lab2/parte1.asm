	.data
p1: .asciiz "Por favor ingrese el primer entero: "
p2: .asciiz "Por favor ingrese el segundo entero: "
pm: .asciiz "El numero maximo es: "
	.text
#---------------------------------------------------------------------------------------
li $v0, 4			#syscall para imprimir un string
la $a0, p1			#pl sera la frase a imprimir en la consola
syscall

li $v0, 5			#syscall para leer un entero
syscall

move $t0, $v0			#mueve el numero de v0 a t0
#---------------------------------------------------------------------------------------
li $v0, 4			#syscall para imprimir string
la $a0, p2			#pl sera la frase a imprimir en la consola
syscall

li $v0, 5			#syscall para leer un entero
syscall

move $t1, $v0			#mueve el numero de v0 a t0
#---------------------------------------------------------------------------------------
bge  $t0, $t1, num1max		#condicional si t0 >= t1 ir a "num1max"

move $t2, $t1			#mueve t1 a t2 
j result			#salta a donde se imprimira el resultado

num1max:
move $t2, $t0			#mueve t0 a t2

result: 
li $v0, 4			#syscall para imprimir string
la $a0, pm			#pm sera la frase a imprimir en la consola
syscall

li $v0, 1			#syscall para imprimir entero
move $a0, $t2			#mueve t2 (osea el mayor) a a0 para ser imprimido
syscall
#---------------------------------------------------------------------------------------
end:
li $v0, 10			#termino del programa
syscall
