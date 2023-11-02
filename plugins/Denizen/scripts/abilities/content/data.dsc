aqua_affinity_ability:
    type: data
    te$ability: true
    name: Aqua Affinity
    slots:
    - helmet
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
    slots:
    - main_hand
    - offhand
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
