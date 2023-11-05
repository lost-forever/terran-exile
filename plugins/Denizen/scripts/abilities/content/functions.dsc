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
