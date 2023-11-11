aqua_affinity_ability:
    type: data
    te$ability: true
    name: Aqua Affinity
    slots:
    - armor
    base:
        description:
        - Enhanced dexterity and lung capacity underwater.
        colors:
            from: teal
            to: blue
        proxies:
            aqua_affinity: 1
            respiration: 3
    super:
        description:
        - Enhanced dexterity and lung capacity underwater.
        - Fire has little effect on your skin.
        colors:
            from: teal
            to: lime
        proxies:
            respiration: 4
            fire_protection: 4

ignition_ability:
    type: data
    te$ability: true
    name: Ignition
    icon: blaze_powder
    slots:
    - hand
    base:
        description:
        - Smelts ore materials on contact.
        colors:
            from: orange
            to: red
    super:
        description:
        - Blasts ore materials on contact with high yield.
        colors:
            from: red
            to: yellow
        proxies:
            efficiency: 3

shadow_ability:
    type: data
    te$ability: true
    name: Shadow
    icon: ender_eye
    slots:
    - hand
    base:
        description:
        - Become highly invisible.
        colors:
            from: <&ns>999999
            to: <&ns>575757
        active:
            cost: 20
            cooldown: 20s
    super:
        description:
        - Become truly invisible; one with the shadows.
        colors:
            from: <&ns>c7a6a3
            to: <&ns>4d403f
        active:
            cost: 15
