keep_enemy_attack_context:
    type: procedure
    definitions: enemy[The enemy entity]
    script:
    # Standard attack event context
    - determine <map[enemy_id=<[enemy].script.name>;entity=<[enemy]>]>

keep_enemy_attack_valid:
    type: procedure
    debug: false
    definitions: enemy|id
    script:
    # Both the target player and the enemy must be alive and present
    - if not <player.is_online> or not <[enemy].is_spawned>:
        - determine false
    # The enemy must have a target player
    - if not <[enemy].target.exists>:
        - determine false
    # The enemy's stored target session ID must match with this loop
    # This also guarantees that the target player is the same
    - if <[enemy].flag[keep_enemy_data.loop_id].if_null[null]> != <[id]>:
        - determine false
    # The enemy and the player must be in the same world
    - if <[enemy].world> != <player.world>:
        - determine false
    - determine true

keep_enemy_attack_loop:
    type: task
    debug: false
    definitions: enemy|attack|data|id
    script:
    # One-off wait if the attack specifies a 'delay'
    - if <[data].contains[delay]>:
        - wait <[data.delay]>
    # Custom event context to re-use in the loop
    - define context <[enemy].proc[keep_enemy_attack_context].with[name=<[attack]>]>
    # While this target session is still valid, emit the attack event
    # and wait for the specified duration
    - while <[enemy].proc[keep_enemy_attack_valid].context[<[id]>]>:
        - customevent id:keep_enemy_attack context:<[context]>
        - wait <[data.interval]>

keep_enemy_handler:
    type: world
    debug: false
    events:
        after entity_flagged:keep_enemy.attacks targets player because closest_player|custom:
        # Target session ID. Prevents multiple attack loops for a player
        # running at the same time.
        - define loop_id <util.random_uuid>
        - flag <context.entity> keep_enemy_data.loop_id:<[loop_id]>
        # Loop over keep enemy's attack data and start an attack loop for each entry
        - foreach <context.entity.flag[keep_enemy.attacks]> key:attack as:data:
            - run keep_enemy_attack_loop def:<context.entity>|<[attack]>|<[data]>|<[loop_id]>
        after entity_flagged:keep_enemy.on_attack damaged by player type:!entity_flagged:keep_enemy_data.attacked:
        # Expire according to specified duration
        - flag <context.entity> keep_enemy_data.attacked expire:<context.entity.flag[keep_enemy.on_attack]>
        - define context <context.entity.proc[keep_enemy_attack_context]>
        - customevent id:keep_enemy_on_attack context:<[context]>