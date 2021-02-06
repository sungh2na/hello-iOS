# 19. CoreML 개와 강아지 분류기

## 머싱러닝앱 - CoreML
- 애플에서 제공해주는 머신러닝 프레임워크
- 인공지능
- 딥러닝이 ML시대를 활짝 열어줌
- 응용 분야가 넓음
    - 상품 추천
    - 자율 주행
    - 병 진단
- 넓은 범위에서 뛰어난 성능을 보여주고 있음 -> 사용자 가치 (앱을 통해서)
- 앱내에서 ML의 적용이 시급
- 머신러닝 모델에 ios 앱 적용하게 해줌
    - 이미지 분석
    - 자연어 처리 
    - 오디오 분석

<image src="1.png" >

- 머신러닝 엔지니어가 Data수집, ML모델 생성, 모바일 용으로 변환
- 앱 개발자는 만들어진 CoreML model을 앱 내에 적용
- 머신러닝 엔지니어가 해야할 부분도 할 수 있게됨
- 구글 Teachable Machine
    1. Gather
    2. train
    3. Export
    - Image, Sounds, Poses
- 애플 CreateML

<image src="2.png" >

<image src="3.png" >

    - 문제를 정의
    - 데이터 모아서
    - 트레이닝
    - 모델평가 
    - Export 해서 씀
    - Images, Text, , Tabular Data
    
<image src="4.png" >

    - 워크플로우가 이렇게 단순화 됨
    - 이것을 통해 개와 고양이를 분류하는 앱 만들기

## CreateML 실습 
- 머신러닝 모델 만들기
- Xcode - Open Developer tool - Create ML
- newDocument - Choose a Template - Image Classifier

## 머신러닝 모델 정확도
- 어떻게하면 더 정확한 모델을 만들 수 있을까
- Maximum Iterations 반복 학습하기
- Agument Date 같은 문제를 다각화로 고민

## 실제로 더 정확한 모델 만들기
- 트레이닝 데이터 많이 (1000개)
- 강아지 고양이 500개씩
- iteration 40번 - 오버피팅? 여지가 있음
- Precision, Recall 둘다 높게 나오면 좋음
- https://developer.apple.com/documentation/createml/improving_your_model_s_accuracy
    - 이미지 augmentation ( 자르거나 돌리거나 흐리게 등등)
- core ml wwdc 2019

## 앱에 내가 만든
