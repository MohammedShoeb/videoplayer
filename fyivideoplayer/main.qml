import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    id: root
    anchors.fill: parent


    Loader {
        id: contentLoader
        anchors.fill: parent
        source: "qrc:/VideoSelectionScreen.qml"
    }

    Connections {
        target: FilePathMessenger

        function onVideoUrlSelected() {
            contentLoader.source = "qrc:/VideoScreen.qml";
        }
    }

}
