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

## 어떤모델을 쓸까? 정밀도와 재현율은 뭘까?
- Precision, Recall
    - Precision -> 머신러닝 모델이 예상한것 것중에 실제 정답의 비율
    - Recall -> 전체 정답 중에 맞힌 것이 몇개인지 비율,
        - 머신러닝 모델이 전부 개라고 예측하면 Recall은 올라감, Precision은 떨어짐
    - roc curve 그래프 안에 영역이 높으면 정확도가 높음
- 적은 데이터로 높은 정확도가 나오는 모델을 선택 -> Training data 100, Testing data 200 선택 
- output을 저장해서 앱에서 ml모델 바로 사용 가능

## 앱에 내가 만든 머신러닝 모델 적용하기
- vision+ml example apple
- 원래 있던 모델말고 위에서 만든 모델 넣어서 잘 작동하는지 확인
```Swift
    let model = try VNCoreMLModel(for: DogCatClassifier().model)
```
- iOS Deployment Targer 12.0 이상으로 수정
- 시뮬레이터 photos에 Pets-Practice 사진 드래그해서 넣기
- 코드 보기
    - 모델에 접근할 수 있는 객체로 만들어 줘야 함
    - imageClassifier는 Vision의 도움을 받음
    - VNCoreMLModel 비전코어엠엘모델로 바꿔줌

    ```Swift
    import Vision
    let model = try VNCoreMLModel(for: DogCatClassifier().model)
    ```

    - 이 모델을 통해서 사진 찍은 것, 사진 불러온 것 등을 요청해야함 -> request를 만듦
    - 이 객체를 이용해서 실제롬 머신러닝모델의 예측 결과를 받아올 수 있음
    - request 보내지고나서 그 것의 핸들러 받아서 처리해줌 

    ```Swift
        let model = try VNCoreMLModel(for: DogCatClassifier().model)
            
        let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
            self?.processClassifications(for: request, error: error)
        })
    ```

    - 이미지 리퀘스트 보낼 때 돌아가거나 더 크거나 비율 다르면 안되니까 오리엔테이션을 잘 맞춰줘야함
    - centerCrop, scaleFit, scaleFill 등
    - centerCrop 많이 사용함
    
    ```Swift
        request.imageCropAndScaleOption = .centerCrop
    ```

    - 결과물이 있는 부분
    - 클래스 2개 (개, 고양이)만 뽑아와서 그거에 대한 결과물 가져와서 description
        - classification.identifier 는 클래스의 이름 
        - 그게 얼마나 확실한지 classification.confidence
    - 그 description가지고 레이블 업데이트

    ```Swift
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.classificationLabel.text = "Unable to classify image.\n\(error!.localizedDescription)"
                return
            }
            // The `results` will always be `VNClassificationObservation`s, as specified by the Core ML model in this project.

            let classifications = results as! [VNClassificationObservation]

            if classifications.isEmpty {
                self.classificationLabel.text = "Nothing recognized."
            } else {
                // Display top classifications ranked by confidence in the UI.

                let topClassifications = classifications.prefix(2)
                let descriptions = topClassifications.map { classification in
                    // Formats the classification for display; e.g. "(0.37) cliff, drop, drop-off".

                   return String(format: "  (%.2f) %@", classification.confidence, classification.identifier)
                }
                self.classificationLabel.text = "Classification:\n" + descriptions.joined(separator: "\n")
            }
        }
    }

    ```

    - 모델에 요청하는 시점(사진을 누를 때) 불리는 함수
    - 선택된 이미지를 가지고 리퀘스트를 하기 위해서는 그 리퀘스트를 실행하기 위해서는 ImageRequestHandler 이용해서 수행

    ```Swift
    /// - Tag: PerformRequests

    func updateClassifications(for image: UIImage) {
        classificationLabel.text = "Classifying..."
        
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                /*
                 This handler catches general image processing errors. The `classificationRequest`'s
                 completion handler `processClassifications(_:error:)` catches errors specific
                 to processing that request.
                 */
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    ```
    
- https://apple.github.io/turicreate/docs/api/
    - 애플에서 제공해주는 파이썬 기반의 머신러닝 프레임워크
- https://www.tensorflow.org/swift/guide/overview
- https://pytorch.org/mobile/ios/
