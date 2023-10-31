aqua_affinity_proxy:
    type: data
    te$ability: true
    name: Aqua Affinity
    descriptions:
        base: Enhanced dexterity and lung capacity underwater.
        super: Fire has little effect on your skin.
    colors:
        primary: teal
        secondary: blue
        super: lime
    proxies:
        base:
            aqua_affinity: 1
            respiration: 3
        super:
            respiration: 4
            fire_protection: 4

aqua_affinity_proxy_2:
    type: data
    te$ability: true
    name: Aqua Affinity
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
