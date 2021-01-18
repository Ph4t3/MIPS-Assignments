# compare 2 strings, strcmp
	.text
	.globl main
main:
	li $v0, 4
	la $a0, msg1	#msg to enter string
	syscall

	li $v0, 8	#read string
	la $a0, str
	li $a1, 100
	syscall

	li $v0, 4
	la $a0, msg2	#msg to enter string 2
	syscall

	li $v0, 8	#read string2
	la $a0, str2
	li $a1, 100
	syscall
	
	la $s0, str
	la $s1, str2
	move $s2, $zero
	addi $t9, $zero, 10	#to check for newline
loop:
	lb $t0, ($s0)
	lb $t1, ($s1)
	beq $t0, $zero, exitloop	#exit if zero
	beq $t1, $zero, exitloop
	beq $t0, $t9, exitloop	#exit if newline
	beq $t1, $t9, exitloop	#exit if newline
	
	sub $s2, $t0, $t1
	bne $s2, $zero, exitloop

	addi $s0, $s0, 1
	addi $s1, $s1, 1
	j loop
exitloop:
	li $v0, 1	#print output
	move $a0, $s2
	syscall

	li $v0, 4	#print newline
	la $a0, newline
	syscall
exit:
	li $v0, 10
	syscall

	.data
msg1: .asciiz "1 string : "
msg2: .asciiz "2 string : "
str: .space 100
str2: .space 100
newline: .asciiz "\n"
