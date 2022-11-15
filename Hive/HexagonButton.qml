// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15

Button {
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

    display: Button.TextOnly

    Component.onCompleted: { this.containmentMask = mask }

    QtObject {
        id: mask
        function contains(point: point) : bool {
            const w = control.width, h = control.height;
            const u = Qt.point(point.x - w/2, point.y - h/2);
            return Math.sqrt(u.x*u.x + u.y*u.y) < h * 0.5;
        }
    }

    background: Hexagon {
        id: background
        visible: control.enabled

        implicitWidth: 65
        implicitHeight: implicitWidth * 0.85106

        radius: 5
        strokeWidth: control.flat ? 0 : 1

        color: Hive.alpha(strokeColor, control.down ? 0.1 : 0.2)
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
