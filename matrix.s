.data
intro:    .asciiz "\nWelcome to the matrix multiplier! "
rowReq:       .asciiz "\nEnter the number of rows for the matrix: "
colReq:    .asciiz "\nEnter the number of columns for the matrix:"
fail:     .asciiz  "The sizes that you entered are invalid. Enter an nxm and a mxq matrix.\n"
rowEnt:   .asciiz  "Enter the value for element\n"
cr:       .asciiz  "\n"
colon:    .asciiz  ": "
comma:    .asciiz  ","
space:    .asciiz  " "
.text
getMatrixSize:
      la $a0, rowReq    #get row
      li $v0, 4         #prints string
      syscall

      li $v0, 5         #reads int
      syscall

      move $s0, $v0     #store row1 into s0

      la $a0, colReq    #get colomun
      li $v0, 4         #prints string
      syscall

      li $v0, 5         #reads int
      syscall

      move $s1, $v0     #store col1 into s1

      la $a0, rowReq    #get row2
      li $v0, 4         #prints string
      syscall

      li $v0, 5         #reads int
      syscall

      move $s2, $v0

      la $a0, colReq    #get colomun 2
      li $v0, 4         #prints string
      syscall

      li $v0, 5         #reads int
      syscall

      move $s3, $v0

      j testMatrices
main:
jra getMatrixSize
jra

multing:
bgt $t0,$s0,jump     #t0=i , $s0=dimention
lw $t1,0($a1)        #a1=address of first array , t1=matrix[i]
mul $t2,$t1,$t0      #t2=t1*t0
sw $t2,0($a2)        #store the element
addi $t0,$t0,1       #i=i+1
addi $a1,$a1,4       #next address in first array
addi $a2,$a2,4       #next address in second array
b multing            #repeat loop

jump:

move $t0 $zero
la $a1 array2
li $t1 4

printLoop:
    lw $a0 0($a1)
    li $v0 1
    syscall

    li $a0 ' '
    li $v0 11
    syscall

    addi $a1 4
    addi $t0 1

    blt $t0 $t1 printLoop

jr $ra