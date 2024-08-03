import UIKit

class ViewController: UIViewController {
    // UI Elements
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your pin"
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view
        setupView()
        
        // Set up constraints
        setupConstraints()
        
        // Add button action
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // Button tap action
    @objc private func buttonTapped() {
        showAlert(
            title: checkPin(text: textField.text ?? "") ? "Guessed!" : "Retry!"
        )
    }
    
    // Show alert
   
}

private extension ViewController {
    // Set up the view
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(textField)
        view.addSubview(button)
    }
    
    // Set up constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Text field constraints
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Button constraints
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func showAlert(title: String) {
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func checkPin(text: String) -> Bool {
        text == "1234"
    }
}
