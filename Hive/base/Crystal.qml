// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// http://smr76.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

import Hive 1.0

ShaderEffect {
    id: control

    property real radius: 0.2
    property real strokeWidth: 1

    property color color: Hive.alpha(palette.button, 0.2)
    property color strokeColor: palette.button

    property vector4d corners: Qt.vector4d(10, 10, 10, 10)

    readonly property real _min: Math.min(width, height)
    readonly property real _sw: strokeWidth/_min
    readonly property vector4d _c: corners.times(1/_min)
    readonly property real _radius: {
        const max = Math.min(_c.x,_c.y,_c.z,_c.w);
        Math.min(radius, max * 2., 2 - max * 2.);
    }

    fragmentShader: "qrc:/Hive/shader/crystal.glsl"
}
