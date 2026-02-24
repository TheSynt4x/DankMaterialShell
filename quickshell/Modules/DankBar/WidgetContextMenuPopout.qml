import QtQuick
import qs.Common
import qs.Services
import qs.Widgets

DankPopout {
    id: root

    property string widgetId: ""

    popupWidth: 160
    popupHeight: 44
    animationDuration: 150

    // Override the default popout mask to include the bar area,
    // so clicking the bar also closes the context menu.
    property real maskX: 0
    property real maskY: 0
    property real maskWidth: screen ? screen.width : 10000
    property real maskHeight: screen ? screen.height : 10000

    onBackgroundClicked: close()

    onOpened: {
        PopoutManager.showPopout(root);
    }

    content: Component {
        Item {
            anchors.fill: parent

            Rectangle {
                anchors.fill: parent
                anchors.margins: Theme.spacingXS
                radius: Theme.cornerRadius
                color: confArea.containsMouse ? Qt.rgba(Theme.primary.r, Theme.primary.g, Theme.primary.b, 0.12) : "transparent"

                Row {
                    anchors.centerIn: parent
                    spacing: Theme.spacingS

                    DankIcon {
                        name: "settings"
                        size: 16
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    StyledText {
                        text: I18n.tr("Configure")
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.surfaceText
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                MouseArea {
                    id: confArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        PopoutService.openSettingsToWidget(root.widgetId);
                        root.close();
                    }
                }
            }
        }
    }
}
