snow_soldier:
    type: entity
    entity_type: zombie
    mechanisms:
        custom_name: <aqua>Snow Soldier
        item_in_hand: stone_sword
        should_burn: false
        age: 0
        equipment:
            helmet: leather_helmet
            chestplate: leather_chestplate
            leggings: leather_leggings
            boots: leather_boots

snow_soldier_fn:
    type: world
    events:
        on player damaged by snow_soldier:
        - if <player.has_effect[slow]>:
            - determine <context.final_damage.mul[1.35]>

minion:
    type: entity
    entity_type: zombie
    mechanisms:
        custom_name: <aqua>Minion
        should_burn: false
        age: -24000
        equipment:
            leggings: leather_leggings
        potion_effects:
            1:
                type: slow
                amplifier: 1
                duration: 99999s
                particles: false

chillslug:
    type: entity
    entity_type: silverfish
    mechanisms:
        custom_name: <aqua>Chillslug
        health: 1.0

chillslug_fn:
    type: world
    effect:
    - cast slow amplifier:1 duration:15s hide_particles
    events:
        after chillslug damages player:
        - inject chillslug_fn.effect
        after player damages chillslug:
        - if <player.item_in_hand.material.name> == air:
            - inject chillslug_fn.effect

berserker:
    type: entity
    entity_type: husk
    mechanisms:
        custom_name: <aqua>Berserker
        item_in_hand: stone_axe
        age: 0
        equipment:
            helmet: leather_helmet
            leggings: iron_leggings
            boots: iron_boots
        potion_effects:
            1:
                type: speed
                amplifier: 2
                duration: 99999s
                particles: false

harbinger:
    type: entity
    entity_type: stray
    flags:
        keep_enemy:
            on_attack: 30s
    mechanisms:
        custom_name: <aqua>Harbinger
        item_in_hand: bow
        equipment:
            helmet: chainmail_helmet
            chestplate: chainmail_chestplate
            leggings: chainmail_leggings
            boots: chainmail_boots

harbinger_fn:
    type: world
    events:
        after harbinger damaged by projectile:
        - if <context.damager.is_player>:
            - cast darkness <context.damager> duration:8s amplifier:2 hide_particles
        after custom event id:keep_enemy_on_attack data:enemy_id:harbinger:
        - define enemies <util.random.int[3].to[5]>
        - define positions <context.entity.location.points_around_y[points=<[enemies]>;radius=1.5]>
        - foreach <[positions]> as:pos:
            # TODO: spawning
            - spawn <list[minion|chillslug].random> <[pos]>
            - playeffect effect:soul_fire_flame at:<[pos]> quantity:4

northern_knight:
    type: entity
    entity_type: zombie
    mechanisms:
        custom_name: <aqua>Northern Knight
        item_in_hand: diamond_sword
        should_burn: false
        age: 0
        equipment:
            helmet: iron_helmet
            chestplate: iron_chestplate
            leggings: iron_leggings
            boots: iron_boots
        potion_effects:
            1:
                type: slow
                amplifier: 1
                duration: 99999s
                particles: false
            2:
                type: increase_damage
                amplifier: 3
                duration: 99999s
                particles: false

northern_knight_fn:
    type: world
    events:
        after player damages northern_knight:
        - if <context.cause> != projectile:
            - stop
        - define vec <context.entity.location.sub[<player.location>].normalize.add[0,0.3,0]>
        - adjust <player> velocity:<[vec]>