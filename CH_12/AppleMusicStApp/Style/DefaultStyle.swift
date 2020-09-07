//
//  DefaultStyle.swift
//  AppleMusicStApp
//
//  Created by joonwon lee on 2020/03/15.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

public enum DefaultStyle {
    public enum Colors {
        public static let tint: UIColor = {
            if #available(iOS 13.0, *) {                    // ios13 이후부터 다크모드 제공
                return UIColor { traitCollction in          // traitCollection을 통해 다크모드인지 아닌지 알 수 있음
                    if traitCollction.userInterfaceStyle == .dark {     // 다크모드이면 흰색, 아니면 검정색
                        return .white
                    } else {
                        return .black
                    }
                }
            } else {
                return .black
            }
        }()
    }
}
