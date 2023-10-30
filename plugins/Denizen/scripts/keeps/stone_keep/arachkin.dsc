arachkin:
    type: entity
    entity_type: zombie_villager
    mechanisms:
        custom_name: <green>Arachkin
        should_burn: false
        age: -24000
        equipment:
            helmet: netherite_helmet
            boots: netherite_boots
        potion_effects:
            1:
                type: slow
                amplifier: 1
                duration: 99999s
                particles: false

arachkin_spider:
    type: entity
    entity_type: cave_spider
    mechanisms:
        custom_name: <green>Arachkin
        health_data: 24/24
        potion_effects:
            1:
                type: hunger
                amplifier: 0
                duration: 99999s
                particles: true

arachkin_morph:
    type: task
    definitions: enemy|morph
    script:
    # TODO: spawning
    - define location <[enemy].location>
    - remove <[enemy]>
    - spawn <[morph]> <[location]> save:entity
    - playeffect effect:redstone at:<[location]> quantity:15 special_data:1|white
    - determine <entry[entity].spawned_entity>

arachkin_fn:
    type: world
    events:
        on entity_flagged:!keep_enemy_data.morphed damaged by player type:arachkin:
        - determine passively cancelled
        - run arachkin_morph def:<context.entity>|arachkin_spider save:morph
        - attack <entry[morph].created_queue.determination> target:<player>
        after arachkin_spider damages player:
        - cast hunger amplifier:1 duration:10s
        on arachkin_spider damaged:
        # If the spider would die from this hit
        - if <context.entity.health> > <context.final_damage>:
            - stop
        - run arachkin_morph def:<context.entity>|arachkin save:morph
        - flag <entry[morph].created_queue.determination> keep_enemy_data.morphed