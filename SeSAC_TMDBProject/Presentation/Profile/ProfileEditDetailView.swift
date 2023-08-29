//
//  ProfileEditDetailView.swift
//  SeSAC_TMDBProject
//
//  Created by 박태현 on 2023/08/29.
//

import UIKit

final class ProfileEditDetailView: BaseView {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .gray
        label.text = style.description
        return label
    }()

    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16.0, weight: .regular)
        textField.text = text
        textField.placeholder = style.description
        textField.clearButtonMode = .always
        return textField
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    private let style: EditType
    private let text: String?

    init(editType: EditType, text: String?) {
        self.style = editType
        self.text = text
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configureLayout() {
        super.configureLayout()

        [
            descriptionLabel, inputTextField, separatorView
        ].forEach { addSubview($0) }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
        }
        separatorView.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(6)
            $0.height.equalTo(0.5)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
