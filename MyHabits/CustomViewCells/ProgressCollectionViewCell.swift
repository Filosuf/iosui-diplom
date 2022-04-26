//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by 1234 on 15.04.2022.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {

    let spaceInterval: CGFloat = 12
    let progressBarHeight: CGFloat = 7
    lazy var progressWidthConstraint = progressImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - spaceInterval * 2) * CGFloat(HabitsStore.shared.todayProgress))

    let titleLabel: UILabel = {

        let label = UILabel()
        label.text = "Всё получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let percentLabel: UILabel = {

        let label = UILabel()
//        label.text = "\(Int(progress * 100))%"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let blankImage: UIImageView = {

        let image = UIImageView()
        image.backgroundColor = .systemGray2
        image.layer.cornerRadius = 7 / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    let progressImage: UIImageView = {

        let image = UIImageView()
        image.backgroundColor = UIColor(named: "\(CustomColors.purple)")
        image.layer.cornerRadius = 7 / 2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

//   lazy var progressWidthConstraint = progressImage.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - spaceInterval * 2) * CGFloat(HabitsStore.shared.todayProgress))

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell() {
        let progress = HabitsStore.shared.todayProgress
        percentLabel.text = "\(Int(progress * 100))%"
        progressWidthConstraint.constant = (bounds.width - spaceInterval * 2) * CGFloat(progress)
    }

    private func layout() {

        [titleLabel, percentLabel, blankImage, progressImage].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),

            percentLabel.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            percentLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            percentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),

            blankImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: spaceInterval),
            blankImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            blankImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),
            blankImage.heightAnchor.constraint(equalToConstant: progressBarHeight),

            progressImage.topAnchor.constraint(equalTo: blankImage.topAnchor),
            progressImage.leadingAnchor.constraint(equalTo: blankImage.leadingAnchor),
            progressWidthConstraint,
            progressImage.heightAnchor.constraint(equalToConstant: progressBarHeight)
        ])

    }
}
