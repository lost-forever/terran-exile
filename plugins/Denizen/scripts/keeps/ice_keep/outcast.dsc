outcast:
    type: entity
    entity_type: wither_skeleton
    flags:
        keep_enemy:
            attacks:
                potions:
                    delay: 5s
                    interval: 10s
                skulls:
                    delay: 1s
                    interval: 3s
    mechanisms:
        custom_name: <aqua>Outcast
        item_in_hand: wither_skeleton_skull
        item_in_offhand: wither_skeleton_skull
        equipment:
            helmet: leather_helmet[color=black]
            chestplate: leather_chestplate[color=black]
            leggings: leather_leggings[color=black]
            boots: leather_boots[color=black]
        potion_effects:
            1:
                type: slow
                amplifier: 255
                duration: 99999s
                particles: false

outcast_fn:
    type: world
    events:
        on entity knocks back outcast:
        - determine cancelled
        on *arrow hits entity:outcast:
        - determine passively cancelled
        - definemap potion_effects:
            1:
                type: slowness
                upgraded: false
                extended: false
            2:
                type: wither
                amplifier: 1
                duration: 10s
                particles: true
        - define potion potion[potion_effects=<[potion_effects]>]
        - adjust <context.projectile> potion:<[potion]>

outcast_attacks:
    type: world
    events:
        after custom event id:keep_enemy_attack data:enemy_id:outcast data:name:potions:
        - definemap potion_effects:
            1:
                type: slowness
                upgraded: false
                extended: true
        - define potion splash_potion[potion=lingering_potion[potion_effects=<[potion_effects]>]]
        # Random angle in radians (0-2pi)
        - define angle <util.random.decimal[0.0].to[<util.pi.mul[2]>]>
        # Random point in a 6-block radius around Outcast enemy
        - define dest <context.entity.location.add[<location[6.0,0,0].rotate_around_y[<[angle]>]>]>
        - shoot <[potion]> origin:<context.entity> height:1.5 destination:<[dest]>
        after custom event id:keep_enemy_attack data:enemy_id:outcast data:name:skulls:
        - stop