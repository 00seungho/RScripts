pkg=install.packages()
pkg
.libPaths()
data(package="datasets")
#직사각형 구하는 함수 정의
getRecatangleArea = function(w,h){
  area = w*h
  return(area)
}

getRecatangleArea(1,2)

getSum = function(number){
  sum = 0
  for (item in number){
    sum = sum+item
    return(sum)
  }
}

# 3장 데이터구조
# 벡터는 선형으로 한개 이상의 숫자 또는 문자열 저장
# 인덱스는 1부터 시작
# 여러개의 데이터를 저장할 때 c() 함수 사용

score = 80
score

score = c(95,78,92)
score

score[2] = 88
score[4] = 100
score

name=c("장발장","코제트","자베르")
name

#연속적인 값들을 벡터에 저장
x1=seq(1,100,by=10)
x1

#1씩 증가하는 값 저장
x2=1:10
seq(1,10,by=1)
x2

#1씩 감소하는 값 저장
x3=10:1
seq(10, 1, by=-1)

#저장되는 값의 길이를 지정해서 동일하게 분배된 값을 저장
s4=seq(0,10,length.out=5)

#반복함수 (repeat) 함수 : rep(), times, each 속성
x5=c(1,2,3)
y1=rep(x5, times=3)
y1

x6=c(1,2,3)
y2=rep(x6, each=3)
y2

#연산자

#산술 연산자
#거듭제곱 연산자
10^3

a=5
b=5
a^b

r1 = a^b
r1

x=c(10,20,30,40)
y=c(1,6,11,16)
w=c(100,200)
# 벡터 계수가 다를 때는 개수가 작은 쪽의 인덱스를 반복해서 연산한다.
x+5
x+y
x+w


#비교연산자: 비교연산의 결과는 논리값 TRUE, FALSE로 결과가 나타남

a=7
b=10
a>b

x=c(10,20,30)
x <= 10

#벡터에 있는 요소의 값들중에 하나라도 비교연산 결과에 true가 있으면 결과는 true
any(x<=10)
#벡터에 있는 요소의 값들이 비교연산 결과에 true가 되야 결과는 true
all(x<=10)

#벡터에서 20이상인 요쇼를 반환한다.
x[x>=20]

# 논리연산자: 논리값 TRUE, FALSE로 결과를 반환
x=c(TRUE,TRUE,FALSE,FALSE)
y=c(TRUE,FALSE,TRUE,FALSE)

x|y
x&y
xor(x,y)

!x

#NA(Not Avilable(결측치):누락된경우)
#NULL(변수를 선언하고 초기화 하지 않았을 때)
#Inf(infinity:0이 아닌 숫자를 0으로 나누었을 때)
#NaN(Not a number)

z= NULL
z
is.null(z)

k
is.null(k)

y=c(1,2,3,NA,5)
y

z = 5/0
z

t=0/0
t

#요인(factor)
#백터에 저장된 동일한 값들을 요인으로 찾아내서 대표값들을 분류해서 

gender = c("여","남","남","여","여","남")
gender

gender.factor = factor(gender)
gender.factor
