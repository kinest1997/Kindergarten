# 가끔식 쳐다볼것




## TableView

## 여러가지 사용법들
- cell안에 버튼이 있고 해당 버튼에 addaction, addtarget 을 해줬을때, 반드시 다른셀에서 그 action, target을 remove메소드로 없애줘야한다. 셀을 재사용하기때문에 중복적으로 추가되어 마구잡이로 실행될수있음.

- 