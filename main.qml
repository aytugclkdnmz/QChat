import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("QChat")

    Connections {
        target: server
        function onNewMessage(ba) {
            listModelMessages.append(
                        {message: ba + ""})
        }
    }
    ColumnLayout{
        anchors.fill: parent
        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: ListModel {
                id: listModelMessages
                ListElement {
                    message: "Welcome to QChat"
                }
            }
            delegate: ItemDelegate {
            text: message

            }
            ScrollBar.vertical: ScrollBar{}
        }
        RowLayout {
            TextField {
                id : textFieldMessage
                placeholderText: qsTr("Your Message...")
                Layout.fillWidth: true
                onAccepted: buttonSend.clicked()

                }
        }
        Button {
            id: buttonSend
            text: qsTr("Send")
            onClicked: {
                console.log("Send")
                server.sendMessage(textFieldMessage.text)
                textFieldMessage.clear()
            }

        }

    }
}
