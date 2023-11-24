#| Adapted from ExperienceCommand.XP_FOR_NEXT_LEVEL
exp_for_next_level:
    type: procedure
    definitions: level
    script:
    - define level:+:10
    - if <[level]> >= 30:
        - determine <[level].sub[30].mul[9].add[112]>
    - if <[level]> >= 15:
        - determine <[level].sub[15].mul[5].add[37]>
    - determine <[level].mul[2].add[7]>

_exp_give_extra:
    type: task
    definitions: amount
    script:
    - flag <player> exp.extra:+:<[amount]>
    - narrate <player.flag[exp]>
    - if not <player.has_flag[exp.archon]> or <player.flag[exp.extra]> < <player.flag[exp.next]>:
        - stop
    - flag <player> exp.extra:0
    - flag <player> exp.streak:++
    - flag <player> exp.next:<player.flag[exp.streak].proc[exp_for_next_level]>
    - define level <player.flag[exp.streak].div[15].truncate.add[1].min[3]>
    - run archon_apply_rewards def.archon:<player.flag[exp.archon]> def.level:<[level]>

exp_give:
    type: task
    definitions: amount
    script:
    - if not <player.has_flag[exp]>:
        - flag <player> exp:<map[value=0;extra=0;streak=0;next=7]>
    - if <player.flag[exp.value]> >= 256:
        - run _exp_give_extra def:<[amount]>
    - else:
        - flag <player> exp.value:+:<[amount]>
        - if <player.flag[exp.value]> > 256:
            - flag <player> exp.value:256
    - adjust <player> fake_experience:<player.flag[exp.value].div[256].min[0.99]>

exp_take:
    type: task
    definitions: amount
    script:
    - narrate "Hello, world!"

exp_listener:
    type: world
    events:
        on player absorbs experience:
        - determine passively cancelled
        - adjust <player> fake_pickup:<context.entity>
        - run exp_give def:<context.entity.experience>
        - remove <context.entity>
