##
##
## Author: Smith
## ID: dbs13
## Last Modified: 2/17/2015
##
## Description: This program swaps the bits of an integer inputed
## in by a user in reverse order
##
######################################################
######################################################

.globl main
.data
welcome:    .asciiz "Welcome to the amazing bit swapper!"
enter:      .asciiz "\nEnter a number in the range 0-225: "
result:     .asciiz "\nFlippy- Do: "

.text
main:
    la $a0, welcome
    li $v0, 4
    syscall

    la $a0, enter
    li $v0, 4 #displays
    syscall

    li $v0, 5 #reads in
    syscall

    move $t0, $v0

    jal swap

swap:

    li $t4,7
    li $t1,0x01
    and $t2,$t0,$t1

loop:
    beq $t4,$zero,done
    srl $t0,$t0,1
    sll $t2,$t2,1
    and $t3,$t0,$t1
    or $t2,$t2,$t3
    addi $t4,$t4,-1
    j loop

done:
    move $v1,$t2
    move  $a0, $v1
    la $a0, result
    li $v0, 4
    syscall

    li    $v0, 1
    syscall

    li    $a0, 10
    syscall








