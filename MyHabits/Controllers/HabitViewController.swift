//
//  HabitViewController.swift
//  MyHabits
//
//  Created by 1234 on 13.04.2022.
//

import UIKit

class HabitViewController: UIViewController {

    let contentView = HabitView()
    var habit: Habit?

    override func viewDidLoad() {
        super.viewDidLoad()
        setBar()
        contentView.habit = habit
        layout()
        setView()
        contentView.setView()
        view.backgroundColor = .white
    }

    private func setBar() {
        title = (habit == nil) ? "Создать" : "Править"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelBarButton))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(named: "\(CustomColors.purple)")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveBarButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "\(CustomColors.purple)")
    }

    @objc private func cancelBarButton() {
        dismiss(animated: true)
    }

    @objc private func saveBarButton() {
        saveTheHabit()
        dismiss(animated: true)
    }

    private func saveTheHabit() {
        let store = HabitsStore.shared
        let newHabit = Habit(name: contentView.habitName, date: contentView.habitTime, color: contentView.habitColor)
        if let habit = habit {
            if let index = store.habits.firstIndex(of: habit) {
                let habitSave = store.habits[index]
                habitSave.name = newHabit.name
                habitSave.color = newHabit.color
                habitSave.date = newHabit.date
            }
        } else {
            store.habits.append(newHabit)
        }
    }

    private func setView() {
        contentView.colorSetButton.addTarget(self, action: #selector(colorSetButtonPressed), for: .touchUpInside)
        contentView.deleteButton.addTarget(self, action: #selector(deleteHabit), for: .touchUpInside)
    }

    @objc func deleteHabit() {
        if let habit = habit {
            presentDeleteAlert(habit: habit)
        }
    }

    @objc func colorSetButtonPressed() {
        let picker = UIColorPickerViewController()
        picker.delegate = self
        picker.selectedColor = contentView.habitColor
        present(picker, animated: true)
    }

    private func presentDeleteAlert(habit: Habit) {
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habit.name)?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive, handler: { _ in
            let store = HabitsStore.shared
            store.habits.removeAll(where: {$0 == habit})
            self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    private func layout() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        [contentView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

//MARK: - UIColorPickerViewControllerDelegate
extension HabitViewController: UIColorPickerViewControllerDelegate {

    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        contentView.habitColor = viewController.selectedColor
    }
}
