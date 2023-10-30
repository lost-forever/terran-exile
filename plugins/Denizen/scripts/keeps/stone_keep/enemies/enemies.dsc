bandit:
    type: entity
    entity_type: zombie
    mechanisms:
        custom_name: <green>Bandit
        item_in_hand: iron_pickaxe
        should_burn: false
        age: 0
        equipment:
            helmet: leather_helmet
            chestplate: leather_chestplate
            leggings: leather_leggings
            boots: leather_boots

bandit_fn:
    type: world
    events:
        after player damaged by bandit:
        - if <context.damage_type_map.get[blocking]> >= 0:
            - stop
        - if <player.item_in_hand.material.name> == shield:
            - inventory adjust slot:hand durability:<player.item_in_hand.durability.add[10]>
        - else if <player.item_in_offhand.material.name> == shield:
            - inventory adjust slot:offhand durability:<player.item_in_offhand.durability.add[10]>

defender:
    type: entity
    entity_type: skeleton
    mechanisms:
        custom_name: <green>Defender
        equipment:
            helmet: iron_helmet
            leggings: iron_leggings
            boots: iron_boots
        potion_effects:
            1:
                type: slow
                amplifier: 255
                duration: 99999s
                particles: false

fastaxe:
    type: entity
    entity_type: zombie
    flags:
        keep_enemy:
            on_attack: 15s
    mechanisms:
        custom_name: <green>Fastaxe
        item_in_hand: wooden_axe
        should_burn: false
        age: 0
        equipment:
            helmet: chainmail_helmet
            chestplate: chainmail_chestplate
            leggings: chainmail_leggings
            boots: chainmail_boots
        potion_effects:
            1:
                type: speed
                amplifier: 5
                duration: 99999s
                particles: false

fastaxe_fn:
    type: world
    events:
        after custom event id:keep_enemy_on_attack data:enemy_id:fastaxe:
        - define entities <context.entity.location.find_entities[!player].within[5.0].exclude[<context.entity>]>
        - cast speed <[entities]> duration:10s amplifier:0 no_clear

ghost:
    type: entity
    entity_type: stray
    mechanisms:
        custom_name: <green>Ghost
        item_in_hand: air

ghost_fn:
    type: world
    events:
        on ghost combusts:
        - if <context.source_type> == none:
            - determine cancelled
        after ghost damages player:
        - cast darkness amplifier:1 duration:3s
        after ghost damages player chance:5:
        - define item <player.item_in_hand>
        - take iteminhand
        - drop <[item]> <context.entity.location> delay:1.5s
        after player damages ghost chance:15:
        - if <context.entity.is_spawned>:
            - cast invisibility <context.entity> duration:10s

tyrants_guard:
    type: entity
    entity_type: husk
    mechanisms:
        custom_name: <green>Tyrant's Guard
        item_in_hand: diamond_sword
        item_in_offhand: shield
        should_burn: false
        health_data: 40/40
        age: 0
        equipment:
            helmet: diamond_helmet
            chestplate: diamond_chestplate
            leggings: diamond_leggings
            boots: diamond_boots
        potion_effects:
            1:
                type: slow
                amplifier: 3
                duration: 99999s
                particles: false

tyrants_guard_fn:
    type: world
    events:
        on entity knocks back tyrants_guard:
        - determine cancelled
        after tyrants_guard damaged by player chance:60:
        - define vec <player.location.sub[<context.entity.location>].normalize>
        - adjust <player> velocity:<[vec].mul[0.5].add[0,0.1,0]>