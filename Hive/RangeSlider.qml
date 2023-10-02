// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.RangeSlider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            first.implicitHandleWidth + leftPadding + rightPadding,
                            second.implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             first.implicitHandleHeight + topPadding + bottomPadding,
                             second.implicitHandleHeight + topPadding + bottomPadding)
    padding: 6

    component Line: Rectangle {
        x: first.handle.x - control.padding
        width: second.handle.x - first.handle.x; height: 1
        color: control.palette.button
    }

    component Handler: Crystal {
        property real vpos: 0
        x: control.leftPadding + (control.horizontal ? vpos * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (!control.horizontal ? vpos * (control.availableHeight - height) : (control.availableHeight - height) / 2)

        radius: 2

        implicitWidth: 8
        implicitHeight: implicitWidth * 2
        corners: Qt.vector4d(6, 6, radius, radius)

        strokeColor: control.palette.button
        color: Hive.blend(strokeColor, palette.window)
        Behavior on strokeWidth { NumberAnimation {} }
    }

    first.handle: Handler {
        vpos: control.first.visualPosition
        strokeWidth: activeFocus ? 2 : 1
    }

    second.handle: Handler {
        vpos: control.second.visualPosition
        strokeWidth: activeFocus ? 2 : 1
    }

    background: T.Control {
        implicitWidth: !control.vertical ? 200 : 1
        implicitHeight: control.vertical ? 200 : 1

        width: !vertical ? control.width : implicitWidth
        height: vertical ? control.height : implicitHeight + topPadding

        topPadding: control.topPadding
        leftPadding: control.padding + first.handle.width/2
        rightPadding: leftPadding

        contentItem: Rectangle {
            // TODO: Fix vertical mode
            color: Hive.alpha(control.palette.button, 0.5)
            Line {}
        }
    }
}
