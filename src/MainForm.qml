import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Item {
    signal sendPressed(string name)
    signal runPressed(string name)
    signal stopPressed()
    signal ipChanged(string ip)
    signal addBlock(string type, string path)
//    signal loadModel()
//    signal saveModel(url path)

    property string modelName//: "untitled"

    function clearModel() {
        blockModel.clear()
    }

    Dialog {
        id: modelNameDialog
        title: qsTr("Choose model name")
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        Row {
            id: mndrow
            spacing: 5
            Label {text: qsTr("Model name: ");anchors.verticalCenter: tf.verticalCenter}
            TextField {
                id:tf
                text: modelName
                validator: RegExpValidator {regExp:/^[-\w^&'@{}[\],$=!#().%+~][-\w^&'@{}[\],$=!#().%+~ ]+$/}
            }
            Label {text: ".tmm";anchors.verticalCenter: tf.verticalCenter}
        }
        onAccepted: {if (tf.text.length > 0) modelName = tf.text}
    }

    Dialog {
        id : robotIpDialog
        title: qsTr("Set robot ip")
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        property string ip: "192.168.1.1"

        onAccepted: {if (ipField.text) ip = ipField.text; mainwindow.ipChanged(ip); console.debug(ip)}

        TextField {
            id: ipField
            placeholderText: "192.168.1.1"
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            validator: RegExpValidator {
                regExp: /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
            }
        }
    }

    Dialog {
        id: addScriptDialog
        title: qsTr("Choose block")
        standardButtons: StandardButton.Ok | StandardButton.Cancel

        property string path : ""
        property var block: null;

        ComboBox {
            id : myComboBox
            model : registeredBlocks
        }

        onAccepted : {
            console.debug(registeredBlocks)
            console.debug(myComboBox.currentIndex)
            console.debug(myComboBox.textAt(myComboBox.currentIndex))
            addBlock(registeredBlocks[myComboBox.currentIndex],path);
            path = "";
        }

    }

    Item {
        width: parent.width
        height: parent.height

        BlocksView {
            id: blockModelView
            width: parent.width//540
            height: parent.height - buttons.height//720
            model: blockModel
            clip: true
            onRemoveBlock: blockModel.removeRow(index)
            onAddBlock: {
                addScriptDialog.path = path;
                addScriptDialog.open();
            }
        }

        ButtonsGrid {
            id: buttons
            width: parent.width
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.rightMargin: 5
            anchors.bottomMargin: 5
            anchors.leftMargin: 5

            button1.onClicked: addScriptDialog.open()
            button3.onClicked: sendPressed(modelName)
            button4.onClicked: runPressed(modelName)
            button5.onClicked: stopPressed()
        }
    }
}
