//
//  InfoViewController.swift
//  MyHabits
//
//  Created by 1234 on 13.04.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Информация"
        view.backgroundColor = .white
        layout()
    }

    private func layout() {
        let infoView = InfoView()
        infoView.translatesAutoresizingMaskIntoConstraints = false

        [infoView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
