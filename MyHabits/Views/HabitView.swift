//
//  SettingsHabitView.swift
//  Habits
//
//  Created by 1234 on 14.04.2022.
//

import UIKit

final class HabitView: UIView {

    var habit: Habit?
    var habitName = ""
    var habitTime = Date()

    var habitColor: UIColor {
        get {
            return colorSetButton.tintColor
        }
        set {
            colorSetButton.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
            colorSetButton.tintColor = newValue
            setNeedsDisplay()
        }
    }


    private lazy var nameTitleLabel = makeLabel(text: "НАЗВАНИЕ")
    private lazy var colorTitleLabel = makeLabel(text: "ЦВЕТ")
    private lazy var timeTitleLabel = makeLabel(text: "ВРЕМЯ")

    private lazy var nameTextField: UITextField = {

        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = UIColor(named: "\(CustomColors.lightBlue)")
        textField.delegate = self
        textField.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()
    
    let colorSetButton: UIButton = {

        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    let timeLabel: UILabel = {

        let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let datePicker: UIDatePicker = {

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.translatesAutoresizingMaskIntoConstraints = false

        return datePicker
    }()

    let deleteButton: UIButton = {

        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let selectedTime = dateToString(date: Date())
        setColorTextForTimeLabel(time: selectedTime)
        layout()
        addDeleteButton()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func nameTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            habitName = text
        }
    }

    @objc func dateChanged() {
        //get date from datePicker
        habitTime = datePicker.date
        let selectedTime = dateToString(date: datePicker.date)
        setColorTextForTimeLabel(time: selectedTime)
    }

    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private func setColorTextForTimeLabel(time: String) {
        //setting the text in the label
        let mainString = "Каждый день в \(time)"
        let stringToColor = "\(time)"
        let colorOfTime = UIColor(named: "\(CustomColors.purple)") ?? UIColor.purple

        //setting a different color for time
        let range = (mainString as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: colorOfTime, range: range)
        timeLabel.text = mainString
        timeLabel.attributedText = mutableAttributedString
    }

    func setView() {
        if let habit = habit {
            nameTextField.text = habit.name
            habitName = habit.name
            habitColor = habit.color
            habitTime = habit.date
            let saveTime = dateToString(date: habit.date)
            setColorTextForTimeLabel(time: saveTime)
            datePicker.setDate(habit.date, animated: true)
            addDeleteButton()
        } else {
            deleteButton.removeFromSuperview()
        }
    }

    private func addDeleteButton() {
        [deleteButton].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
    }

    private func layout() {
        
        let spaceInterval: CGFloat = 20
        let smallSpaceInterval: CGFloat = 8
        
        [nameTitleLabel, nameTextField, colorTitleLabel, colorSetButton, timeTitleLabel, datePicker, timeLabel].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
        
            nameTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            nameTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            nameTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),

            nameTextField.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: smallSpaceInterval),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),

            colorTitleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: spaceInterval),
            colorTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            colorTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),

            colorSetButton.topAnchor.constraint(equalTo: colorTitleLabel.bottomAnchor, constant: smallSpaceInterval),
            colorSetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            colorSetButton.widthAnchor.constraint(equalToConstant: 30),
            colorSetButton.heightAnchor.constraint(equalTo: colorSetButton.widthAnchor),
            
            timeTitleLabel.topAnchor.constraint(equalTo: colorSetButton.bottomAnchor, constant: spaceInterval),
            timeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            timeTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),

            timeLabel.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: smallSpaceInterval),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),

            datePicker.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: smallSpaceInterval),
            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

    }
}

//MARK: - UITextFieldDelegate
extension HabitView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
}
