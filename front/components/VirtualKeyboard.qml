import QtQuick
import QtQuick.VirtualKeyboard

Item {
    id: item
    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: item.height
        width: item.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: item.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
