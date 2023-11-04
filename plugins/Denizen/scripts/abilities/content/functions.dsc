ignition_fn:
    type: world
    events:
        on player breaks *iron_ore|*copper_ore|*gold_ore|ancient_debris with:item_flagged:ability.ignition_ability:
        - define level <player.item_in_hand.flag[ability.level]>
        - flag <context.location> ignition_query:<[level]>
        on block drops item from breaking location_flagged:ignition_query:
        - determine passively cancelled
        - define item <context.drop_entities.first.item>
        - define drop <script[ignition_fn].data_key[data].get[<[item].material.name>].as[item]>
        - define quantity <[item].quantity>
        # Small chance when supercharged to double yield
        - if <context.location.flag[ignition_query]> == super and <util.random_chance[25]>:
            - define quantity:*:2
            - playsound <context.location> sound:block_campfire_crackle
        # Adjusting 'quantity' on the item directly to combine them into one entity immediately
        - drop <[drop].with[quantity=<[quantity]>]> <context.location.center>
        - playeffect effect:flame at:<context.location.center> quantity:<util.random.int[2].to[5]> offset:0.4,0.4,0.4
        - playsound <context.location> sound:block_furnace_fire_crackle if:<util.random_chance[20]>
    data:
        raw_iron: iron_ingot
        raw_copper: copper_ingot
        raw_gold: gold_ingot
        ancient_debris: netherite_scrap
