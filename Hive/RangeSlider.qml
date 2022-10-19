// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

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

    component Handler: Hexagon {
        property real vpos: 0
        x: control.leftPadding + (control.horizontal ? vpos * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (!control.horizontal ? vpos * (control.availableHeight - height) : (control.availableHeight - height) / 2)

        implicitWidth: 20
        implicitHeight: implicitWidth * 0.85106

        radius: 2

        strokeColor: palette.button
        // TODO: Make actual transparency similar to Slider.
        color: Hive.blend(palette.button, palette.window)
        Behavior on strokeWidth { NumberAnimation {} }
    }

    first.handle: Handler {
        vpos: control.first.visualPosition
        strokeWidth: activeFocus ? width : 1
    }

    second.handle: Handler {
        vpos: control.second.visualPosition
        strokeWidth: activeFocus ? width : 1
    }

    background: Rectangle {
        x: (control.width - width) / 2
        y: (control.height - height) / 2

        implicitWidth: !control.vertical ? 200 : 1
        implicitHeight: control.vertical ? 200 : 1

        width: !control.vertical ? control.availableWidth : implicitWidth
        height: control.vertical ? control.availableHeight : implicitHeight

        radius: width
        color: palette.button
    }
}
