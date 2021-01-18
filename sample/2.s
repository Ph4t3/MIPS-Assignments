# Print prime numbers between 2 numbers
    .text
    .globl main
main:
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $s0, $v0

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 5
    syscall
    move $s1, $v0

    li $v0, 4
    la $a0, msg3
    syscall

loop:
    slt $t0, $s1, $s0
    bne $t0, $zero, exit

    move $a0, $s0
    jal checkprime
    beq $a1, $zero, noprint

printno:
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, space
    syscall

noprint:
    addi $s0, $s0, 1
    j loop

##Exit out of the program
exit:
    li $v0, 10
    syscall

checkprime:
    addi $t0, $zero, 2
loopprime:
    #for i=2; i<a/i; i++
    div $a0, $t0
    #remainder to a1, quotient to t1
    mflo $t1
    mfhi $a1
    slt $t2, $t0, $t1
    beq $t2, $zero, exitprime
    
    #check if a/i remainder is 0, if yes it is not prime
    beq $a1, $zero, exitprime

    addi $t0, $t0, 1
    j loopprime
exitprime:
    move $a0, $t2
    jr $ra

    .data
msg1: .asciiz "a :"
msg2: .asciiz "b :"
msg3: .asciiz "\n"
space: .asciiz " "