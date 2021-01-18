	.data
msg1: .asciiz "Enter the number: "
space: .asciiz " "
msg2: .asciiz "Narcissistic Number."
msg3: .asciiz "Not Narcissistic Number."

	.text
	.globl main
main:
	li $v0, 4
	la $a0, msg1
	syscall

	li $v0, 5
	syscall
	move $s0, $v0

	#call count digits on s0
	move $a0, $s0
	jal countdigits
	move $s2, $a0
	# initialize sum as 0
	move $s1, $zero
	# iterator for loop
	move $s3, $s0
	addi $t3, $zero, 10
loop:
	beq $s3, $zero, exitloop
	div $s3, $t3
	mflo $s3
	mfhi $a0
	move $a1, $s2
	jal pow
	add $s1, $s1, $a0
	j loop
exitloop:
	beq $s1, $s0, narcissistic
	li $v0, 4
	la $a0, msg3
	syscall
	j exit
narcissistic:
	li $v0, 4
	la $a0, msg2
	syscall
exit:
	li $v0, 10
	syscall

pow:
	addi $t0, $zero, 1
powloop:
	beq $a1, $zero, exitpow
	
	mult $t0, $a0
	mflo $t0

	addi $a1, $a1, -1 
	j powloop
exitpow:
	move $a0, $t0
	jr $ra

countdigits:
	move $t0, $zero
	addi $t1, $zero, 10
countloop:
	beq $a0, $zero, exitcount
	div $a0, $t1
	mflo $a0
	addi $t0, $t0, 1
	j countloop
exitcount:
	move $a0, $t0
	jr $ra