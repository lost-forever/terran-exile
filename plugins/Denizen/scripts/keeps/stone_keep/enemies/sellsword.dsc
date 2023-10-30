sellsword:
    type: entity
    entity_type: piglin_brute
    mechanisms:
        custom_name: <green>Sellsword
        item_in_hand: golden_sword
        immune: true
        equipment:
            chestplate: golden_chestplate
            leggings: golden_leggings
            boots: golden_boots

#| This system is weirdly inconsistent.
#| Let's just call it a feature.
sellsword_fn:
    type: world
    debug: false
    events:
        after sellsword damaged by player:
        # Flee if health is under 25% but still alive
        - if not <context.entity.is_spawned> or <context.entity.health_percentage> > 25:
            - stop
        # Stop enemy attacking state
        - flag <context.entity> keep_enemy_data.fleeing expire:10s
        - define held_item <context.entity.item_in_hand>
        - adjust <context.entity> aggressive:false
        - adjust <context.entity> item_in_hand:air
        - attack <context.entity> cancel
        # Pick a fleeing location in the opposite direction of the player
        - define between <context.entity.location.sub[<player.location>].normalize>
        - define away <context.entity.location.add[<[between].mul[20]>]>
        - define surfaces <[away].find.surface_blocks.within[5.0]>
        - define location <[surfaces].random.if_null[<[away]>].above>
        - debugblock <[location]>
        # Flee towards location
        - ~walk <context.entity> <[location]>
        - adjust <context.entity> item_in_hand:<[held_item]>
        on entity_flagged:keep_enemy_data.fleeing targets player:
        - determine cancelled