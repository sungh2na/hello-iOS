//
//  PlayerViewController.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/01/12.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var playControlButton: UIButton!
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalDurationLabel: UILabel!
    
    //TODO: SimplePlayer 만들고 프로퍼티 추가
    let simplePlayer = SimplePlayer.shared
    
    var timeObserver: Any?
    var isSeeking: Bool = false
    
    override func viewDidLoad() {       // 메모리에 로드 됐을 때 호출
        super.viewDidLoad()
        
        updatePlayButton()
        updateTime(time: CMTime.zero)
        // TODO: TimeObserver 구현
    }
    
    override func viewWillAppear(_ animated: Bool) {    // 보이기 직전에 호출
        super.viewWillAppear(animated)
        updateTintColor()
        updateTrackInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) { // 사라지기 직전에 호출
        super.viewWillDisappear(animated)
        // TODO: 뷰나갈때 처리 > 심플플레이어
        
    }
    
    @IBAction func beginDrag(_ sender: UISlider) {
        isSeeking = true
    }
    
    @IBAction func endDrag(_ sender: UISlider) {
        isSeeking = false
    }
    
    @IBAction func seek(_ sender: UISlider) {
        // TODO: 시킹 구현
    }
    
    @IBAction func togglePlayButton(_ sender: UIButton) {
        // TODO: 플레이버튼 토글 구현
        if simplePlayer.isPlaying {
            simplePlayer.pause()
        } else {
            simplePlayer.play()
        }
        updatePlayButton()
    }
}

extension PlayerViewController {
    func updateTrackInfo() {
        // TODO: 트랙 정보 업데이트
        guard let track = simplePlayer.currentItem?.convertToTrack() else { return }
        thumbnailImageView.image = track.artwork
        titleLabel.text = track.title
        artistLabel.text = track.artist
        
    }
    
    func updateTintColor() {
        playControlButton.tintColor = DefaultStyle.Colors.tint
        timeSlider.tintColor = DefaultStyle.Colors.tint
    }
    
    func updateTime(time: CMTime) {
        // print(time.seconds)
        // currentTime label, totalduration label, slider
        
        // TODO: 시간정보 업데이트, 심플플레이어 이용해서 수정
        currentTimeLabel.text = secondsToString(sec: 0.0)   // 3.1234 >> 00:03
        totalDurationLabel.text = secondsToString(sec: 0.0)  // 39.2045  >> 00:39
        
        if isSeeking == false {
            // 노래 들으면서 시킹하면, 자꾸 슬라이더가 업데이트 됨, 따라서 시킹아닐때마 슬라이더 업데이트하자
            // TODO: 슬라이더 정보 업데이트
            
        }
    }
    
    func secondsToString(sec: Double) -> String {
        guard sec.isNaN == false else { return "00:00" }
        let totalSeconds = Int(sec)
        let min = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", min, seconds)
    }
    
    func updatePlayButton() {
        // TODO: 플레이버튼 업데이트 UI작업 > 재생/멈춤
        if simplePlayer.isPlaying {    // 플레이 중일 때는 정지아이콘 상태
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            playControlButton.setImage(image, for: .normal)
        } else {                       // 정지 중일 때는 플레이아이콘 상태
            let configuration = UIImage.SymbolConfiguration(pointSize: 40)
            let image = UIImage(systemName: "play.fill", withConfiguration: configuration)
            playControlButton.setImage(image, for: .normal)
            
        }
    }
}
