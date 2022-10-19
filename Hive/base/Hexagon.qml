// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import Hive 1.0

Item {
    id: control

    property alias color: effect.color
    property alias strokeColor: effect.sc

    property real radius: 0
    property real strokeWidth: 0
    readonly property real _min: Math.min(width, height * 1.175);
    ShaderEffect {
        id: effect
        width: control._min
        height: 0.85 * width

        property color sc: '#000'
        property color color: '#fff'
        property real rad: Hive.clamp(0, mx/2, control.radius)/mx

        readonly property real mx: Math.max(width, height);
        readonly property real sw: Hive.clamp(control.strokeWidth, 0, mx)/mx/2
        readonly property vector2d ratio: {
            var h = height, w = width;
            Qt.vector2d(w/mx, h/mx);
        }

        fragmentShader: "qrc:/Hive/shader/hexagon.glsl"
    }
}
