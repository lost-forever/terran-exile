ignition_fn:
    type: world
    events:
        on *iron_ore|*copper_ore|*gold_ore|ancient_debris drops item from breaking:
        - define level <player.proc[entity_get_ability_level].context[ignition_ability]>
        - if <[level]> == null or <context.drop_entities.is_empty>:
            - stop
        - determine passively cancelled
        - define material <context.drop_entities.first.item.material>
        - define drop <script[ignition_fn].data_key[data].get[<[material].name>]>
        - define drops <[drop].repeat_as_list[<context.drop_entities.size>]>
        - if <[level]> == super:
            # Double the list
            - define drops <[drops].include[<[drops]>]>
        - drop <[drops]> <context.location.center>
    data:
        raw_iron: iron_ingot
        raw_copper: copper_ingot
        raw_gold: gold_ingot
        ancient_debris: netherite_scrap
