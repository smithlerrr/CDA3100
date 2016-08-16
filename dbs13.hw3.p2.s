##
##
## Author: Smith
## ID: dbs13
## Last Modified: 2/17/2015
##
## Description: This program returns the factorial of an integer
##
######################################################
######################################################

.globl main
.data
  nval: .asciiz "\nEnter a value for n (or a negative value to exit): "
  ans:  .asciiz "! is "
  open: .asciiz "Welcome to the factorial tester!"
  close: .asciiz "\nThanks for using the program!"

.text
main:
  la $a0, open
	li $v0, 4
	syscall
again:
    la 	$a0, nval # print "n = "
    li 	$v0, 4 	#
	syscall

	li $v0, 5 	# read integer
	syscall

    move $a0, $v0 	# $a0 = $v0

    slti $t1, $a0, 0
    bne $t1, $zero, exit

    
    li $v0, 1
    syscall

    jal fact

	move $s0, $v0

    add $s0, $s0, $zero


    la $a0, ans
    li $v0, 4
    syscall

    move $a0, $s0

    li $v0, 1
    syscall

    j again


fact:
   slti  $t0, $a0, 1	# test for n < 1
   beq   $t0, $zero, L1	# if n >= 1, go to L1

   li    $v0, 1		# return 1
   jr    $ra		# return to instruction after jal


L1:
   addi  $sp, $sp, -8	# adjust stack for 2 items
   sw    $ra, 4($sp)	# save the return address
   sw    $a0, 0($sp)	# save the argument n

   addi  $a0, $a0, -1	# n >= 1; argument gets (n – 1)
   jal   fact		# call fact with (n – 1)

   lw    $a0, 0($sp)	# return from jal: restore argument n
   lw    $ra, 4($sp)	# restore the return address
   addi  $sp, $sp, 8	# adjust stack pointer to pop 2 items

   mul   $v0, $a0, $v0	# return n * fact (n – 1)
   jr    $ra		# return to the caller

exit:
    la $a0, close
	li $v0, 4
	syscall

    li $v0, 10
    syscall










