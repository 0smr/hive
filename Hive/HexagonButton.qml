// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
//import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15 as T

T.Button {
    id: control

    property alias radius: background.radius

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                implicitContentHeight + topPadding + bottomPadding)

    height: width * 0.85106

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: palette.buttonText

    display: T.Button.TextOnly

    Component.onCompleted: { this.containmentMask = mask }

    QtObject {
        id: mask
        function contains(point: point) : bool {
            const w = control.width, h = control.height;
            const u = Qt.point(point.x - w/2, point.y - h/2);
            return Math.sqrt(u.x*u.x + u.y*u.y) < h * 0.5;
        }
    }

    contentItem: Item {
        Grid {
            anchors.centerIn: parent
            spacing: control.display == T.Button.TextOnly ||
                     control.display == T.Button.IconOnly ? 0 : control.spacing

            flow: control.display == T.Button.TextUnderIcon ?
                      Grid.TopToBottom : Grid.LeftToRight
            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down || control.checked ? 0.8 : 1.0

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
                    control.highlighted ? palette.highlightedText : palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: Hexagon {
        id: background
        visible: control.enabled

        implicitWidth: 65
        implicitHeight: implicitWidth * 0.85106

        radius: 5
        opacity: control.flat ? 0.7 : 1.0
        strokeWidth: 1

        color: Hive.alpha(strokeColor, control.down ? 0.3 : 0.4)
        strokeColor: {
            const  _color =  control.highlighted ? palette.highlight : palette.button
            control.down ? Qt.lighter(_color, 1.1) : _color
        }

        Hexagon {
            x: (parent.width  - width + 1)/2
            y: (parent.height - height)/2

            width: parent.width - (control.checked ? 6 : 0)
            height: parent.height - (control.checked ? 6 : 0)
            visible: control.checked

            color: 'transparent'
            strokeColor: parent.strokeColor
            strokeWidth: 1
            radius: 3

            Behavior on width { NumberAnimation { duration: 100 }}
            Behavior on height { NumberAnimation { duration: 100 }}
        }
    }
}
