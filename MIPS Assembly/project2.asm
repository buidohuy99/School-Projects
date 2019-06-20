.data
	TIME_1: .space 11
	TIME_2: .space 11
	SumDay: .word 0
	
	#FILE.TXT
	TIME_1_TXT: .space 11
	TIME_2_TXT: .space 11
	STR_INPUT: .space 22
	STR_OUTPUT: .space 1024
	xuongdong: .asciiz "\r\n"
	input: .asciiz "input.txt"
	output: .asciiz "output.txt"

	# Nhap Xuat
	strCinDay: .asciiz "Nhap ngay DAY: "
	strDayErr: .asciiz "Ngay da nhap co ki tu dac biet!\n"
	strCinMonth: .asciiz "Nhap thang MONTH: "
	strMonthErr: .asciiz "Thang da nhap co ki tu dac biet!\n"
	strCinYear: .asciiz "Nhap nam YEAR: "
	strYearErr: .asciiz "Nam da nhap co ki tu dac biet!\n"
	strXuat: .asciiz "Thoi gian vua nhap la: "
	STRSoNgay: .asciiz "\nSo ngay: "
	STRNhapLai: .asciiz "Nhap sai, moi nhap lai!\n"
	SoNgay: .word 31 28 31 30 31 30 31 31 30 31 30 31
	Cau2_ChonDinhDang:  .asciiz "Chon A, B hoac C\n"

	
	# daysOfWeek
	#------------Khi nao muon xuat cac ngay trong tuan se mo cmt cau duoi day-----------------
	daysOfWeek: .word t2, t3, t4, t5, t6 , t7, cn
	sun: .asciiz " la Chu nhat"
	mon: .asciiz " la Thu hai"
	tue: .asciiz " la Thu ba"
	wed: .asciiz " la Thu tu"
	thu: .asciiz " la Thu nam"
	fri: .asciiz " la Thu sau"
	sat: .asciiz " la Thu bay"
	SoNgayTichLuy: .word 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334
	SoNgayTichLuyNamNhuan: .word 0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335
	#Menu
	ThongBao: .asciiz "------- Ban hay chon 1 trong cac thao tao duoi day -------\n"
	Cau1: .asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
	Cau2: .asciiz "2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n        A. MM/DD/YYYY\n        B. Month DD, YYYY\n        C. DD Month, YYYY\n"
	Cau3: .asciiz "3. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
	Cau4: .asciiz "4. Cho biet ngay vua nhap la ngay thu may trong tuan\n"
	Cau5: .asciiz "5. Cho biet ngay nhap la ngay thu may ke tu ngay 1/1/1\n"
	Cau6: .asciiz "6. Cho biet can chi cua nam vua nhap\n"
	Cau7: .asciiz "7. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
	Cau8: .asciiz "8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time\n"
	Cau9: .asciiz "9. Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt\n"
	KTTB: .asciiz "----------------------------------------------------------------\n"
	LuaChon: .asciiz "Lua chon: "
	NhapSai: .asciiz "Nhap sai, moi nhap lai: "
	KetQua: .asciiz "Ket qua: \n"
	CONTINUE: .asciiz "\nChon (1) de tiep tuc, Chon (0) de thoat: "
	
	#THONG BAO XUAT
	TBCau3.1: .asciiz " La nam thuong"
	TBCau3.2: .asciiz " La nam nhuan"
	TBCau5.1: .asciiz "Khoang cach tu ngay 01/01/0001 den ngay  "
	TBCau5.2: .asciiz " la "
	TBCau5.3: .asciiz " ngay"

	TBCau6.1: .asciiz " la nam "

	TBCau7.2: .asciiz "Nhap ngay thu 2:\n"
	TBCau7.3: .asciiz "Khoang cach tu ngay "
	TBCau7.4: .asciiz " den ngay "
	
	TBCau8.1: .asciiz "Hai nam nhuan gan voi "
        TBCau8.2: .asciiz " nhat la "  
        TBCau8.3: .asciiz  " va "
	#Can
	Giap: .asciiz     "Giap "
	At:.asciiz     "At "
	Binh: .asciiz     "Binh "
	Dinh:      .asciiz     "Dinh "
	Mau:      .asciiz     "Mau "
	Ky:      .asciiz     "Ky "
	Canh:      .asciiz     "Canh "
	Tan:      .asciiz     "Tan "
	Nham:      .asciiz     "Nham "
	Quy:      .asciiz     "Quy "
	#12 Chi

	Suu: .asciiz "Suu"
	Dan: .asciiz "Dan"
	Mao: .asciiz "Mao"
	Thin: .asciiz "Thin"
	Ty: .asciiz "Ty"
	Ngo: .asciiz "Ngo"
	Mui: .asciiz "Mui"
	Than: .asciiz "Than"
	Dau: .asciiz "Dau"
	Tuat: .asciiz "Tuat"
	Hoi: .asciiz "Hoi"
	out: .space 10

	#FILE
	KHL1: .asciiz "Chuoi TIME_1 khong hop le\r\n"
	KHL2: .asciiz "Chuoi TIME_2 khong hop le\r\n"
	KHL12: .asciiz "Chuoi TIME_1 va TIME_2 khong hop le"
	Cau1F: .asciiz "1. "
	Cau2AF: .asciiz "2A. "
	Cau2BF: .asciiz "2B. "
	Cau2CF: .asciiz "2C. "
	Cau3F: .asciiz "3. "
	Cau4F: .asciiz "4. "
	Cau5F: .asciiz "5. "
	Cau6F: .asciiz "6. "
	Cau7F: .asciiz "7. "
	Cau8F: .asciiz "8. "
	SO: .space 12


.text
	#Goi MENU
	la $a0,TIME_1
	jal MENU

KETTHUC:
	#KetThuc
	li $v0,10
	syscall
#----------------------Menu----------------
MENU:
	#Khoi tao stack
	addi $sp,$sp,-20
	
	#Backup thanh ghi
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	
	#Nhan du lieu
	move $s0,$a0
	
	#Nhap ngay
	move $a0,$s0
	jal CinDATE

LOOPMENU:
	#Xuat bang MENU
	li $v0,4
	la $a0,ThongBao
	syscall
	
	
	la $a0,Cau1
	syscall

	la $a0,Cau2
	syscall
	
	la $a0,Cau3
	syscall

	la $a0,Cau4
	syscall

	la $a0,Cau5
	syscall

	la $a0,Cau6
	syscall

	la $a0,Cau7
	syscall

	la $a0,Cau8
	syscall

	la $a0,Cau9
	syscall

	la $a0,KTTB
	syscall
	
	la $a0,LuaChon
	syscall
BD:
	#Nhap lua chon
	li $v0,5
	syscall
	move $t0,$v0
	
	#Xuat ket qua
	li $v0,4
	la $a0,KetQua
	syscall
	
	bne $t0,$0,L1

L1:
	addi $t1,$t0,-1
	bne $t1,$0,L2
	la $a0,TIME_1
	jal CoutDATE
	j CON
L2:
	addi $t1,$t0,-2
	bne $t1,$0,L3

	la $a0, Cau2_ChonDinhDang
	li $v0, 4	
	syscall

	li $v0, 12	
	syscall
	move $s2, $v0	

	# Goi ham chuyen dinh dang
	la $a0,TIME_1	# a0: STRDATE
	move $a1,$s2	# a1: loai (A, B, C)
	jal Convert
	move $s2,$v0
	li $a0, '\n'	
	li $v0, 11	
	syscall	

	li $v0, 4	
	move $a0,$s2
	syscall
	
	j CON
L3:
	addi $t1,$t0,-3
	bne $t1,$0,L4
	
	la $a0,TIME_1
	jal GetYear
	
	move $a0,$v0
	li $v0,1
	syscall

	la $a0,TIME_1
	jal LeapYear

	beq $v0,$0,notNhuan
	li $v0,4
	la $a0,TBCau3.2
	syscall
	j CON
notNhuan:
	li $v0,4
	la $a0,TBCau3.1
	syscall
	j CON
L4:
	addi $t1,$t0,-4
	bne $t1,$0,L5
	#Goi ham + xuat blalala
	la $a0,TIME_1
	jal CoutDATE
	
	la $a0,TIME_1
	jal GetWeekDay
	beq $v0,$0,CON
	
	move $a0,$v0
	li $v0,4
	syscall
	#END
	j CON
L5:
	addi $t1,$t0,-5
	bne $t1,$0,L6
	li $v0,4
	la $a0,TBCau5.1
	syscall
	
	move $a0,$s0
	jal CoutDATE

	li $v0,4
	la $a0,TBCau5.2
	syscall

	move $a0,$s0
	jal TinhKhoangCachTuNgayDau
	
	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,TBCau5.3
	syscall
	#END
	j CON
L6:
	addi $t1,$t0,-6
	bne $t1,$0,L7
	#Goi ham + xuat blalala
	#...
	#END
	la $a0,out
	jal RestoreSTR

	la $a0,TIME_1
	jal GetYear
	move $t3,$v0

	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,TBCau6.1
	syscall
	
	move $a0,$s0
	la $a1,out
	jal Namamlich

	la $a0,out
	li $v0,4
	syscall
	
	
	j CON
L7:
	addi $t1,$t0,-7
	bne $t1,$0,L8
	#Goi ham + xuat blalala
	li $v0,4
	la $a0,TBCau7.2
	syscall
	
	la $a0,TIME_2
	jal CinDATE
	
	li $v0,4
	la $a0,TBCau7.3
	syscall
	
	la $a0,TIME_1
	jal CoutDATE
	
	li $v0,4
	la $a0,TBCau7.4
	syscall

	la $a0,TIME_2
	jal CoutDATE

	li $v0,4
	la $a0,TBCau5.2
	syscall

	la $a0,TIME_1
	la $a1,TIME_2
	jal DateDiff

	move $a0,$v0
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,TBCau5.3
	syscall
	#END
	j CON
L8:
	addi $t1,$t0,-8
	bne $t1,$0,L9
	
	
	la $a0,TIME_1
	jal GetYear
	move $a0, $v0
	move $t5, $a0
	
	move $a0,$s0
	jal HaiNamNhuanGanNhat
	move $t3, $v0
	move $t4, $v1
	
	li $v0, 4
        la $a0, TBCau8.1
        syscall

        move $a0,$t5
        li $v0,1
        syscall

        li $v0, 4
        la $a0, TBCau8.2
        syscall
        
        move $a0, $t3
        li $v0,1
        syscall
        
        li $v0, 4
        la $a0, TBCau8.3
        syscall
        
        move $a0, $t4
        li $v0,1
        syscall

	j CON
L9:
	addi $t1,$t0,-9
	bne $t1,$0,L10
	#DOC FILE INPUT
	li $v0,13
	la $a0,input
	li $a1,0
	syscall

	#Lay dia chi file
	move $s2,$v0
	
	#Doc file
	li $v0,14
	move $a0,$s2
	la $a1,STR_INPUT
	la $a2,22
	syscall
	
	#Lay 2 chuoi thoi gian
	la $a0,STR_INPUT
	la $a1,TIME_1_TXT
	la $a2,TIME_2_TXT
	jal TACHCHUOI
	
	
	#Dong file input
	li $v0,	16
	move $a0,$s2
	syscall

	la $a1,TIME_1_TXT
	la $a2,TIME_2_TXT
	li $t2,'/'
	sb $t2,2($a1)
	sb $t2,5($a1)
	sb $t2,2($a2)
	sb $t2,5($a2)

	#Mo file output
	li $v0,13
 	la $a0,output
	li $a1,1
	li $a2,0
	syscall
	move $s2, $v0
	
	la $a0,TIME_1_TXT
	jal CHECKSTRTXT
	move $t1,$v0

	la $a0,TIME_2_TXT
	jal CHECKSTRTXT
	move $t2,$v0
	
	

	add $t3,$t1,$t2
	li $t4,2
	blt $t3,$t4,KHONGHOPLE
	j HOPLE
KHONGHOPLE:
	
	beq $t1,$t2,CA2
	j MotTrong2
CA2:
	la $a0,STR_OUTPUT
	la $a1,KHL12
	jal GhepChuoi
	j XUATFILE
MotTrong2:
	beq $t1,$0,MOT
	j HAI
MOT:
	la $a0,STR_OUTPUT
	la $a1,KHL1
	jal GhepChuoi
	j XUATFILE
HAI:
	la $a0,STR_OUTPUT
	la $a1,KHL2
	jal GhepChuoi
	j XUATFILE
HOPLE:	
	la $a0,STR_OUTPUT
	jal RestoreSTR
	#cau 1
	la $a0,STR_OUTPUT
	la $a1,Cau1F
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TIME_1_TXT
	jal GhepChuoi

	#Cau 2
	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau2AF
	jal GhepChuoi
	
	la $a0,TIME_1_TXT
	li $a1,'A'
	jal Convert

	move $a1,$v0
	la $a0,STR_OUTPUT
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau2BF
	jal GhepChuoi
	
	la $a0,TIME_1_TXT
	li $a1,'B'
	jal Convert

	move $a1,$v0
	la $a0,STR_OUTPUT
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau2CF
	jal GhepChuoi
	
	la $a0,TIME_1_TXT
	li $a1,'C'
	jal Convert

	move $a1,$v0
	la $a0,STR_OUTPUT
	jal GhepChuoi

	#Cau 3
	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau3F
	jal GhepChuoi

	la $a0,TIME_1_TXT
	jal GetYear

	move $t3,$v0

	move $a0,$v0
	la $a1,SO
	jal toString

	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi

	la $a0,TIME_1_TXT
	jal LeapYear

	beq $v0,$0,notNhuanFile

	la $a0,STR_OUTPUT
	la $a1,TBCau3.2
	jal GhepChuoi
	j TiepTucFile
notNhuanFile:
	la $a0,STR_OUTPUT
	la $a1,TBCau3.1
	jal GhepChuoi
TiepTucFile:
	#Cau 4
	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau4F
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TIME_1_TXT
	jal GhepChuoi
	
	la $a0,TIME_1_TXT
	jal GetWeekDay
	beq $v0,$0,CON
	
	la $a0,STR_OUTPUT
	move $a1,$v0
	jal GhepChuoi
	#Cau 5
	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau5F
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TBCau5.1
	jal GhepChuoi


	la $a0,STR_OUTPUT
	la $a1,TIME_1_TXT
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TBCau5.2
	jal GhepChuoi

	la $a0,TIME_1_TXT
	jal TinhKhoangCachTuNgayDau
	
	move $a0,$v0
	la $a1,SO
	jal toString

	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi
	
	la $a0,STR_OUTPUT
	la $a1,TBCau5.3
	jal GhepChuoi

	#Cau 6

	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau6F
	jal GhepChuoi

	la $a0,TIME_1_TXT
	jal GetYear
	move $t3,$v0

	move $a0,$v0
	la $a1,SO
	jal toString
	
	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TBCau6.1
	jal GhepChuoi
	
	la $a0,out
	jal RestoreSTR
	
	la $a0,TIME_1_TXT
	la $a1,out
	jal Namamlich

	la $a0,STR_OUTPUT
	la $a1,out
	jal GhepChuoi
	
	#Cau 7
	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau7F
	jal GhepChuoi


	la $a0,STR_OUTPUT
	la $a1,TBCau7.3
	jal GhepChuoi
	
	la $a0,STR_OUTPUT
	la $a1,TIME_1_TXT
	jal GhepChuoi
	
	la $a0,STR_OUTPUT
	la $a1,TBCau7.4
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TIME_2_TXT
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,TBCau5.2
	jal GhepChuoi

	la $a0,TIME_1_TXT
	la $a1,TIME_2_TXT
	jal DateDiff

	move $a0,$v0
	la $a1,SO
	jal toString

	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi
	#Cau 8
	la $a0,STR_OUTPUT
	la $a1,xuongdong
	jal GhepChuoi

	la $a0,STR_OUTPUT
	la $a1,Cau8F
	jal GhepChuoi

	la $a0,TIME_1_TXT
	jal GetYear
	move $a0, $v0
	move $t5, $a0
	
	la $a0,TIME_1_TXT
	jal HaiNamNhuanGanNhat
	move $t3, $v0
	move $t4, $v1
	
	la $a0,STR_OUTPUT
	la $a1,TBCau8.1
	jal GhepChuoi

       	move $a0,$t5
	la $a1,SO
	jal toString
	
	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi

       la $a0,STR_OUTPUT
	la $a1,TBCau8.2
	jal GhepChuoi
        
       	move $a0,$t3
	la $a1,SO
	jal toString
	
	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi

       la $a0,STR_OUTPUT
	la $a1,TBCau8.3
	jal GhepChuoi
        
       	move $a0,$t4
	la $a1,SO
	jal toString
	
	la $a0,STR_OUTPUT
	la $a1,SO
	jal GhepChuoi
XUATFILE:	
	#Dem so luong ki tu trong chuoi xuat ra file input
	la $a0,STR_OUTPUT
	jal STR_LENGHT

	#Xuat ra file input
	move $a2,$v0
	li $v0,15
	move $a0,$s2
	la $a1,STR_OUTPUT
	syscall
	
	#Dong file
	li $v0,	16
	move $a0,$s2
	syscall
	j CON
L10:
	li $v0,4
	la $a0,NhapSai
	syscall
	j BD
CON:	
	li $v0,4
	la $a0,CONTINUE
	syscall

	li $v0,5
	syscall
	

	li $t1,1
	beq $t1,$v0,LOOPMENU
	j EXIT
EXIT:
	#Restore thanh ghi
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	
	#Xoa stack
	addi $sp,$sp,20
	#Tra ve
	jr $ra
	j KETTHUC
#-------------------------Ham Nhap------------------------
CinDATE:
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)

	move $s0,$a0
	#Cap phat bo nho tam de nhap chuoi
	j LoopCin
	
#Xuat thong bao nhap lai
RetypeNgay:
	li $v0,4
	la $a0,strDayErr
	syscall
	j NhapNgay
RetypeThang:
	li $v0,4
	la $a0,strMonthErr
	syscall
	j NhapThang
RetypeNam:
	li $v0,4
	la $a0,strYearErr
	syscall
	j NhapNam
	
#Vong lap nhap
LoopCin:
NhapNgay: 
	li $v0,4
	la $a0,strCinDay
	syscall
	#Nhap ngay
	li $v0,8
	la $a0,($s0)
	li $a1,3
	syscall
	
	jal strLen
	li $t0,1
	slt $t0,$t0,$v0
	beq $t0,$0,KTngayDaNhap
	move $t0,$a0
	#In ky tu xuong dong
	li $v0,11
	li $a0,'\n'
	syscall
	move $a0,$t0
	
KTngayDaNhap:
	#Kiem tra chuoi da nhap
	jal checkFullNumber
	beq $v0,$0,RetypeNgay
	jal toNumber
	move $t0,$v0
	
NhapThang:
	li $v0,4
	la $a0,strCinMonth
	syscall
	#Nhap thang
	li $v0,8
	la $a0,($s0)
	li $a1,3
	syscall
	
	jal strLen
	li $t1,1
	slt $t1,$t1,$v0
	beq $t1,$0,KTthangDaNhap
	move $t1,$a0
	#In ky tu xuong dong
	li $v0,11
	li $a0,'\n'
	syscall
	move $a0,$t1
	
KTthangDaNhap:
	#Kiem tra chuoi da nhap
	jal checkFullNumber
	beq $v0,$0,RetypeThang
	jal toNumber
	move $t1,$v0
	
NhapNam:
	li $v0,4
	la $a0,strCinYear
	syscall
	#Nhap nam
	li $v0,8
	la $a0,($s0)
	li $a1,5
	syscall
	
	jal strLen
	li $t2,3
	slt $t2,$t2,$v0
	beq $t2,$0,KTnamDaNhap
	move $t2,$a0
	#In ky tu xuong dong
	li $v0,11
	li $a0,'\n'
	syscall
	move $a0,$t2
	
KTnamDaNhap:
	#Kiem tra chuoi da nhap
	jal checkFullNumber
	beq $v0,$0,RetypeNam
	jal toNumber
	move $t2,$v0

	move $a0, $t0	
	move $a1, $t1	
	move $a2, $t2
	la $a3, ($s0)		
	jal Date
	#Kiem tra ngay co dung

	move $a0,$v0
	jal CheckDATE
	bne $v0,$0,EndCin

	#Kiem tra, neu du lieu khong thoa thi quay nhap lai
	li $v0,4
	la $a0,STRNhapLai
	syscall

	j LoopCin
EndCin:
	move $a0,$s0
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	addi $sp,$sp,20
	jr $ra
	
	#+++++++++++++++Lay Do dai chuoi+++++++++++++++++++++++++
strLen:
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $s0,16($sp)

	move $t2,$a0	
	#Gan
	addi $s0,$0,0
	addi $t0,$0,0
	li $t1,'\n'
	
LoopStrLen:
	lb $t0,($t2)
	beq $t0,$0,EOFuncStrLen
	beq $t0,$t1,EndWithNwLine
	addi $s0,$s0,1
	addi $t2,$t2,1
	j LoopStrLen
EndWithNwLine:
	sb $0,($t2)
EOFuncStrLen:
	move $v0,$s0
	
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $s0,16($sp)
	
	addi $sp,$sp,20
	
	jr $ra
	
	#++++++++++++++Ham chuyen chuoi sang so++++++++++++++++
toNumber:
	addi $sp,$sp,-28
	sw $ra,($sp)
	sw $s0, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)
	sw $t2, 16($sp)
	sw $t3, 20($sp)
	sw $s1, 24($sp)
	
	move $t3,$a0
	li $s0,0
	li $t0,0
	li $s1,10
	jal strLen
	move $t1,$v0
LoopToNumber:
	beq $t0,$t1,EOToNumber
	mult $s0,$s1
	mflo $s0
	lb $t2,($t3)
	addi $t2, $t2, -48
	add $s0,$s0,$t2
	addi $t0,$t0,1
	addi $t3,$t3,1
	j LoopToNumber
EOToNumber:
	move $v0,$s0
	
	lw $ra,($sp)
	lw $s0, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	lw $t2, 16($sp)
	lw $t3, 20($sp)
	lw $s1, 24($sp)
	addi $sp,$sp,28
	
	jr $ra
	#++++++++++++++Ham kiem tra chuoi co toan bo la so hay khong++++++++++++
checkFullNumber:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $t2, 12($sp)
	sw $t3, 16($sp)
	sw $s0, 20($sp)
	sw $s1, 24($sp)
	sw $s2, 28($sp)
	
	move $s2,$a0
	addi $s0,$0,0
	li $t3,9
	jal strLen
	move $s1,$v0
LoopCkFlNum:
	beq $s0,$s1,strIsFullNumber
	lb $t0,($s2)
	addi $t0,$t0,-48
	slti $t1,$t0,0
	slt $t2,$t3,$t0
	xori $t1,$t1,1
	xori $t2,$t2,1
	and $t1,$t1,$t2
	beq $t1,$0,strIsNotFullNumber
	addi $s0,$s0,1
	addi $s2,$s2,1
	j LoopCkFlNum
	
strIsNotFullNumber:
	move $v0,$0
	j EndCheckFullNum

strIsFullNumber:
	beq $s1,$0,strIsNotFullNumber
	li $v0,1

EndCheckFullNum:
	lw $ra,($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $t2, 12($sp)
	lw $t3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	addi $sp,$sp,32
	
	jr $ra
	
#--------------------Ham Kiem tra ngay thang nam nhap vao--------------
CheckDATE:
	#Khoi tao stack
	addi $sp,$sp,-28

	#Backup thanh ghi
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $s1,20($sp)
	sw $s0,24($sp)
	
	move $s0,$a0
	#Lay du lieu
	move $a0,$s0
	jal GetDay
	move $t0,$v0 #Lay ngay

	
	move $a0,$s0
	jal GetMonth
	move $t1,$v0 #Lay thang
	
	move $t2,$v0 #Lay nam

	#Kiem tra nam: nam>0 
	ble $t2,$0,Error
	
	#Kiem tra thang: thang >0 and thang <=12
	li $t3,12
	blt $t3,$t1,Error
	ble $t1,$0,Error

	#Kiem tra ngay: Ngay >0 and Ngay <=Max Day of Month
	move $a0,$s0
	jal LeapYear
	
	
	#Lay vi tri trong mangr SoNgay
	addi $t1,$t1,-1
	li $t3,4
	mult $t1,$t3
	mflo $t3

	
	#Lay so ngay
	la $s1,SoNgay
	add $s1,$s1,$t3
	lw $t3,($s1)
	
	#Cong them 1 neu nam nhuan
	li $t2,1
	beq $t1,$t2,CongThang2
	j Continue
CongThang2:
	add $t3,$t3,$v0
Continue:
	#Kiem Tra ngay
	ble $t0,$0,Error
	blt $t3,$t0,Error
	li $v0,1
	j EndCheck
Error:
	li $v0,0
	j EndCheck
EndCheck:
	#Restore thanh ghi
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $s1,20($sp)
	lw $s0,24($sp)
	#Xoa stack
	addi $sp,$sp,28

	jr $ra

#-------------------Ham chuyen tu 3 tham so truyen vao sang chuoi DATE------------------
Date:
	addi $sp,$sp,-24
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	
	# Ngày
	li $t1,10		# gán t1 = 10
	div $a0, $t1		# chia ngày cho 10
	mflo $t2		# $t2 = Ngay / 10
	mfhi $t3		# $t3 = Ngay % 10
	addi $t2, $t2, '0'	# $t2 chuy?n t? int sang char ($t2 + '0') 
	addi $t3, $t3, '0'	# $t3 chuy?n t? int sang char ($t3 + '0') 
	sb $t2, 0($a3)		# STRDATE[0] = $t2
	sb $t3, 1($a3)		# STRDATE[1] = $t3
	addi $t4, $0, '/'	# gán t4 = '/'
	sb $t4, 2($a3)		# STRDATE[2] = '/'

	# Tháng
	li $t1,10		# gán t1 = 10
	div $a1, $t1		# chia tháng cho 10
	mflo $t2		# $t2 = Tháng / 10
	mfhi $t3		# $t3 = Tháng % 10
	addi $t2, $t2, '0'	# $t2 chuy?n t? int sang char ($t2 + '0') 
	addi $t3, $t3, '0'	# $t3 chuy?n t? int sang char ($t3 + '0') 
	sb $t2, 3($a3)		# STRDATE[3] = $t2
	sb $t3, 4($a3)		# STRDATE[4] = $t3
	addi $t4, $0, '/'	# gán t4 = '/'
	sb $t4, 5($a3)		# STRDATE[5] = '/'

	# N?m
	add $t0, $0, $a2	# gán t0 = n?m ($a2)
	li $t1,1000		# gán t1 = 10
	div $t0, $t1
	mflo $t2		# $t2 = N?m / 1000
	mfhi $t0		# $t0 = N?m % 1000
	addi $t2, $t2, '0'	# $t2 chuy?n t? int sang char ($t2 + '0') 
	sb $t2, 6($a3)		# STRDATE[6] = $t2

	li $t1,100		# gán t1 = 100
	div $t0, $t1
	mflo $t2		# $t2 = (YEAR % 1000) / 100
	mfhi $t0		# $t0 = YEAR % 100
	addi $t2, $t2, '0'	# $t2 chuy?n t? int sang char ($t2 + '0') 
	sb $t2, 7($a3)		# STRDATE[7] = $t2

	li $t1,10
	div $t0, $t1
	mflo $t2		# $t2 = (YEAR % 100) / 10
	mfhi $t0		# $t0 = YEAR % 10
	addi $t2, $t2, '0'	# $t2 chuy?n t? int sang char ($t2 + '0') 
	addi $t0, $t0, '0'	# $t0 chuy?n t? int sang char ($t3 + '0') 
	sb $t2, 8($a3)		# STRDATE[8] = $t2
	sb $t0, 9($a3)		# STRDATE[9] = $t0

	# exit
	sb $0, 10($a3)	# STRDATE[10] = '\0'
	move $v0,$a3	# tr? v? $a3 gi? ??a ch? STRDATE
	
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	addi $sp,$sp,24
	jr $ra
#---------------------Cac ham get ngay thang nam-----------------------
	#+++++++++++++++Ham getDay++++++++++++++++
GetDay:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, ($sp)

	#Extract phan thap phan
	lb $t0, ($a0)
	addi $t0, $t0,-48
	addi $t1,$0,10
	mult $t0,$t1
	mflo $t1
	
	#Extract don vi
	lb $t0, 1($a0)
	addi $t0, $t0,-48
	add $t0,$t1,$t0
	
	#Tra ve
	move	$v0, $t0

	lw	$ra, 8($sp)
	lw	$t0, 4($sp)
	lw	$t1, ($sp)
	addi 	$sp, $sp, 12	
	
	jr	$ra
	#+++++++++++++++Ham getMonth++++++++++++++++
GetMonth:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, ($sp)
	
	#Extract phan chuc
	lb $t0, 3($a0)
	addi $t0, $t0,-48
	addi $t1,$0,10
	mult $t0,$t1
	mflo $t1
	
	#Extract don vi
	lb $t0, 4($a0)
	addi $t0, $t0,-48
	add $t0,$t1,$t0
	
	#Tra ve
	move	$v0, $t0

	lw	$ra, 8($sp)
	lw	$t0, 4($sp)
	lw	$t1, ($sp)
	addi 	$sp, $sp, 12
	
	jr	$ra
	#+++++++++++++++Ham getYear++++++++++++++++
GetYear:
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $s0, 8($sp)
	sw $t0, 4($sp)
	sw $t1, ($sp)
	
	#Extract phan nghin
	lb $t0, 6($a0)
	addi $t0, $t0,-48
	addi $t1,$0,1000
	mult $t0,$t1
	mflo $t0
	move $s0, $t0
	
	#Extract phan tram
	lb $t0, 7($a0)
	addi $t0, $t0,-48
	addi $t1,$0,100
	mult $t0,$t1
	mflo $t0
	add $s0,$s0,$t0
	
	#Extract phan chuc
	lb $t0, 8($a0)
	addi $t0, $t0,-48
	addi $t1,$0,10
	mult $t0,$t1
	mflo $t0
	add $s0,$s0,$t0
	
	#Extract don vi
	lb $t0, 9($a0)
	addi $t0, $t0,-48
	add $s0,$s0,$t0
	
	#Tra ve
	move $v0,$s0
	
	lw $ra, 12($sp)
	lw $s0, 8($sp)
	lw $t0, 4($sp)
	lw $t1, ($sp)
	addi $sp,$sp,16
	
	jr $ra
#-----------------------------Ham xuat---------------------
CoutDATE:
	addi $sp,$sp,-8
	sw $ra,($sp)
	sw $s0,4($sp)

	move $s0,$a0

	li $v0,4
 	move $a0,$s0
	syscall
	
	lw $ra,($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra
#------------------Kiem tra nam nhuan---------------
LeapYear:
#Khoi tao cac bien can dung trong ham
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)

	jal GetYear
	move $t0,$v0
	
	li $t1,4
	div $t0,$t1
	
	mfhi $t2
	beq $t2,$0,Chia4
	j KhongNhuan
Chia4:
	li $t1,100
	div $t0,$t1
	mfhi $t2
	beq $t2, $0,KhongChia100
	j Nhuan
KhongChia100:
	li $t1,400
	div $t0,$t1
	mfhi $t2
	beq $t2,$0,Nhuan
	j KhongNhuan
Nhuan:
	li $v0,1
	j KetThucHamKTNamNhuan
KhongNhuan:
	li $v0,0
	j KetThucHamKTNamNhuan
KetThucHamKTNamNhuan:
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,16
	jr $ra
#--------------------Tim ngay thu may trong tuan--------
GetWeekDay:
#Bat dau ham:
	addi $sp,$sp,-8
	sw $t0,4($sp)
	sw $ra,($sp)
	
#Than ham:
	jal TinhKhoangCachTuNgayDau
	li $t0,7
	div $v0,$t0
	mfhi $v0
	move $t0,$a0
	move $a0,$v0
	jal dayOfWeekStr
	move $v0,$v0
	move $a0,$t0

	#Phuc hoi cac gia tri cu
	lw $t0,4($sp)
	lw $ra,($sp)
	addi $sp,$sp,8
	
	jr $ra
	
	#+++++++++++++++++++++Chuyen sang str++++++++++++++++
dayOfWeekStr:
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)	
	
	move $t0,$a0
	li $t1,6
	blt $t1,$t0,wrongInput
	
	la $t1,daysOfWeek
	sll $t0,$t0,2
	add $t1,$t1,$t0
	lw $t0,($t1)
	jr $t0
	
cn:
	la $v0, sun
	j KTXuatThu
t2:
	la $v0, mon
	j KTXuatThu	
t3:
	la $v0, tue
	j KTXuatThu	
t4:
	la $v0, wed
	j KTXuatThu	
t5:
	la $v0, thu
	j KTXuatThu	
t6:
	la $v0, fri
	j KTXuatThu	
t7:
	la $v0, sat
	j KTXuatThu	
	
wrongInput:
	li $v0,0
KTXuatThu:
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)	
	addi $sp,$sp,12
	
	jr $ra
#--------------------------Ham tinh khoang cach den 1/1/1----------------
DateDiff:
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)

	jal TinhKhoangCachTuNgayDau
	move $t0,$v0

	move $a0,$a1
	jal TinhKhoangCachTuNgayDau
	move $t1,$v0

	blt $t1,$t0,NhoHon
	sub $v0,$t1,$t0
	j EndDateDiff
NhoHon:
	sub $v0,$t0,$t1
EndDateDiff:
	
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
TinhKhoangCachTuNgayDau:
#Dau thu tuc:
	addi $sp,$sp,-28
	
	#Backup
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $s0,16($sp)
	sw $t3,20($sp)
	sw $t4,24($sp)
	move $s0,$a0

#Than thu tuc:
	move $a0,$s0
	jal GetDay
	move $t0,$v0
	
	move $a0,$s0
	jal GetMonth
	move $t1,$v0

	move $a0,$s0
	jal GetYear
	move $t2,$v0
	
	li $t3,3
	blt $t1,$t3,TH
	j tt
TH:
	li $t3,12
	add $t1,$t1,$t3
	addi $t2,$t2,-1
tt:
	li $t3,365
	mult $t3,$t2
	mflo $v0
	

	li $t3,4
	div $t2,$t3
	mflo $t3
	add $v0,$v0,$t3

	li $t3,100
	div $t2,$t3
	mflo $t3
	sub $v0,$v0,$t3

	li $t3,400
	div $t2,$t3
	mflo $t3
	add $v0,$v0,$t3

	li $t3,153
	mult $t1,$t3
	mflo $t3
	addi $t3,$t3,-457

	li $t4,5
	div $t3,$t4
	mflo $t3
	add $v0,$v0,$t3

	add $v0,$v0,$t0
	addi $v0,$v0,-307
#Cuoi thu tuc:
	
	
	#Backup
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $s0,16($sp)
	lw $t3,20($sp)
	lw $t4,24($sp)
	
	#Xoa stack
	addi $sp,$sp,28
	
	#Tra ve
	jr $ra
#--------------------------Ham chuyen tu so sang chuoi-------------

TACHCHUOI:
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)

	li $t0,0
	li $t1,10
Chuoi1:
	lb $t2,($a0)
	sb $t2,($a1)
	addi $a0,$a0,1
	addi $a1,$a1,1
	addi $t0,$t0,1
	blt $t0,$t1,Chuoi1
	sb $0,($a1)
	addi $a0,$a0,2
	li $t0,0
Chuoi2:
	lb $t2,($a0)
	sb $t2,($a2)
	addi $a0,$a0,1
	addi $a2,$a2,1
	addi $t0,$t0,1
	blt $t0,$t1,Chuoi2
	sb $0,($a2)
	

	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,16
	jr $ra


GhepChuoi:
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)

Doi:
	lb $t2,($a0)
	beq $t2,$0,Noi
	addi $a0,$a0,1
	j Doi
Noi:
	lb $t2,($a1)
	beq $t2,$0,KT
	sb $t2,($a0)
	addi $a0,$a0,1
	addi $a1,$a1,1
	j Noi
KT:
	sb $0,($a0)

	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,16
	jr $ra
STR_LENGHT:
	addi $sp,$sp,-8
	sw $ra,($sp)
	sw $t0,4($sp)

	li $v0,0
LENGHT:
	lb $t0,($a0)
	addi $v0,$v0,1
	addi $a0,$a0,1
	bne $t0,$0,LENGHT
	
	
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp,8

	jr $ra
CHECKSTRTXT:
	addi $sp,$sp,-24
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $s0,20($sp)
	move $s0,$a0
	li $v0,1
	li $t2,47
	li $t3,57
KTra:
	lb $t0,($a0)
	addi $a0,$a0,1
	blt $t3,$t0,SAI
	
	beq $t0,$0,KTSO
	blt $t0,$t2,SAI


	j KTra
KTSO:

	move $a0,$s0
	jal CheckDATE
	j ENDSTR
SAI:
	li $v0,0
ENDSTR:
	
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $s0,20($sp)
	addi $sp,$sp,24
	jr $ra



#++++++++++++Dao nguoc chuoi+++++++++++++
reverseStr:
	addi $sp,$sp,-24
	sw $ra, ($sp)
	sw $s0, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)
	sw $t2, 16($sp)
	sw $t3, 20($sp)
	
	#Strlen/2
	jal strLen
	move $s0,$v0
	
	#Bien dem
	li $t0,0
	#ptr dau mang
	move $t1,$a0
revStrLoop:
	li $t3,2
	div $s0,$t3
	mflo $t3
	beq $t0,$t3,EOReverseStr
	#Dao 
	lb $t2,($t1)
	#Vi tri doi dien
	sub $t1,$t1,$t0
	add $t1,$t1,$s0
	addi $t1,$t1,-1
	sub $t1,$t1,$t0
	#Tai VT doi dien
	lb $t3,($t1)
	sb $t2,($t1)
	#Ve lai vi tri cu
	add $t1,$t1,$t0
	addi $t1,$t1,1
	sub $t1,$t1,$s0
	add $t1,$t1,$t0
	sb $t3,($t1)
	#Sau xu li
	addi $t1,$t1,1 #address
	addi $t0,$t0,1
	j revStrLoop
EOReverseStr:
	move $v0,$a0
	
	lw $ra, ($sp)
	lw $s0, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	lw $t2, 16($sp)
	lw $t3, 20($sp)
	addi $sp,$sp,24
	
	jr $ra
#------------Doi tu so sang chuoi------------
#Dua vao dia chi vung nho luu chuoi, Dua vao so can chuyen
toString:
	addi $sp,$sp,-24
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	sw $t2,20($sp)
	
	move $s0,$a0
	move $s1,$a1
	
	li $t2,0
	li $t0,10
toStrLoop:
	beq $s0,$0,DoubleCheck
	div $s0,$t0
	mflo $s0
	mfhi $t1
	addi $t1,$t1,48
	sb $t1,($s1)
	addi $s1,$s1,1
	addi $t2,$t2,1
	j toStrLoop
DoubleCheck:
	beq $t2,$0,isZeroNum
	j EOToStr
isZeroNum:
	addi $t1,$0,48
	sb $t1,($s1)
	addi $s1,$s1,1
EOToStr:
	li $t1,0
	sb $t1,($s1)
	move $t1,$a0
	move $a0,$a1
	jal reverseStr
	move $a0,$t1
	#KQ tra ra cua ham cung la ket qua tra ra cua ham reverseStr
	move $v0,$v0
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	lw $t2,20($sp)
	addi $sp,$sp,24
	
	jr $ra
# Ham chuyen thang trong STRDATE thanh chuoi
# a0: GetMonth
ChuyenThangSangChuoi:
	addi $sp,$sp,-12
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	move $t1,$a0
	li $v0,9
	li $a0,10
	syscall

	beq $t1,1,January	# Neu thang = 1, nhay den January

	beq $t1,2,February

	beq $t1,3,March

	beq $t1,4,April

	beq $t1,5,May

	beq $t1,6,June

	beq $t1,7,July

	beq $t1,8,August

	beq $t1,9,September

	beq $t1,10,October

	beq $t1,11,November

	j December 			
January:
	li $t0,'J'
	sb $t0,($v0)
	li $t0,'a'
	sb $t0,1($v0)
	li $t0,'n'
	sb $t0,2($v0)
	li $t0,'u'
	sb $t0,3($v0)
	li $t0,'a'
	sb $t0,4($v0)
	li $t0,'r'
	sb $t0,5($v0)
	li $t0,'y'
	sb $t0,6($v0)
	sb $0,7($v0)

	j KetThucHam_ChuyenThangSangChuoi
February:
	li $t0,'F'
	sb $t0,($v0)
	li $t0,'e'
	sb $t0,1($v0)
	li $t0,'b'
	sb $t0,2($v0)
	li $t0,'r'
	sb $t0,3($v0)
	li $t0,'u'
	sb $t0,4($v0)
	li $t0,'a'
	sb $t0,5($v0)
	li $t0,'r'
	sb $t0,6($v0)
	li $t0,'y'
	sb $t0,7($v0)
	sb $0,8($v0)

	j KetThucHam_ChuyenThangSangChuoi
March:
	li $t0,'M'
	sb $t0,($v0)
	li $t0,'a'
	sb $t0,1($v0)
	li $t0,'r'
	sb $t0,2($v0)
	li $t0,'c'
	sb $t0,3($v0)
	li $t0,'h'
	sb $t0,4($v0)
	sb $0,5($v0)
	j KetThucHam_ChuyenThangSangChuoi
April:
	li $t0,'A'
	sb $t0,($v0)
	li $t0,'p'
	sb $t0,1($v0)
	li $t0,'r'
	sb $t0,2($v0)
	li $t0,'i'
	sb $t0,3($v0)
	li $t0,'l'
	sb $t0,4($v0)
	sb $0,5($v0)
	j KetThucHam_ChuyenThangSangChuoi
May:
	li $t0,'M'
	sb $t0,($v0)
	li $t0,'a'
	sb $t0,1($v0)
	li $t0,'y'
	sb $t0,2($v0)
	sb $0,3($v0)
	j KetThucHam_ChuyenThangSangChuoi
June:
	li $t0,'J'
	sb $t0,($v0)
	li $t0,'u'
	sb $t0,1($v0)
	li $t0,'n'
	sb $t0,2($v0)
	li $t0,'e'
	sb $t0,3($v0)
	sb $0,4($v0)
	j KetThucHam_ChuyenThangSangChuoi
July:
	li $t0,'J'
	sb $t0,($v0)
	li $t0,'u'
	sb $t0,1($v0)
	li $t0,'l'
	sb $t0,2($v0)
	li $t0,'y'
	sb $t0,3($v0)
	sb $0,4($v0)
	j KetThucHam_ChuyenThangSangChuoi
August:
	li $t0,'A'
	sb $t0,($v0)
	li $t0,'u'
	sb $t0,1($v0)
	li $t0,'g'
	sb $t0,2($v0)
	li $t0,'u'
	sb $t0,3($v0)
	li $t0,'s'
	sb $t0,4($v0)
	li $t0,'t'
	sb $t0,5($v0)
	sb $0,6($v0)
	j KetThucHam_ChuyenThangSangChuoi
September:
	li $t0,'S'
	sb $t0,($v0)
	li $t0,'e'
	sb $t0,1($v0)
	li $t0,'p'
	sb $t0,2($v0)
	li $t0,'t'
	sb $t0,3($v0)
	li $t0,'e'
	sb $t0,4($v0)
	li $t0,'m'
	sb $t0,5($v0)
	li $t0,'b'
	sb $t0,6($v0)
	li $t0,'e'
	sb $t0,7($v0)
	li $t0,'r'
	sb $t0,8($v0)
	sb $0,9($v0)
	j KetThucHam_ChuyenThangSangChuoi
October:
	li $t0,'O'
	sb $t0,($v0)
	li $t0,'c'
	sb $t0,1($v0)
	li $t0,'t'
	sb $t0,2($v0)
	li $t0,'o'
	sb $t0,3($v0)
	li $t0,'b'
	sb $t0,4($v0)
	li $t0,'e'
	sb $t0,5($v0)
	li $t0,'r'
	sb $t0,6($v0)
	sb $0,7($v0)
	j KetThucHam_ChuyenThangSangChuoi
November:
	li $t0,'N'
	sb $t0,($v0)
	li $t0,'o'
	sb $t0,1($v0)
	li $t0,'v'
	sb $t0,2($v0)
	li $t0,'e'
	sb $t0,3($v0)
	li $t0,'m'
	sb $t0,4($v0)
	li $t0,'b'
	sb $t0,5($v0)
	li $t0,'e'
	sb $t0,6($v0)
	li $t0,'r'
	sb $t0,7($v0)
	sb $0,8($v0)
	j KetThucHam_ChuyenThangSangChuoi
December:
	li $t0,'D'
	sb $t0,($v0)
	li $t0,'e'
	sb $t0,1($v0)
	li $t0,'c'
	sb $t0,2($v0)
	li $t0,'e'
	sb $t0,3($v0)
	li $t0,'m'
	sb $t0,4($v0)
	li $t0,'b'
	sb $t0,5($v0)
	li $t0,'e'
	sb $t0,6($v0)
	li $t0,'r'
	sb $t0,7($v0)
	sb $0,8($v0)
KetThucHam_ChuyenThangSangChuoi:
	
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra

# Ham chuyen dinh dang
# a0: STRDATE
# a1: loai (A, B, C)
Convert:
	addi $sp,$sp,-24
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $t0,16($sp)
	sw $t1,20($sp)

	

	li $t0, 'A'	
	beq $a1, $t0, ChuyenDinhDang_A		# Neu loai = A 
	li $t0, 'B'	
	beq $a1, $t0, ChuyenDinhDang_B		# Neu loai = B
	li $t0, 'C'	
	beq $a1, $t0, ChuyenDinhDang_C		# Neu loai = C

# MM/DD/YYYY 
ChuyenDinhDang_A:
	#Cap phat vung nho
	move $s0,$a0
	li $v0,9
	li $a0,11
	syscall
	move $a0,$s0
	move $s0,$v0

	lb $t1, 3($a0)
	sb $t1, 0($s0)
	lb $t1, 4($a0)
	sb $t1, 1($s0)
	lb $t1, 2($a0)
	sb $t1, 2($s0)
	lb $t1, 0($a0)
	sb $t1, 3($s0)
	lb $t1, 1($a0)
	sb $t1, 4($s0)
	lb $t1, 5($a0)
	sb $t1, 5($s0)
	lb $t1, 6($a0)
	sb $t1, 6($s0)
	lb $t1, 7($a0)
	sb $t1, 7($s0)
	lb $t1, 8($a0)
	sb $t1, 8($s0)
	lb $t1, 9($a0)
	sb $t1, 9($s0)
	lb $t1, 10($a0)
	sb $t1, 10($s0)



	j KetThucHam_ChuyenDinhDang

# Month DD, YYYY
ChuyenDinhDang_B:
	#Cap phat bo nho cho $s0
	move $s2,$a0
	li $v0,9
	li $a0,20
	syscall

	move $s0,$v0
	
	#Cap phat bo nho cho $1
	li $v0,9
	li $a0,10
	syscall
	move $s1,$v0

	move $a0,$s2
	jal GetMonth

	move $a0,$v0
	jal ChuyenThangSangChuoi

	move $a0,$s0
	move $a1,$v0
	jal GhepChuoi
	move $a0,$s2
	li $t1,' '
	sb $t1,($s1)
	lb $t1,0($s2)
	sb $t1,1($s1)
	lb $t1,1($s2)
	sb $t1,2($s1)
	li $t1,','
	sb $t1,3($s1)
	li $t1,' '
	sb $t1,4($s1)
	lb $t1,6($s2)
	sb $t1,5($s1)
	lb $t1,7($s2)
	sb $t1,6($s1)
	lb $t1,8($s2)
	sb $t1,7($s1)
	lb $t1,9($s2)
	sb $t1,8($s1)
	lb $t1,10($s2)
	sb $t1,9($s1)

	move $a0,$s0
	move $a1,$s1
	jal GhepChuoi

	j KetThucHam_ChuyenDinhDang

# DD Month, YYYY
ChuyenDinhDang_C:
	#Cap phat bo nho cho $s0
	move $s2,$a0
	li $v0,9
	li $a0,20
	syscall

	move $s0,$v0
	
	#Cap phat bo nho cho $1
	li $v0,9
	li $a0,7
	syscall
	move $s1,$v0
	
	lb $t1,($s2)
	sb $t1,($s0)
	lb $t1,1($s2)
	sb $t1,1($s0)
	li $t1,' '
	sb $t1,2($s0)
	sb $0,3($s0)

	move $a0,$s2
	jal GetMonth

	move $a0,$v0
	jal ChuyenThangSangChuoi

	move $a0,$s0
	move $a1,$v0
	jal GhepChuoi

	li $t1,','
	sb $t1,($s1)
	li $t1,' '
	sb $t1,1($s1)
	lb $t1,6($s2)
	sb $t1,2($s1)
	lb $t1,7($s2)
	sb $t1,3($s1)
	lb $t1,8($s2)
	sb $t1,4($s1)
	lb $t1,9($s2)
	sb $t1,5($s1)
	lb $t1,10($s2)
	sb $t1,6($s1)

	move $a0,$s0
	move $a1,$s1
	jal GhepChuoi
	j KetThucHam_ChuyenDinhDang
KetThucHam_ChuyenDinhDang:
	move $v0,$s0
	
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $t0,16($sp)
	lw $t1,20($sp)
	addi $sp,$sp,24
	jr $ra

#------------------------------------------- Cau 6 -----------------------------------
Namamlich:

#Khoi tao cac bien can dung trong ham
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t5,16($sp)

        jal GetYear
	move $t0,$v0

#get ğ?a ch? output
        move $a0,$a1                
	
	
	
Soduchia10:	
	li $t1,10
	div $t0,$t1
	
	mfhi $t2
	j Can
Soduchia12:
        li $t1,12
	div $t0,$t1
	mfhi $t2

	j Chi
Can:    
        li $t5, 0
        beq $t2, $t5,_Canh 
        li $t5, 1
        beq $t2, $t5,_Tan
        li $t5, 2
        beq $t2, $t5,_Nham
        li $t5, 3
        beq $t2, $t5,_Quy
        li $t5, 4
        beq $t2, $t5,_Giap
        li $t5, 5
        beq $t2, $t5,_At
        li $t5, 6
        beq $t2, $t5,_Binh
        li $t5, 7
        beq $t2, $t5,_Dinh
        li $t5, 8
        beq $t2, $t5,_Mau
        li $t5, 9
        beq $t2, $t5,_Ky

_Canh:  la $a1,Canh  
	jal GhepChuoi
      j Soduchia12  
_Tan:  la $a1,Tan 
	jal GhepChuoi
      j Soduchia12  
_Nham:  la $a1,Nham 
	jal GhepChuoi
      j Soduchia12  
_Quy:  la $a1,Quy 
	jal GhepChuoi
      j Soduchia12  
_Giap:  la $a1,Giap
	jal GhepChuoi
      j Soduchia12  
_At:  la $a1,At
	jal GhepChuoi
      j Soduchia12  
_Binh:  la $a1,Binh 
	jal GhepChuoi
      j Soduchia12  
_Dinh:  la $a1,Dinh
	jal GhepChuoi
      j Soduchia12  
_Mau:  la $a1,Mau
	jal GhepChuoi
      j Soduchia12  
_Ky:  la $a1,Ky
	jal GhepChuoi
      j Soduchia12  
Chi:
        li $t5, 0
        beq $t2, $t5,_Than
        li $t5, 1
        beq $t2, $t5,_Dau
        li $t5, 2
        beq $t2, $t5,_Tuat
        li $t5, 3
        beq $t2, $t5,_Hoi
        li $t5, 4
        beq $t2, $t5,_Ty
        li $t5, 5
        beq $t2, $t5,_Suu
        li $t5, 6
        beq $t2, $t5,_Dan
        li $t5, 7
        beq $t2, $t5,_Mao
        li $t5, 8
        beq $t2, $t5,_Thin
        li $t5, 9
        beq $t2, $t5,_Ty
        li $t5, 10
        beq $t2, $t5,_Ngo
        li $t5, 11
        beq $t2, $t5,_Mui
        
_Ty:     la $a1,Ty  
        jal GhepChuoi 
	j Ketthucham
_Suu:    la $a1,Suu  
        jal GhepChuoi 
	j Ketthucham

_Dan:     la $a1,Dan  
        jal GhepChuoi 
	j Ketthucham
_Mao:    la $a1,Mao 
        jal GhepChuoi 
	j Ketthucham  

_Thin:   la $a1,Thin  
        jal GhepChuoi 
	j Ketthucham
_Ngo:    la $a1,Ngo  
        jal GhepChuoi 
	j Ketthucham
_Mui:     la $a1,Mui
         jal GhepChuoi 
	j Ketthucham
_Than:    la $a1,Than 
         jal GhepChuoi 
	j Ketthucham 
_Dau:     la $a1,Dau 
         jal GhepChuoi 
	j Ketthucham
_Tuat:    la $a1,Tuat  
         jal GhepChuoi 
	j Ketthucham  
_Hoi:   la $a1,Hoi  
         jal GhepChuoi 
	j Ketthucham   
       

Ketthucham:
   	move $v0,$a0
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t5,16($sp)
	addi $sp,$sp,20
	jr $ra
#----------------------- Cau 8 -----------------------------
HaiNamNhuanGanNhat:
#Khoi tao cac bien can   trong ham
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)

        jal GetYear
	move $t0,$v0
# Than chuong trinh
        li $t1, 1
        beq $t1, $t0,thongbao1
        li $t1, 2
        beq $t1, $t0,thongbao1
        li $t1, 3
        beq $t1, $t0,thongbao1
        li $t1, 4
        beq $t1, $t0,thongbao2
        
        li $t3,400
        li $t1, 96
        div $t0, $t3
        mfhi $t2
        li $t1, 96
        beq $t1, $t2, thongbao3
         li $t1, 196
        beq $t1, $t2, thongbao3
         li $t1, 296
        beq $t1, $t2, thongbao3
        li $t1, 97
        beq $t1, $t2, thongbao4
         li $t1, 197
        beq $t1, $t2, thongbao4
         li $t1, 297
        beq $t1, $t2, thongbao4
        li $t1, 98
        beq $t1, $t2, thongbao5
         li $t1, 198
        beq $t1, $t2, thongbao5
         li $t1, 298
        beq $t1, $t2, thongbao5
        
        li $t1, 99
        beq $t1, $t2, thongbao6
         li $t1, 199
        beq $t1, $t2, thongbao6
         li $t1, 299
        beq $t1, $t2, thongbao6
        

        li $t1, 0
        beq $t1, $t2, thongbao7
        li $t1, 100
        beq $t1, $t2, thongbao7
         li $t1, 200
        beq $t1, $t2, thongbao7
         li $t1, 300
        beq $t1, $t2, thongbao7
        
        li $t1, 101
        
        beq $t1, $t2, thongbao8
         li $t1, 201
        beq $t1, $t2, thongbao8
         li $t1, 301
        beq $t1, $t2, thongbao8
        
        li $t1, 102
        beq $t1, $t2, thongbao9
         li $t1, 202
        beq $t1, $t2, thongbao9
         li $t1, 302
        beq $t1, $t2, thongbao9
        
        li $t1, 103
        beq $t1, $t2, thongbao10
         li $t1, 203
        beq $t1, $t2, thongbao10
         li $t1, 303
        beq $t1, $t2, thongbao10
        
        li $t1, 104
        beq $t1, $t2, thongbao11
         li $t1, 204
        beq $t1, $t2, thongbao11
         li $t1, 304
        beq $t1, $t2, thongbao11
        
        
        la $a0,TIME_1
        jal LeapYear
        beq $v0,$0,thongbao12
        j thongbao7
	
        
thongbao1:
	li $v0, 4
	li $v1, 8
	j Ketthucham8
thongbao2:
	li $v0, 8
	li $v1,12
	j Ketthucham8

thongbao3:

	sub $t2, $t0, 4
	move $v0,$t2
	
	add $t2, $t0, 8
	move $v1,$t2
	j Ketthucham8

thongbao4:

	sub $t2, $t0, 1	
	move $v0,$t2
	
	sub $t2, $t0, 5
	move $v1,$t2
	
	j Ketthucham8
thongbao5:

	sub $t2, $t0, 2
	move $v0,$t2
	
	add $t2, $t0, 6
	move $v1,$t2

	j Ketthucham8
thongbao6:

	sub $t2, $t0, 3
	move $v0,$t2

	add $t2, $t0, 5
	move $v1,$t2

	j Ketthucham8
thongbao7:

	sub $t2, $t0, 4
	move $v0,$t2

	add $t2, $t0, 4
	move $v1,$t2

	j Ketthucham8
thongbao8:

	sub $t2, $t0, 5
	move $v0,$t2

	add $t2, $t0, 3
	move $v1,$t2

	j Ketthucham8
thongbao9:

	sub $t2, $t0, 6
	move $v0,$t2

	add $t2, $t0, 2
	move $v1,$t2

j Ketthucham8
thongbao10:

	add $t2, $t0, 1
	move $v0,$t2

	add $t2, $t0, 5
	move $v1,$t2

	j Ketthucham8
thongbao11:

	sub $t2, $t0, 8
	move $v0,$t2

	add $t2, $t0, 4
	move $v1,$t2

	j Ketthucham8
thongbao12:
	li $t1, 4
	div $t0,$t1
	mflo $t2
	mul $t3,$t2, $t1


	move $v0,$t3

	add $t2, $t2 , 1
	mul $t3,$t2, $t1
	move $v1,$t3

	j Ketthucham8

Ketthucham8:
        lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	
	addi $sp,$sp,20
	jr $ra
RestoreSTR:
	addi $sp,$sp,-4
	sw $ra,($sp)
	
	sb $0,($a0)

	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
