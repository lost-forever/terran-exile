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
            from: <color[#2bc2a1]>
            to: <color[#30b1d9]>
        proxies:
            aqua_affinity: 1
            respiration: 3
    super:
        description:
        - Enhanced dexterity and lung capacity underwater.
        - Fire has little effect on your skin.
        colors:
            from: <color[#5149e6]>
            to: white
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
            from: <color[#a83232]>
            to: <color[#ff6600]>
            style: rgb
    super:
        description:
        - Blasts ore materials on contact with high yield.
        colors:
            from: <color[#ff2200]>
            to: <color[#faff9c]>
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
            from: <color[#c7a6a3]>
            to: <color[#4d403f]>
        active:
            cost: 15

cryonics_ability:
    type: data
    te$ability: true
    name: Cryonics
    icon: snowball
    slots:
    - hand
    base:
        description:
        - Freeze an enemy in place.
        colors:
            from: <color[#5dabe3]>
            to: white
            style: rgb
        active:
            cost: 20
            cooldown: 15s
    super:
        description:
        - Freeze many enemies in place.
        colors:
            from: <color[#645abf]>
            to: <color[#3bffc7]>
        active:
            cooldown: 30s
