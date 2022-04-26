//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by 1234 on 13.04.2022.
//
import UIKit

class HabitsViewController: UIViewController {

    private var habitsArray = HabitsStore.shared.habits

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сегодня"
        view.backgroundColor = .white
        setBar()
        layout()
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitsArray = HabitsStore.shared.habits
        collectionView.reloadData()
    }
    
    private func setBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "\(CustomColors.purple)")
    }

    @objc private func addHabit() {
        let navVC = UINavigationController(rootViewController: HabitViewController())
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }

    private func layout() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

// MARK: - UICollectionViewDataSource
extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        habitsArray.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            cell.setupCell()
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
        cell.setupCell(habit: habitsArray[indexPath.item - 1])
        cell.delegate = self
        return cell
    }



}

//MARK: - UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    private var sideInset: CGFloat { return 8}

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - sideInset * 2
        if indexPath.item == 0 {
            return CGSize(width: width, height: 60)
        }
        return CGSize(width: width, height: 130)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            let vc = HabitDetailsViewController()
            vc.habit = habitsArray[indexPath.item - 1]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: - HabitCollectionViewCellDelegate
extension HabitsViewController: HabitCollectionViewCellDelegate {
    func checkmarkButtonPressed() {
        collectionView.reloadData()
    }


}
