// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                implicitContentHeight + topPadding + bottomPadding)

    property alias radius: background.radius

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: palette.buttonText

    display: T.Button.TextOnly

    contentItem: Item {
        Grid {
            anchors.centerIn: parent
            spacing: control.display == T.Button.TextOnly ||
                     control.display == T.Button.IconOnly ? 0 : control.spacing

            flow: control.display == T.Button.TextUnderIcon ?
                      Grid.TopToBottom : Grid.LeftToRight
            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down ? 0.8 : 1.0

            Image {
                visible: control.display != T.Button.TextOnly
                source: control.icon.source
                width: control.icon.width
                height: control.icon.height
                cache: control.icon.cache
            }

            Text {
                visible: control.display != T.Button.IconOnly
                text: control.text
                font: control.font
                color: !control.enabled ? 'gray' :
                    control.highlighted ? palette.highlightedText :
                                          palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: Rectangle {
        id: background
        visible: control.enabled

        implicitWidth: 45
        implicitHeight: 45

        radius: 5
        border.width: control.flat ? 0 : 1

        color: Hive.alpha(border.color, control.down ? 0.3 : 0.4)
        border.color: {
            const  _color =  control.highlighted ? palette.highlight : palette.button
            control.down ? Qt.lighter(_color, 1.1) : _color
        }

        Rectangle {
            x: (control.width  - width)/2
            y: (control.height - height)/2

            width: parent.width - (control.checked ? 6 : 0)
            height: parent.height - (control.checked ? 6 : 0)
            visible: control.checked

            color: 'transparent'
            border.color: parent.border.color
            radius: 3

            Behavior on width { NumberAnimation { }}
            Behavior on height { NumberAnimation { }}
        }
    }
}
