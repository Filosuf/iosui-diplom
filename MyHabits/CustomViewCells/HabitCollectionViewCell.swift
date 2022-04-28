//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by 1234 on 16.04.2022.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {

    weak var delegate: HabitCollectionViewCellDelegate?

    var habit: Habit?


    let titleLabel: UILabel = {

        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let timeLabel: UILabel = {

        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let counterLabel: UILabel = {

        let label = UILabel()
        label.text = "Счётчик: 30"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()


    let checkmarkButton: UIButton = {

        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = UIColor(named: "\(CustomColors.purple)")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkmarkButtonPressed), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func checkmarkButtonPressed() {
        guard let habit = habit else {
            return
        }
        delegate?.checkmarkButtonPressed()
        if habit.isAlreadyTakenToday == false {
            HabitsStore.shared.track(habit)
            checkmarkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }

    func setupCell(habit: Habit?) {
        guard let habit = habit else {
            return
        }
        self.habit = habit
        titleLabel.text = habit.name
        titleLabel.textColor = habit.color
        timeLabel.text = habit.dateString
        counterLabel.text = "Счётчик: \(habit.trackDates.count)"
        checkmarkButton.tintColor = habit.color
        if habit.isAlreadyTakenToday {
           checkmarkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            checkmarkButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }

    }

    private func layout() {

        let spaceInterval: CGFloat = 12
        let smallSpaceInterval: CGFloat = 7

        [titleLabel, timeLabel, counterLabel, checkmarkButton].forEach { contentView.addSubview($0) }

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -103),

            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: smallSpaceInterval),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),

            counterLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spaceInterval),
            counterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),

            checkmarkButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 36),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 36)
        ])

    }
}
