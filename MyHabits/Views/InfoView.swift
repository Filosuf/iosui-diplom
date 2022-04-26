//
//  InfoView.swift
//  MyHabits
//
//  Created by 1234 on 13.04.2022.
//

import UIKit

class InfoView: UIView {

    private let infoTextView: UITextView = {

        let textView = UITextView()
        textView.textColor = .black
        textView.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textView.translatesAutoresizingMaskIntoConstraints = false

        let largeTextString = "Привычка за 21 день"
        let smallTextString = "Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму: \n\n1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага. \n\n2. Выдержать 2 дня в прежнем состоянии самоконтроля. \n\n3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,с чем еще предстоит серьезно бороться. \n\n4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств. \n\n5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой. \n\n6. На 90-й день соблюдения техники все лишнее из \"прошлой жизни\" перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся. \n\nИсточник: psychbook.ru"

        let textString = "\n\(largeTextString)\n\n\(smallTextString)"
        let attrText = NSMutableAttributedString(string: textString)

        let largeFont = UIFont(name: "Arial-BoldMT", size: 20.0)!
        let smallFont = UIFont(name: "Arial", size: 17.0)!

        //  Convert textString to NSString because attrText.addAttribute takes an NSRange.
        let largeTextRange = (textString as NSString).range(of: largeTextString)
        let smallTextRange = (textString as NSString).range(of: smallTextString)

        attrText.addAttribute(NSAttributedString.Key.font, value: largeFont, range: largeTextRange)
        attrText.addAttribute(NSAttributedString.Key.font, value: smallFont, range: smallTextRange)

        textView.attributedText = attrText
        textView.scrollRangeToVisible(NSMakeRange(0, 0))

        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func layout() {

        let spaceInterval: CGFloat = 16

        [infoTextView].forEach { self.addSubview($0) }

        NSLayoutConstraint.activate([
            infoTextView.topAnchor.constraint(equalTo: topAnchor, constant: spaceInterval),
            infoTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spaceInterval),
            infoTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spaceInterval),
            infoTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -spaceInterval)
        ])
    }

}
