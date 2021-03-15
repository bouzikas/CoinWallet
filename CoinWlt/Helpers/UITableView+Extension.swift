//
//  UITableView+Extension.swift
//  CoinWlt
//
//  Created by Dimitris Bouzikas on 14/3/21.
//

import UIKit
import Lottie

extension UITableView {
    func setEmptyView(message: String, doRepeat: Bool = true) {
        let animationView = AnimationView()
        
        let frame = CGRect(
            x: self.center.x,
            y: self.center.y,
            width: self.bounds.size.width,
            height: self.bounds.size.height
        )
        let emptyView = UIView(frame: frame)
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        add(
            view: animationView,
            toView: emptyView,
            fromFile: Constants.Animations.emptyResults
        )
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        messageLabel.textColor = UIColor.label
        messageLabel.font = .systemFont(ofSize: 13)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: 60).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20).isActive = true
        messageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 60).isActive = true
        
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
        
        animationView.play(
            fromProgress: 0,
            toProgress: 1,
            loopMode: doRepeat ? LottieLoopMode.loop : LottieLoopMode.playOnce,
            completion: nil
        )
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func add(view: AnimationView, toView wrapperView: UIView, fromFile file: String) {
        let animation = Animation.named(file, bundle: Bundle.main)
        
        view.animation = animation
        view.contentMode = .scaleAspectFit
        wrapperView.addSubview(view)

        view.backgroundBehavior = .pauseAndRestore
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor).isActive = true
        view.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor, constant: 10).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
    }
}

