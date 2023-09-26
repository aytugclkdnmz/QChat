import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Chat Client App")

    Connections {
        target: client
        function onNewMessage(ba) {
            listModelMessages.append(
                        {message: ba + ""})
        }
    }

    ColumnLayout{
        anchors.fill: parent
        RowLayout {
            TextField {
                id : textFieldIP
                placeholderText: qsTr("Server IP")
                Layout.fillWidth: true
                onAccepted: buttonConnect.clicked()

                }
            TextField {
                id : textFieldPort
                placeholderText: qsTr("Server port")
                Layout.fillWidth: true
                onAccepted: buttonConnect.clicked()

                }

        Button {
            id: buttonConnect
            text: qsTr("Conenct")
            onClicked:  client.conenctToServer(textFieldIP.text, textFieldPort.text)

            }
         }
        ListView {
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            model: ListModel {
                id: listModelMessages
                ListElement {
                    message: "Welcome to Cient"
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
                client.sendMessage(textFieldMessage.text)
                textFieldMessage.clear()
            }

        }

    }
}
