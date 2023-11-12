custom_ability_events:
    type: world
    events:
        after player starts sneaking:
        - define ability <player.equipment_map.get[boots].flag[ability].if_null[null]>
        - stop if:<[ability].equals[null]>
        after player right clicks block with:item_flagged:ability.active:
        - ratelimit <player> 1t
        - define target <context.location.if_null[air]>
        - inject custom_ability_events.use_on
        after player right clicks entity with:item_flagged:ability.active:
        - ratelimit <player> 1t
        - define target <context.entity>
        - inject custom_ability_events.use_on
    check_and_fire:
    - if <player.has_flag[ability_data.using_tick]>:
        - stop
    - if <player.has_flag[ability_using.<[ability.id]>]>:
        - define duration <player.flag_expiration[ability_using.<[ability.id]>].from_now>
        - actionbar "<&[error]>Cooldown: <[duration].formatted>"
        - stop
    - customevent id:use_ability context:<[context]> save:event
    - if <entry[event].any_ran>:
        - flag <player> ability_data.using_tick expire:1t
        - flag <player> ability_using.<[ability.id]> expire:<[ability.active.cooldown]>
        - animate <player> animation:arm_swing
    use_on:
    - define ability <player.item_in_hand.flag[ability]>
    - define context <[ability].with[on].as[<[target]>]>
    - inject custom_ability_events.check_and_fire
