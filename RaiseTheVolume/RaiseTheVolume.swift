//
//  RaiseTheVolume.swift
//  RaiseTheVolume
//
//  Created by Evan Lewis on 11/25/16.
//  Copyright © 2016 Evan Lewis. All rights reserved.
//

import UIKit
import MediaPlayer

public extension UIViewController {

    func enableTopVolumeControl() {
        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(notification:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        view.addSubview(volumeView())
    }

    func volumeView() -> MPVolumeView {
        let volumeFrame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: view.bounds.size.width, height: UIApplication.shared.statusBarFrame.height)
        let volumeView = MPVolumeView(frame: volumeFrame)

        volumeView.showsRouteButton = false
        volumeView.isUserInteractionEnabled = false
        volumeView.tag = 15507692
        volumeView.setMinimumVolumeSliderImage(UIImage(color: .black, size: CGSize(width: 5, height: 5)), for: .normal)
        volumeView.setMaximumVolumeSliderImage(UIImage(color: .clear, size: CGSize(width: 1, height: 1)), for: .normal)
        volumeView.setVolumeThumbImage(UIImage(color: .clear, size: CGSize(width: 1, height: 1)), for: .normal)

        return volumeView
    }

    func volumeChanged(notification: NSNotification) {
        print("Volume changed")

        if let _ = notification.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float {
            print("Volume view")
        }
    }
}

extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let imageRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(imageRect.size, false, 0.0)
        color.setFill()
        UIRectFill(imageRect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
