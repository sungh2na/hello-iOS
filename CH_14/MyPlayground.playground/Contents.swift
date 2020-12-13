import UIKit

// Queue - Main, Global, Custom

// - Main
DispatchQueue.main.async {
    // UI update, user interaction
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

// - Global
DispatchQueue.global(qos: .userInteractive).async {
    //  진짜 중요한 것, 지금 당장 해야 하는 것
}

DispatchQueue.global(qos: .userInitiated).async {
    //  거의 바로 해줘야 함, 사용자가 결과를 기다린다
}

DispatchQueue.global(qos: .default).async {
    // 이건 굳이?, 우선순위 신경 안쓰겠다
}

DispatchQueue.global(qos: .utility).async {
    // 시간이 좀 걸리는 일들, 사용자가 당장 기다리지 않는 것, 네트워킹, 큰 파일 불러올 때
}

DispatchQueue.global(qos: .background).async {
    // 사용자한테 당장 인식될 필요가 없는 것들, 뉴스데이터 미리 받기, 위치 업데이트, 영상 다운로드, 페이스북 뉴스피드 등
}

// - Custom Queue , 덜 중요함
let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)
let serialQueue = DispatchQueue(label: "serial", qos: .background)

// 복합적인 상황

func downloadImageFromServer() -> UIImage {
    // Heavy Task
    return UIImage()
}

func updateUI(image: UIImage) {
    
}

DispatchQueue.global(qos: .background).async {
    let image = downloadImageFromServer()
    
    // global queue 에서 작업하면 warnning, crash 날 수 있음, 메인큐로 넘겨준다
    DispatchQueue.main.async {
        // update UI
        updateUI(image: image)
    }
}

// Sync, Async - sync 는 앞에 작업 끝나기 전에 뒤에 작업 안들어옴, async는 들어옴

// 덜 중요하고 앞에 작업 끝나기 전에 뒤에 작업 들어 올 수 있음
//DispatchQueue.global(qos: .background).async {
//    for i in 0...5 {
//        print("😈 \(i)")
//    }
//}
//
//// 중요한 작업이고 작업 끝나기 전에 뒤에 작업 들어 올 수 있음, 속도 더 빠름
//DispatchQueue.global(qos: .userInteractive).async {
//    for i in 0...5 {
//        print("😥 \(i)")
//    }
//}

// 덜 중요한 일이지만 먼저 마무리 되고 다음 작업
DispatchQueue.global(qos: .background).sync {
    for i in 0...5 {
        print("😈 \(i)")
    }
}

// 동시성 제공해 주기 위해서 async를 주로 씀, 인과관계 중요할 경우에만 sync
DispatchQueue.global(qos: .userInteractive).async {
    for i in 0...5 {
        print("😥 \(i)")
    }
}
