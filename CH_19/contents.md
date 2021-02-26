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
- 어떤 모델을 만들고 싶은지
    - Object Detector - 이미지 안에 물체 디텍터
    - Sound Classifier
    - Activity Classifier
    - Text Classifier
    - Word tagger
    - Tabular Regressor
    - Tabular Classifier
    - Recommender
- mlproj 파일 생성됨
- 학습시키고자 하는 트레이닝 데이터, 검증할 테스트 데이터 필요
- Training Data - select files
    - Pets - 100 안에 Cat 폴더, Dog 폴더 (각각이 Class가 됨)
- Testing Data - select files
    - Pets - Testing
- Validation Data - Auto 설정
- Precision, Recall 둘다 높으면 좋음


## 머신러닝 모델 정확도 높이기
- 어떻게하면 더 정확한 모델을 만들 수 있을까
    - Training data 늘리기 -> 100개에서 1000개로 늘려봄
    - Maximum Iterations 반복 학습하기 -> 25에서 40으로 늘려봄 -> 정확도가 떨어질 수도 있음
- Agument Date 같은 문제를 다각화로 고민
    - https://developer.apple.com/documentation/createml/improving_your_model_s_accuracy
    - 이미지 augmentation ( 자르거나 돌리거나 흐리게 등등)
    -> Add Noise, Crop, Rotate 적용
- core ml wwdc 2019

## 앱에 내가 만든 모델 적용하기
- Precision, Recall
    - Precision -> 머신러닝 모델이 예상한것 것중에 실제 정답의 비율
    - Recall -> 전체 정답 중에 맞힌 것이 몇개인지 비율,
        - 머신러닝 모델이 전부 개라고 예측하면 Recall은 올라감, Precision은 떨어짐
    - roc curve 그래프 안에 영역이 높으면 정확도가 높음
- 적은 데이터로 높은 정확도가 나오는 모델을 선택 -> Training data 100, Testing data 200 선택 
- output을 저장해서 앱에서 ml모델 바로 사용 가능
