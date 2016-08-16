##
##
## Author: Smith
## ID: dbs13
## Last Modified: 2/17/2015
##
## Description: This program multiplies two matrices and returns a new matrix.
##
######################################################
######################################################



      .text
      .globl main



#main
#
#########################################
main:
      la $a0, intro             #prints intro statement
      li $v0, 4
      syscall

      jal getMatrixSize         #jumps and links to function getMatrixSize

      move $s0, $t0             #moves MatrixA row into $s0
      move $s1, $t1             #moves MatrixA coloumn into $s1
      mul $t0, $t0, $t1         #multiply MatA rows by MatA col into $t0
      sh $t0, matASize          #stores size of MatrixA

      jal getMatrixSize         #jump and link to getMatrixSize

      move $s2, $t0             #moves MatrixB row into $s2
      move $s3, $t1             #moves MatrixB col into $s3
      mul $t0, $t0, $t1
      sh $t0, matBSize          #stores size of MatrixB

      jal testMatrices          #jump and link to testMatrices

      add $t2, $zero $s0        #t2 = matrixA row
      add $t3, $zero $s1        #t3= matrixA col

      la $t7, matrixA           #loads address of MatA into $t7

      jal getMatrixVals

      add $t2, $zero $s2
      add $t3, $zero, $s3

      la $t7, matrixB

      jal getMatrixVals

      j matrixMult



# getMatrixSize
#
# Description: This function prompts the
# user to enter the matrix size.
#
# register use:
#   a0: address of matrix size variable
#########################################
getMatrixSize:
      la $a0, rowReq    #get row
      li $v0, 4         #prints string
      syscall

      li $v0, 5         #reads int
      syscall

      move $t0, $v0
                         #store row1 into t0
      la $a0, colReq    #get colomun
      li $v0, 4         #prints string
      syscall

      li $v0, 5         #reads int
      syscall

      move $t1, $v0     #store col1 into s1

      jr $ra


# testMatrices
#
# Description: This function tests the input
# matricies
#
# register use:
#   v0: T/F sizes are good
#########################################
testMatrices:
       bne $s1, $s2, false
       jr $ra

false:
       la $a0, fail
       li $v0, 4
       syscall

       j main

# getMatrixVals
#
# Description: This function gets the matrix
# conents from the user.
#
# register use:
#   a0: address of matrix
#   a1: size of matrix x,y
#########################################
getMatrixVals:
      la $a0, rowEnt            #gets value inputs of matrix of both matrixes
      li $v0, 4                 #stores in
      syscall

      add $t0, $zero, $zero
      add $t1, $zero, $zero

loop:

      move $a0, $t0
      li $v0, 1
      syscall

      la $a0, comma
      li $v0, 4
      syscall

      la $a0, space
      li $v0, 4
      syscall

      move $a0, $t1
      li $v0, 1
      syscall

      la $a0, colon
      li $v0, 4
      syscall

      li $v0, 5
      syscall

      sh $v0, 0($t7)
      addi $t7, $t7, 4

      addi $t1, $t1, 1
      beq $t1, $t3, addRow      #if coloummn = max, jump to addRow

      j loop

addRow:
      addi $t0, $t0, 1          #adds row, sets colomun back to zero
      move $t1, $zero           #if row = max, return back to main
      bne $t0, $t2, loop        #else, back to loop to get next row

      jr $ra






# matrixMult
#
# Description: This function multiplies
# the two input matrices and places the
# result in matrixC.
#
# register use:
#########################################
matrixMult:
      la $s5, matrixA       #holds element array address
      move $t0, $zero   #i counter
      move $t1, $zero   #j counter
      move $t2, $s1     #max A coloumns

      la $s6, matrixB       #holds array address
      move $t4, $zero   #i counter (B)
      move $t5, $zero   #j counter (B)
      move $t6, $s3     #max B coloumns

      add $t9, $zero, $zero #initilize holder variable



matrixMult2:

      mult $t2, $t0         # matA (n*i)
      mflo $t3
      add $t3, $t3, $t1     # matA (n*i+j)
      sll $t3, $t3, 2       # matA (4(n*i+j))

      add $s5, $t3, $s5
      lw $t3, ($s5)
      add $s5, $zero, $zero
      la $s5, matrixA       #holds element array address

      mult $t6, $t4         # matB (n*i)
      mflo $t7
      add $t7, $t7, $t5     # matB (n*i+j)
      sll $t7, $t7, 2       # matB (4(n*i+j))

      add $s6, $t7, $s6
      lw $t7, ($s6)
      add $s6, $zero, $zero
      la $s6, matrixB       #holds array address


      mult $t3, $t7         #A x B
      mflo $t8
      add $t9, $t9, $t8

      add $t8, $zero, $zero


      addi $t1, $t1, 1      #if not, increment coloumn mat.A, row mat.B
      addi $t4, $t4, 1
      beq $t1, $t2, reset   #if j=max coloumn, jump to reset


      j matrixMult2

reset:
      jal printResult
      move $t1, $zero       #reset j in matrix A
      move $t4, $zero       #reset i in matrix B
      addi $t5, $t5, 1      #get the next coloumn in matrix B

      beq $t5, $t6, rowInc  #if the coloumn in matrix B = max coloumn in B, jump

      j matrixMult2

rowInc:
      addi $t0, $t0, 1      #increment the row in matrix A
      beq $t0, $s0, main    #if the row = max row in A, then return to main, finished.
      move $t5, $zero       #else, reset the j coloumn count in matrix B and loop through again

      j matrixMult2



#printResult
#
# Description: This function prints the
#   contents of the result matrix.
#########################################
printResult:

      move $a0, $t9
      li $v0, 1
      syscall


      la $a0, space
      li $v0, 4
      syscall

      addi $s7, $s7, 1
      beq $s7, $s3, newline

return:
      add $t9, $zero, $zero

      jr $ra

newline:
      la $a0, cr
      li $v0, 4
      syscall

      add $s7, $zero, $zero

      j return




      .data
matASize: .space  8
matrixA:  .space 40
          .space 40

matBSize: .space  8
matrixB:  .space 40
          .space 40

matrixC:  .space 40
          .space 40

cr:       .asciiz  "\n"
colon:    .asciiz  ": "
comma:    .asciiz  ","
space:    .asciiz  " "
intro:    .asciiz  "Welcome to the matrix multiplier!\n"
rowReq:   .asciiz  "\nEnter the number of rows for the matrix: "
colReq:   .asciiz  "Enter the number of columns for the matrix: "
fail:     .asciiz  "The sizes that you entered are invalid. Enter an nxm and a mxq matrix.\n"
rowEnt:   .asciiz  "Enter the value for element\n"
