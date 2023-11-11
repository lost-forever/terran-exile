ignition_fn:
    type: world
    events:
        on *iron_ore|*copper_ore|*gold_ore|ancient_debris drops item from breaking:
        - stop if:!<player.item_in_hand.has_flag[ability.ignition_ability]>
        - determine passively cancelled
        - define item <context.drop_entities.first.item>
        # Query script data and pick smelting result
        - define drop <script.data_key[data].get[<[item].material.name>]>
        - stop if:<[drop].equals[null]>
        - define quantity <[item].quantity>
        # Small chance when supercharged to double yield
        - if <player.item_in_hand.flag[ability.level]> == super and <util.random_chance[25]>:
            - define quantity:*:2
            - playsound <context.location> sound:block_campfire_crackle
        # Adjusting 'quantity' on the item directly to combine them into one entity immediately
        - drop <[drop].as[item].with[quantity=<[quantity]>]> <context.location.center>
        - playeffect effect:flame at:<context.location.center> quantity:<util.random.int[2].to[5]> offset:0.4,0.4,0.4
        - playsound <context.location> sound:block_furnace_fire_crackle if:<util.random_chance[20]>
    data:
        raw_iron: iron_ingot
        raw_copper: copper_ingot
        raw_gold: gold_ingot
        ancient_debris: netherite_scrap

shadow_fn:
    type: world
    events:
        after custom event id:use_ability data:id:shadow_ability:
        - define duration 15s
        - if <context.level> == super:
            - define duration 20s
            - cast speed duration:20s amplifier:1 hide_particles
            - flag <player> ability_data.shadow_invulnerable expire:5s
        - else:
            - flag <player> ability_data.shadow_particles expire:15s
        - cast invisibility duration:<[duration]> hide_particles
        - playeffect effect:spell_mob_ambient at:<player.location> quantity:100 velocity:255,0,0
        - playsound <player.location> sound:entity_phantom_ambient
        - playsound <player.location> sound:block_brewing_stand_brew
        - flag <player> ability_data.shadow_invisible expire:<[duration]>
        - adjust <player> hide_from_players:true
        - wait <[duration]>
        - adjust <player> show_to_players:true
        on player damaged flagged:ability_data.shadow_invulnerable:
        - determine cancelled
        after player steps on block flagged:ability_data.shadow_particles chance:15:
        - playeffect effect:soul_fire_flame at:<context.location>
        after player damages player:
        - if <context.damager.has_flag[ability_data.shadow_invisible]>:
            - adjust <player> show_to_players:true
            - flag <context.damager> ability_data.shadow_invisible:!

