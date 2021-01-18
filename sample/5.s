# find first index of substring in a string
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
	la $a0, msg2	#msg to enter sub-string
	syscall

	li $v0, 8	#read string2
	la $a0, substr
	li $a1, 100
	syscall
	
	la $s0, str
	la $s1, substr
	addi $s2, $zero, -1
	addi $t9, $zero, 10	#to check for newline
loop:
	lb $t0,	($s0)
	lb $t1, ($s1)
	beq $t0, $zero, exitloop	#exit if zero
	beq $t1, $zero, exitloop
	beq $t0, $t9, exitloop	#exit if newline
	beq $t1, $t9, exitloop	#exit if newline
	
	beq $t0, $t1, incrementboth
	
	la $s1, substr
	addi $s0, $s0, 1
	j loop
incrementboth:
	addi $s0, $s0, 1
	addi $s1, $s1, 1
	j loop
exitloop:
	la $t3, substr
	sub $t3, $s1, $t3	#find length of substring
	beq $t3, $zero, notpresent #if 0 substring is not present

	la $t2, str
	sub $t2, $s0, $t2	#find current index of string
	sub $t3, $t2, $t3	#find index
	j present
	
notpresent:
	addi $t3, $zero, -1
present:
	li $v0, 1	#print output
	move $a0, $t3
	syscall

	li $v0, 4	#print newline
	la $a0, newline
	syscall
exit:
	li $v0, 10
	syscall

	.data
msg1: .asciiz "string : "
msg2: .asciiz "sub-string : "
str: .space 100
substr: .space 100
newline: .asciiz "\n"
