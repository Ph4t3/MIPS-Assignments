    .data
msg1: .asciiz "Enter the range: "
msg2: .asciiz "The sequence is:"
newline: .asciiz "\n"
space: .asciiz " "

    .text
    .globl main
main: 
    li $v0, 4
    la $a0, msg1
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addi $s1, $zero, 1
    add $s2, $zero, $zero
    add $s3, $zero, $zero
    
loop:
    add $s3, $s2, $s1
    add $s1, $s2, $zero
    add $s2, $s3, $zero

    slt $t1, $s3, $t0
    beq $t1, $zero, exitout
    
    li $v0, 1
    move $a0, $s3
    syscall

    li $v0, 4
    la $a0, space
    syscall

    j loop
    
exitout:
    li $v0, 10
    syscall