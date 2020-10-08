import Foundation
import UIKit


// MARK: - SwitchTableViewCell
//
class SwitchTableViewCell: UITableViewCell {

    /// Accessory View
    ///
    private(set) lazy var switchControl = UISwitch()

    /// Accessibility Hint to be applied over the control, whenever it's On
    ///
    var enabledAccessibilityHint: String?

    /// Accessibility Hint to be applied over the control, whenever it's Off
    ///
    var disabledAccessibilityHint: String?

    /// Indicates if the switch is On / Off
    ///
    var isOn: Bool {
        get {
            switchControl.isOn
        }
        set {
            switchControl.isOn = newValue
            switchControl.accessibilityHint = newValue ? enabledAccessibilityHint : disabledAccessibilityHint
        }
    }

    /// Listener: Receives the new State
    ///
    var onChange: ((UISwitch) -> Void)?


    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGestureRecognizer()
        setupSwitchControl()
        setupTableViewCell()
        refreshStyles()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


// MARK: - Private API(s)
//
private extension SwitchTableViewCell {

    func setupGestureRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(contentWasPressed))
        addGestureRecognizer(recognizer)
    }

    func setupSwitchControl() {
        switchControl.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
    }

    func setupTableViewCell() {
        accessoryView = switchControl
        selectionStyle = .none
    }

    func refreshStyles() {
        backgroundColor = .simplenoteTableViewCellBackgroundColor
        selectedBackgroundView?.backgroundColor = .simplenoteLightBlueColor
        switchControl.onTintColor = .simplenoteSwitchOnTintColor
        switchControl.tintColor = .simplenoteSwitchTintColor
        textLabel?.textColor = .simplenoteTextColor
    }
}


// MARK: - Action Handlers
//
extension SwitchTableViewCell {

    @IBAction
    func contentWasPressed() {
        let nextState = !switchControl.isOn
        switchControl.setOn(nextState, animated: true)
        notifyStateDidChange()
    }

    @IBAction
    func switchDidChange() {
        notifyStateDidChange()
    }

    private func notifyStateDidChange() {
        onChange?(switchControl)
    }
}
