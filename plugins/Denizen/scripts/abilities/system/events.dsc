custom_ability_events:
    type: world
    events:
        after player starts sneaking:
        - define ability <player.equipment_map.get[boots].flag[ability].if_null[null]>
        - stop if:<[ability].equals[null]>
        after player right clicks block with:item_flagged:ability.active:
        - define target <context.location.if_null[air]>
        - inject custom_ability_events.use_on
        after player right clicks entity with:item_flagged:ability.active:
        - define target <context.entity>
        - inject custom_ability_events.use_on
    check_cooldown:
    - define ability <player.item_in_hand.flag[ability]>
    - if <player.has_flag[ability_using.<[ability.id]>]>:
        - define duration <player.flag_expiration[ability_using.<[ability.id]>].from_now>
        - actionbar "<&[error]>Cooldown: <[duration].formatted>"
        - stop
    - flag <player> ability_using.<[ability.id]> expire:<[ability.active.cooldown]>
    use_on:
    - inject custom_ability_events.check_cooldown
    - animate <player> animation:arm_swing
    - customevent id:use_ability context:<[ability].with[on].as[<[target]>]>
