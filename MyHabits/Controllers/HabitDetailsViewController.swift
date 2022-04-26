//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by 1234 on 18.04.2022.
//

import UIKit

class HabitDetailsViewController: UIViewController {

    var habit: Habit?

    lazy var checkDateTableView: UITableView = {

        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setBar()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = habit?.name ?? "Название привычки"
    }

    private func setBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        navigationController?.navigationBar.tintColor = UIColor(named: "\(CustomColors.purple)")
    }

    @objc private func editHabit() {
        let vc = HabitViewController()
        vc.habit = habit
        let navVC = UINavigationController(rootViewController: HabitsViewController())
        navVC.setViewControllers([HabitsViewController(), HabitDetailsViewController(), vc], animated: true)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

    private func layout() {
        [checkDateTableView].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            checkDateTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            checkDateTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkDateTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkDateTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore.shared.dates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let habit = habit else {
            return UITableViewCell()
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content = cell.defaultContentConfiguration()
        let dateArray = HabitsStore.shared.dates
        let dateIndex = dateArray.count - 1 - indexPath.item
        content.text = HabitsStore.shared.trackDateString(forIndex: dateIndex)
        if HabitsStore.shared.habit(habit, isTrackedIn: dateArray[dateIndex]) {
            cell.accessoryType = .checkmark
            cell.tintColor = UIColor(named: "\(CustomColors.purple)")
        }
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HabitDetailsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Активность"
    }
}

