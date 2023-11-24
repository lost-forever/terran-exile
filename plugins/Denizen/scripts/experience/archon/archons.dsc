archon_get_rewards:
    type: procedure
    definitions: archon[The archon data script]
    script:
    - define rewards <[archon].data_key[rewards]>
    - define item <[rewards.items].random.as[item].if_null[null]>
    - define effect <[rewards.effects].random.if_null[null]>
    - determine <map[item=<[item]>;effect=<[effect]>]>

archon_apply_rewards:
    type: task
    definitions: archon[The archon data script] | level[The reward level]
    script:
    - define rewards <[archon].proc[archon_get_rewards]>
    - if <[rewards.item]> != null:
        - give <[rewards.item]> quantity:<[level]>
        - playsound <player> sound:entity_item_pickup volume:0.5
    - if <[rewards.effect]> != null:
        - cast <[rewards.effect]> amplifier:<[level].sub[1]> duration:30s
        - playsound <player> sound:block_brewing_stand_brew volume:0.5

exp_archon_activation:
    type: world
    events:
        after player right clicks material_flagged:exp.podium_altar with:material_flagged:exp.podium_offering:
        # Check if altar is currently being used
        - stop if:<context.location.has_flag[exp.altar_using]>
        # Check if offering and podium have matching archons
        - define archon <context.item.material.flag[exp.podium_offering]>
        - if <[archon]> != <context.location.material.flag[exp.podium_altar]>:
            - stop
        # Check if player already has this archon activated
        - stop if:<player.flag[exp.archon].equals[<[archon]>].if_null[false]>
        # Check the podium block structure
        - define matchers <[archon].data_key[podium].reverse.get[2].to[last]>
        - foreach <[matchers]> as:matcher:
            - define block <context.location.below[<[loop_index]>]>
            - if <[block].material> not matches <[matcher]>:
                - stop
        # Spawn item display entity above altar
        - define center <context.location.center.above[0.5]>
        - spawn item_display[item=<context.item>;scale=0.75,0.75,0.75] <[center]> save:spawned
        - define entity <entry[spawned].spawned_entity>
        # Prevent multiple simultaneous altar uses
        - flag <context.location> exp.altar_using expire:80t
        # Effects for placing offering on altar
        - animate <player> animation:arm_swing
        - take iteminhand
        - playsound <context.location> sound:block_end_portal_frame_fill pitch:<util.random.decimal[0.25].to[0.4]>
        - playsound <context.location> sound:block_beacon_activate pitch:<util.random.decimal[0.6].to[0.8]>
        - playeffect effect:soul_fire_flame at:<[center]> quantity:<util.random.int[5].to[10]> offset:0.5,0.5,0.5
        # Rotation loop for item entity (exponential)
        - define sounds <[archon].data_key[altar_sounds]>
        - repeat 80 as:n:
            - adjust <[entity]> interpolation_duration:1t
            - adjust <[entity]> interpolation_start:0t
            - adjust <[entity]> left_rotation:<location[0,1,0].to_axis_angle_quaternion[<util.tau.mul[<[n].div[50].power[3]>]>]>
            # As item rotation gets faster, more chance of rotat sound
            - define progress <[n].div[80].power[2]>
            - if <util.random_chance[<[progress].mul[100]>]>:
                - playsound <context.location> sound:<[sounds].random> pitch:<util.random.decimal[1.0].to[1.2]> volume:<[progress].max[0.3]>
            - wait 1t
        # Submit offering
        - remove <entry[spawned].spawned_entity>
        - flag <player> exp.archon:<[archon]>
        - playsound <context.location> sound:entity_generic_explode pitch:<util.random.decimal[0.3].to[0.7]>
        - playsound <context.location> sound:entity_lightning_bolt_thunder pitch:0.5
        - playsound <context.location> sound:block_beacon_power_select pitch:<util.random.decimal[0.9].to[1.1]>
        - playeffect effect:explosion_large at:<[center]> quantity:2
        - playeffect effect:ender_signal at:<[center]> quantity:1 offset:1
        - title subtitle:<[archon].parsed_key[name]> fade_in:0s
