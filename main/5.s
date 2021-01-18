	.data
msg1: .asciiz "Enter the string : "
msg2: .asciiz "Enter the sub-string : "
msg3: .asciiz "Index is  "
str: .space 100
substr: .space 100
newline: .asciiz "\n"

	.text
	.globl main
main:
	li $v0, 4
	la $a0, msg1
	syscall

	li $v0, 8
	la $a0, str
	li $a1, 100
	syscall

	li $v0, 4
	la $a0, msg2
	syscall

	li $v0, 8
	la $a0, substr
	li $a1, 100
	syscall
	
	la $s0, str
	la $s1, substr
	addi $s2, $zero, -1
	addi $t9, $zero, 10
loop:
	lb $t0,	($s0)
	lb $t1, ($s1)
	beq $t0, $zero, exitloop
	beq $t1, $zero, exitloop
	beq $t0, $t9, exitloop
	beq $t1, $t9, exitloop
	
	beq $t0, $t1, incrementboth
	
	la $s1, substr
	addi $s0, $s0, 1
	j loop
incrementboth:
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	j loop
exitloop:
	li $v0, 4
	la $a0, msg3
	syscall

	la $t3, substr
	sub $t3, $s1, $t3
	beq $t3, $zero, notpresent

	la $t2, str
	sub $t2, $s0, $t2
	sub $t3, $t2, $t3
	j present
	
notpresent:
	addi $t3, $zero, -1
present:
	li $v0, 1
	move $a0, $t3
	syscall

	li $v0, 4
	la $a0, newline
	syscall
exit:
	li $v0, 10
	syscall