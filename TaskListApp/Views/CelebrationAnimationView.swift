//
//  CelebrationAnimationView.swift
//  TaskListApp
//
//  Created by abdullah on 3.06.2024.
//

import UIKit
import Lottie



class CelebrationAnimationView: UIView {
    
    var animationView: LottieAnimationView!
    
    
    init(fileName: String) {
        self.animationView = LottieAnimationView(animation: LottieAnimation.named(fileName))
        super.init(frame: .zero)
        setupView()
    }
    
    func setupView() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFill
        addSubview(animationView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.topAnchor.constraint(equalTo: topAnchor),
            animationView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    func play(completion: @escaping (Bool)->()) {
        animationView.play(completion: completion)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







