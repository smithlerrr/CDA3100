##Author: Drew Smith
##Course: CDA3100
##Instructor: Hughes
##Date: April 23, 2015
##Final Exam - Polish Sequence
##
##Program Details: The program asks the user to enter an integer
##(zero or negative) to exit. The program then takes the individual digits  
## of the number entered, squares them, and then adds the individual digits
## together to produce a new number. The program repeats this process until
## 16 digits have been printed, assuming zero was not entered. This procedure
## is known as a polish sequence.
###############################################################################
terms:
        addi $sp, $sp, -16 # create space for stack pointer
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp)
        sw $s2, 12($sp)

        move $t0, $a0 

        la $a0, first16
        li $v0, 4 # prints "First 16 terms"
        syscall

        move $a0, $t0 
        li $v0, 1 # print the user input
        syscall

        la $a0, space
        li $v0, 4 # prints a space / " "
        syscall

        li $t1, 0 # t1 = 0 
        li $t2, 15 # no more than 16 results printed
        move $a0, $t0 # move input back into $a0

terms_loop:     
        beq  $t1, $t2, stack # if 16 terms has been reached, branch
        jal polish 

        move $a0, $t0
        li $v0, 1 # print result
        syscall

        la $a0, space
        li $v0, 4 # prints a space / " " 
        syscall

        addi $t1, $t1, 1 #increase loop term
        move $a0, $t0
        j terms_loop

polish:
        addi $sp, $sp, -16 # create space for stack pointer
        sw $ra, 0($sp)
        sw $s0, 4($sp)
        sw $s1, 8($sp) 
        sw $s2, 12($sp)

        li $t3, 0 # $t3 will hold result when returned to stack

polish_loop:
        move $t0, $t3 # move result into $t0
        ble $a0, $zero, stack #if a0 <= 0, branch
        move $t4, $a0

        li $t5, 10
        div $a0, $t4, $t5 #isolate single digit
        rem $t5, $t4, $t5 #get remainder
        mul $t5, $t5, $t5 #square the digit
        add $t3, $t3, $t5 #add results into t3
        j polish_loop #repeat

stack: 
        lw $ra, 0($sp) # restore stack
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $s2, 12($sp)
        
        addi $sp, $sp, 16
        jr $ra

main:   la $a0, intro # prints "Welcome to the Polish sequence tester!"
        li $v0, 4
        syscall

loop:   la $a0, req # prints "Enter an integer"
        li $v0, 4
        syscall

        li $v0, 5 # Read in user input
        syscall

        ble $v0, $zero, out # if n is not positive, exit

        move $a0, $v0 # set parameter for terms procedure

        jal terms # call terms procedure
        j loop # branch back for next value of n

out:    la $a0, adios # display closing
        li $v0, 4
        syscall

        li $v0, 10 # exit from the program
        syscall

        .data
intro:  .asciiz  "Welcome to the Polish sequence tester!"
req:    .asciiz  "\nEnter an integer (zero or negative to exit): "
adios:  .asciiz  "Come back soon!\n"
first16:.asciiz  "First 16 terms: "
space:  .asciiz  " "

