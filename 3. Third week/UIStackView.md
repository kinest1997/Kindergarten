# StackView

## 뭔가?
- 오토레이아웃없이 자동적으로 components 를 재조정하여 적당하게 배치시켜주는 친구

## property

### `axis`
- 구성요소들을 수직으로 할지, 수평으로 할지 정해준다

### `alignment`
- subView 들을 어떤식으로 정렬할건지 결정
 - fill: 빈공간이 있으면 그냥 쭉 늘려서 채운다
 - leading, trailing: vertical 의 경우 왼쪽 또는 오른쪽 끝에 시작선을 다 맞춘다
 - top, bottom: horizontal 의 경우 위쪽 또는 아래쪽에 시작전을 다 맞춘다
 - first, last Baseline: horizontal 일때만 사용 가능하며 subview 들의 first, last Baseline 을 전부 일치하게 해준다
 - center: subview 들의 중심을 전부 맞추는것


### `distribution`
- 들어가는 뷰들을 어떻게 분배할지 정하는것
 - fill: subView 를 priority 에 따라 크기를 재조정한다.
 - fillEqually: 전부 같은 크기로 넣는다
 - fill proportionally: subview 들이 가지고있던 크기에 맞춰 비례하여 사이즈를 재조정해서 넣는다
 - equal spacing: 전부 같은 간격을가지도록 한다 
 - equal centering: subview 들의 중심이 전부 같은 간격을 가지도록 한다.

### `spacing`
- stackView 안에 들어가는 뷰들의 간격을 조정하는 속성